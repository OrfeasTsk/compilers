package extras;

public class RegInfo extends Info {

    private String IRType; // Type of register for the IR
    private String exprType; // Expression type of register


    public RegInfo(String name, String IRType, String exprType) {
        super(name);
        this.IRType = IRType;
        this.exprType = exprType;
    }

    // GETTERS & SETTERS

    public String getIRType() {
        return this.IRType;
    }

    public void setIRType(String IRType) {
        this.IRType = IRType;
    }

    public String getExprType() {
        return this.exprType;
    }

    public void setExprType(String exprType) {
        this.exprType = exprType;
    }
}