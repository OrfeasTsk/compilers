package extras;

public class RegInfo extends Info {

    private String type; // Type of register

    public RegInfo(String name, String type) {
        super(name);
        this.type = type;
    }

    public String getIRType() {

        if(this.type.equals("int"))
            return "i32";
        else if(this.type.equals("int*") || type.equals("int[]"))
            return "i32*";
        else if(this.type.equals("int[]*"))
            return "i32**";
        else if(this.type.equals("boolean"))
            return "i1";
        else if(this.type.equals("boolean*"))
            return "i1**";
        else{
            if(this.type.contains("*")) 
                return "i8**";
            else
                return "i8*"; 
        }
    }

    // GETTERS & SETTERS


    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }


    
}