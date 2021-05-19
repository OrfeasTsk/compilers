package extras;

public class SemanticError extends Exception { 
    private String msg;

    public SemanticError(String errorMessage) {
        msg = "Error: " + errorMessage;
    }

    public String getMessage() {
        return msg;
    }
}