package extras;

public class ExprInfo extends Info {

    private String type;


    public ExprInfo(String name, String type) {
        super(name);
        this.type = type;
    }

    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }

}