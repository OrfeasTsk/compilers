package extras;

import java.util.Map;
import java.util.List;
import java.util.LinkedHashMap;
import java.util.ArrayList;

public class Scope {

    private Info info;       // Info for the scope
    private char type;       // 'c' = Class, 'f' = Function, 'g' = Global
    private Scope parentScope; // Parent scope
    private int currChild;   // Index of the next scope
    private List<Scope> childrenScopes; // All the children scopes
    private Map<String, VarInfo> variables; // Variable info
    private Map<String, FunInfo> functions; // Function info
    private Map<String, ClassInfo> classes;   // Class info

    public Scope(Info info, char type) {
        this.info = info;
        this.type = type;
        this.currChild = -1;
        this.parentScope = null;
        this.childrenScopes = new ArrayList<>();
        this.variables = new LinkedHashMap<>();
        this.functions = new LinkedHashMap<>();
        this.classes = new LinkedHashMap<>();
    }

    public Scope(char type) {
        this.info = new Info();
        this.type = type;
        this.currChild = -1;
        this.parentScope = null;
        this.childrenScopes = new ArrayList<>();
        this.variables = new LinkedHashMap<>();
        this.functions = new LinkedHashMap<>();
        this.classes = new LinkedHashMap<>();
    }


    public void addScope(Scope next) {
        this.childrenScopes.add(next);
    }

    public void changeScope() {
        this.currChild++;
    }

    public void addRecord(VarInfo info) throws SemanticError {
        String name = info.getName();
        if(!this.variables.containsKey(name))
            this.variables.put(name, info);
        else
            throw new SemanticError("Duplicate declaration of variable " + name);
    }

    public void addRecord(FunInfo info) throws SemanticError {
        String name = info.getName();
        if(!this.functions.containsKey(name))
            this.functions.put(name, info);
        else
            throw new SemanticError("Duplicate declaration of function " + name);
    }

    public void addRecord(ClassInfo info) throws SemanticError {
        String name = info.getName();
        if(!this.classes.containsKey(name))
            this.classes.put(name, info);
        else
            throw new SemanticError("Duplicate declaration of class " + name);
    }

    public VarInfo searchVar(String name) {
        return this.variables.get(name);
    }

    public FunInfo searchFun(String name) {
        return this.functions.get(name);
    }

    public ClassInfo searchClass(String name) {
        return this.classes.get(name);
    }

    public void print(){
        System.out.println("Name");
        System.out.println(this.info.getName());
        System.out.println("-------------");
        System.out.println("Variables");
        for (String key: this.variables.keySet()) {
            String value = this.variables.get(key).getType();
            System.out.println(value + " " + key);
        }
        System.out.println("-------------");
        System.out.println("Functions");
        for (String key: this.functions.keySet()) {
            String value = this.functions.get(key).getType();
            String str = value + " " + key + " --";
            for(VarInfo vInfo: this.functions.get(key).getParameters().values())
                str += " " + vInfo.getType() + " " + vInfo.getName();
            System.out.println(str);
        }
        System.out.println("-------------");
        System.out.println("Classes");
        for (String key: this.classes.keySet()) {
            String value = this.classes.get(key).getParentName();
            if(value != null)
                System.out.println(key + " extends " + value);
            else
                System.out.println(key);
        }
        System.out.println("-------------");
    }

    public int getChildrenNum(){
        return this.childrenScopes.size();
    }

    public Scope getChild(int index){
       return this.childrenScopes.get(index);
    }

    //GETTERS & SETTERS
    

    public Info getInfo() {
        return this.info;
    }

    public void setInfo(Info info) {
        this.info = info;
    }

    public char getType() {
        return this.type;
    }

    public void setType(char type) {
        this.type = type;
    }

    public Scope getParentScope() {
        return this.parentScope;
    }

    public void setParentScope(Scope parentScope) {
        this.parentScope = parentScope;
    }

    public int getCurrChild() {
        return this.currChild;
    }

    public void setCurrChild(int currChild) {
        this.currChild = currChild;
    }

    public List<Scope> getChildrenScopes() {
        return this.childrenScopes;
    }

    public void setChildrenScopes(List<Scope> childrenScopes) {
        this.childrenScopes = childrenScopes;
    }

    public Map<String,VarInfo> getVariables() {
        return this.variables;
    }

    public void setVariables(Map<String,VarInfo> variables) {
        this.variables = variables;
    }

    public Map<String,FunInfo> getFunctions() {
        return this.functions;
    }

    public void setFunctions(Map<String,FunInfo> functions) {
        this.functions = functions;
    }

    public Map<String,ClassInfo> getClasses() {
        return this.classes;
    }

    public void setClasses(Map<String,ClassInfo> classes) {
        this.classes = classes;
    }
}