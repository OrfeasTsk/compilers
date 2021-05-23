package extras;

public class RegInfo extends Info {

    private String IRType; // Type of register for the IR
    private ExprInfo exprInfo; // Expression info of register


    public RegInfo(String name, ExprInfo exprInfo) {
        super(name);
        this.exprInfo = exprInfo;
    }

    // GETTERS & SETTERS

    public String getIRType() {
        return this.IRType;
    }

    public void setIRType(String IRType) {
        this.IRType = IRType;
    }

    public ExprInfo getExprInfo() {
        return this.exprInfo;
    }

    public void setExprInfo(ExprInfo exprInfo) {
        this.exprInfo = exprInfo;
    }
}