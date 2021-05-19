package calculator;

import java.io.InputStream;
import java.io.IOException;

class Calculator {

    private final InputStream in;

    private int lookahead;
    private int exponent;


    public Calculator(InputStream in) throws IOException {
        this.in = in;
        lookahead = in.read();
    }


    private void consume(int symbol) throws IOException, ParseError {
        if (lookahead == symbol)
            lookahead = in.read();
        else
            throw new ParseError();
    }


    // Utility methods

    private boolean EOF(int c){
        return c == -1 || c == '\n' || c == '\r';
    }


    private boolean isDigit(int c) {
        return '0' <= c && c <= '9';
    }


    private boolean isNonZeroDigit(int c) {
        return '0' < c && c <= '9';
    }


    private int evalDigit(int c) {
        return c - '0';
    }

    private int pow(int base, int exponent) {
        if (exponent < 0)
            return 0;
        if (exponent == 0)
            return 1;
        if (exponent == 1)
            return base;    
    
        if (exponent % 2 == 0) //even exp -> b ^ exp = (b^2)^(exp/2)
            return pow(base * base, exponent/2);
        else                   //odd exp -> b ^ exp = b * (b^2)^(exp/2)
            return base * pow(base * base, exponent/2);
    }

    // Evaluation methods

    public int eval() throws IOException, ParseError {

        int value = Expr();

        if (!EOF(lookahead)) // EOF must follow the whole expr
            throw new ParseError();

        return value;
    }


    private int Expr() throws IOException, ParseError {

        if(isDigit(lookahead) || lookahead == '(') {
            int tVal = Term();
            return TermTail(tVal);
        }

        throw new ParseError();
    }


    private int TermTail(int preval) throws ParseError, IOException {

        if(lookahead == '+'){
            consume('+');
            int tVal = Term();
            return TermTail(preval + tVal); // Passing the addition of the current term and the previous term as argument of TermTail (left associativity)
        }
        else if(lookahead == '-'){
            consume('-');
            int tVal = Term();
            return TermTail(preval - tVal); // Passing the addition subtraction of the current term from the previous term as argument of TermTail (left associativity)
        }
        else if(lookahead == ')' || EOF(lookahead)) // End of TermTail parsing (epsilon rule)
            return preval;

        throw new ParseError();
    }


    private int Term() throws ParseError, IOException {

        if(isDigit(lookahead) || lookahead == '('){
            int fVal = Factor();
            return FactorTail(fVal);
        }

        throw new ParseError();
    }


    private int FactorTail(int preval) throws ParseError, IOException {

        if(lookahead == '*'){
            consume('*'); // Consuming the first '*'
            consume('*'); // Consuming the second '*'
            int fVal = Factor();
            int fTail = FactorTail(fVal);
            return pow(preval, fTail); // Exponentiation with base as the previous factor and exponent as the result of FactorTail (right associativity)
        }
        else if(lookahead == '+' || lookahead == '-' || lookahead == ')' || EOF(lookahead)) // End of FactorTail parsing (epsilon rule)
            return preval; // Nothing for exponentiation

        throw new ParseError();
    }


    private int Factor() throws ParseError, IOException {

        if(isDigit(lookahead)) // Factor is number
            return Number();
        else if(lookahead == '('){  // Factor is (expr)
            consume('(');
            int expr = Expr();
            consume(')');
            return expr; // Return of the value inside parentheses
        }

        throw new ParseError();
    }
    

    private int Number() throws ParseError, IOException {

        if (lookahead == '0'){ // Case of a single '0'
            consume('0');
            return 0;
        }
        else if(isNonZeroDigit(lookahead)){ // Leading zeros elimination
            int val = evalDigit(lookahead);
            consume(lookahead);
            return RestNum(val);
        }

        throw new ParseError();
    }


    private int RestNum(int preval) throws ParseError, IOException {

        if(isDigit(lookahead)){
            int val = evalDigit(lookahead);
            consume(lookahead);
            int rNum = RestNum(val);
            int rVal = pow(10,exponent) * preval + rNum;  // Multiplication of the current digit with the correct power of 10 and then addition to the previous sum in order to produce the whole number
            exponent++; // Increasing of the exponent
            return rVal;
        }
        else if(lookahead == '+' || lookahead == '-' ||  lookahead == '*'  ||  lookahead == ')' || EOF(lookahead)){   // End of RestNum parsing (epsilon rule)
            exponent = 1;   // Initialization of the exponent
            return preval;  // Initialization of sum that equals to the value of digit (last digit of the number)
        }

        throw new ParseError();
    }


}
