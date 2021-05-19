package extras;


public class Info {

    private String name;

    public Info(String name) {
        this.name = name;
    }

    public Info(){
        this.name = null;
    }

    //GETTERS & SETTERS

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

}