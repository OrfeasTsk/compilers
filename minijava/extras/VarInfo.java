package extras;

public class VarInfo extends Info {

    private String type;
    private int offset;

    public VarInfo(String name) {
        super(name);
        this.type = null;
        this.offset = -1;
    }

    public VarInfo(String name, String type) {
        super(name);
        this.type = type;
        this.offset = -1;
    }

    public boolean equals(VarInfo vInfo){
        if(!this.getName().equals(vInfo.getName())) // Different name
            return false;
        if(!this.type.equals(vInfo.getType())) // Different type
            return false;
        return true;
    }

    public String toString(){
        return this.getType() + " " + this.getName();
    }

    public boolean hasPrimType(){
        if(!this.type.equals("int") && !this.type.equals("boolean") && !this.type.equals("int[]") && !this.type.equals("String[]") && !this.type.equals("void"))
            return false;
        return true;
    }

    public String getIRType() {

        if(this.type.equals("int"))
            return "i32";
        else if(this.type.equals("boolean"))
            return "i8";
        else if(this.type.equals("int[]"))
            return "i32*";
        else
            return "i8*"; 
    }

    //GETTERS & SETTERS


    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getOffset() {
        return this.offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }
    
}