package extras;

import java.util.Map;
import java.util.LinkedHashMap;
import java.util.Iterator;


public class FunInfo extends Info{

    private int scopeIndex; // Scope index at previous scope 
    private Map<String, VarInfo> parameters;
    private String type;
    private FunInfo overridden;  // Function that is overriden by this function
    private int offset;

    public FunInfo(int index, String name) {
        super(name);
        this.scopeIndex = index;
        this.type = null;
        this.parameters = new LinkedHashMap<>();
        this.overridden = null;
        this.offset = -1;
    }

    public FunInfo(int index, String name, String type) {
        super(name);
        this.scopeIndex = index;
        this.type = type;
        this.parameters = new LinkedHashMap<>();
        this.overridden = null;
        this.offset = -1;
    }

    public FunInfo(int index, String name, String type, Map<String, VarInfo> parameters) {
        super(name);
        this.scopeIndex = index;
        this.type = type;
        this.parameters = parameters;  
        this.overridden = null;
        this.offset = -1;
    }

    public void addParameter(VarInfo parameter) throws SemanticError {
        String name = parameter.getName();
        if(!this.parameters.containsKey(name))
            this.parameters.put(parameter.getName(), parameter);
        else
            throw new SemanticError("Duplicate declaration of parameter " + parameter.getName());
    }

    public int getParamNum(){
        return this.parameters.size();
    }

    public VarInfo getParameter(String name){
        return this.parameters.get(name);
    }

    public boolean equals(FunInfo fInfo){ // ,SymbolTable symTable
        if(!this.getName().equals(fInfo.getName())) // Check for different name
            return false;
        /*if(!this.hasPrimType() && !fInfo.hasPrimType()){ // Both functions have non primitive return types
            if(!this.type.equals(fInfo.getType()) && !symTable.isSubType(this.type, fInfo.getType())) // Subtype check
                return false;
        }*/
        if(!this.type.equals(fInfo.getType()))  // Check for different type by name
            return false;
        if(this.getParamNum() != fInfo.getParamNum()) // Check for different size
            return false;
        

        Iterator<Map.Entry<String, VarInfo>> it1 = this.parameters.entrySet().iterator();
        Iterator<Map.Entry<String, VarInfo>> it2 = fInfo.getParameters().entrySet().iterator();

        while(it1.hasNext() && it2.hasNext()){ // Parallel check for different parameter types and order
            Map.Entry<String, VarInfo> par1 = it1.next();
            Map.Entry<String, VarInfo> par2 = it2.next();
            if(!par1.getValue().getType().equals(par2.getValue().getType()))
                return false;
        }

        return true;
    }


    public String toString(){
        String str = this.type + " " + this.getName() + "(";
        for(Map.Entry<String, VarInfo> entry: this.parameters.entrySet())
            str += entry.getValue().getType() + " " + entry.getValue().getName() + ", ";
        if(str.charAt(str.length() - 1) != '(')
            str = str.substring(0,str.length() - 2);
        str += ")";
        return str;
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


    public int getScopeIndex() {
        return this.scopeIndex;
    }

    public void setScopeIndex(int scopeIndex) {
        this.scopeIndex = scopeIndex;
    }

    public Map<String,VarInfo> getParameters() {
        return this.parameters;
    }

    public void setParameters(Map<String,VarInfo> parameters) {
        this.parameters = parameters;
    }

    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public FunInfo getOverridden() {
        return this.overridden;
    }

    public void setOverridden(FunInfo overridden) {
        this.overridden = overridden;
    }

    public int getOffset() {
        return this.offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }
    
}