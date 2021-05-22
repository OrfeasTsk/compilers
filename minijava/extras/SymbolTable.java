package extras;

import java.util.Map;
import java.util.List;
import java.io.PrintWriter;

public class SymbolTable {
    private Scope currScope; // The current scope

    public SymbolTable() {
        this.currScope = null;
    }

    public void enter(Scope newScope) throws Exception {
        newScope.setParentScope(this.currScope); // Set the current scope as the parent of the new scope 
        if(this.currScope != null){
            this.currScope.addScope(newScope);
            this.currScope.changeScope();
            this.visitNext();
        }
        else
            this.currScope = newScope;
    }

    public void enter() throws Exception {
        this.currScope.changeScope();
        this.visitNext();
    }

    public void exit() {
        this.currScope.setCurrChild(-1); // Restore for the next enter
        this.currScope = this.currScope.getParentScope(); 
    }

    public void insert(VarInfo vInfo) throws SemanticError {
        if(!vInfo.hasPrimType())
            checkNonPrimType(vInfo.getType(), vInfo.toString()); // Variable type checking
        this.currScope.addRecord(vInfo);
    }

    public void insert(FunInfo fInfo) throws SemanticError {
        if(!fInfo.hasPrimType())
            checkNonPrimType(fInfo.getType(), fInfo.toString()); // Function type checking
        for(VarInfo vInfo: fInfo.getParameters().values()) // Parameter type checking
            if(!vInfo.hasPrimType())
                checkNonPrimType(vInfo.getType(), vInfo.toString());
        this.currScope.addRecord(fInfo);
    }

    public void insert(ClassInfo cInfo) throws SemanticError {
        this.currScope.addRecord(cInfo);
    }

    public VarInfo lookupVar(String name) {
        Scope temp = this.currScope;
        VarInfo vInfo = null;

        while(temp != null){
            if(temp.getType() == 'c') // Class scope found
                vInfo = getClassField(temp, name); // Search variable in the class and its superclasses(variables are protected)
            else
                vInfo = temp.searchVar(name);
            
            if(vInfo != null) // Variable found
                return vInfo;

            temp = temp.getParentScope();
        }

        return null;
    }

    public FunInfo lookupFun(String className, String funName) { // Finds the function funName of the class className
        Scope temp = this.currScope;
        FunInfo fInfo = null;

        while(temp != null){
            ClassInfo cInfo = temp.searchClass(className);
            if(cInfo != null){  // Class className found
                Scope classScope = temp.getChild(cInfo.getScopeIndex());
                fInfo = getClassFunction(classScope,funName);
                if(fInfo != null) // Function found
                    return fInfo;
            }
             
            temp = temp.getParentScope();
        }

        return null;
    }

    public ClassInfo lookupClass(String name) {
        Scope temp = this.currScope;
        
        while(temp != null){
            ClassInfo cInfo = temp.searchClass(name);
            if(cInfo != null)
                return cInfo;
            temp = temp.getParentScope();
        }

        return null;
    }

    public ClassInfo lookupClass() { // Finds the first outer class
        Scope temp = this.currScope.getParentScope();     // Start from parent scope because an outer class must be found

        while(temp != null){
            if(temp.getType() == 'c') // Class scope found
                return (ClassInfo)(temp.getInfo());
            temp = temp.getParentScope();
        }

        return null;        
    }

    public Scope lookupClassScope(String name) {
        Scope temp = this.currScope;

        while(temp != null){
            ClassInfo cInfo = temp.searchClass(name);
            if(cInfo != null)
                return temp.getChild(cInfo.getScopeIndex());
            temp = temp.getParentScope();
        }

        return null;
    }

    public Scope lookupFunScope(String name) {
        Scope temp = this.currScope;

        while(temp != null){
            FunInfo fInfo = temp.searchFun(name);
            if(fInfo != null)
                return temp.getChild(fInfo.getScopeIndex());
            temp = temp.getParentScope();
        }

        return null;
    }


    public Scope lookupScopeOfVar(String name) {
        Scope temp = this.currScope;

        while(temp != null){
            if(temp.getType() == 'c') {// Class scope found
                Scope retScope = getClassScopeOfField(temp, name); // Search variable in the class and its superclasses(variables are protected)
                if(retScope != null)
                    return retScope;
            }
            else{
                if(temp.searchVar(name) != null)
                    return temp;
            }

            temp = temp.getParentScope();
        }

        return null;
    }


    public void visitNext() throws Exception {
        if(this.currScope.getChildrenNum() > 0){
            int next = this.currScope.getCurrChild();
            this.currScope = this.currScope.getChild(next);
        }
        else
            throw new Exception("Next scope is missing");
    }

    public void printScope() {
        this.currScope.print();
    }


    public void checkOverride(ClassInfo cInfo) throws SemanticError {

        List<String> ancestorNames = cInfo.getAncestorNames();
 
        if(ancestorNames.size() > 0){

            Scope classScope = this.currScope.getChild(cInfo.getScopeIndex());

            for(String funName: classScope.getFunctions().keySet()){  // For each function

                int currAncestor = 0; // Start from parent class
                FunInfo fInfo = classScope.searchFun(funName);
                Scope temp = this.currScope;
                
                while(currAncestor < ancestorNames.size()){
                    ClassInfo ancestorClass = temp.searchClass(ancestorNames.get(currAncestor));  
                    if(ancestorClass != null){ // If the ancenstor class was found in the current scope
                        Scope ancestorScope = temp.getChild(ancestorClass.getScopeIndex()); // Getting ancenstor class scope
                        FunInfo ancestorFun = ancestorScope.searchFun(fInfo.getName());
                        if(ancestorFun != null){      // Same function name found in the ancenstor class
                            if(!fInfo.equals(ancestorFun)){ // If the function found in the ancenstor class is not the same
                                String str = "Method " + fInfo.getName() + " of class " + cInfo.getName() + " does not override the same method of class " + ancestorNames.get(currAncestor) +"\n";
                                str += "Class " + ancestorClass.getName() + " : " + ancestorFun.toString() + "\n";
                                str += "Class " + cInfo.getName() + " : " + fInfo.toString();
                                throw new SemanticError(str);
                            }
                            else{
                                fInfo.setOverridden(ancestorFun);
                                break;
                            }
                        }
                        else
                            currAncestor++;
                    }
                    else
                        temp = temp.getParentScope();
                }
            }
        }
    }

    public void OffsetPrint(ClassInfo cInfo, PrintWriter writer) {

        List<String> ancestorNames = cInfo.getAncestorNames();
 
        if(ancestorNames.size() > 0){
            ClassInfo parentInfo = this.lookupClass(cInfo.getParentName());
            cInfo.setCurrVarOffset(parentInfo.getCurrVarOffset());  // Initialization with the parent last variable offset
            cInfo.setCurrFunOffset(parentInfo.getCurrFunOffset()); // Initialization with the parent last function offset
        }

        Scope classScope = this.currScope.getChild(cInfo.getScopeIndex());

        int offset = cInfo.getCurrVarOffset();
        for(VarInfo vInfo: classScope.getVariables().values()){
            writer.println(cInfo.getName() +"."+  vInfo.getName() + " : " + offset);
            vInfo.setOffset(offset);
            if(vInfo.getType().equals("int"))
                offset += 4;
            else if(vInfo.getType().equals("boolean"))
                offset += 1;
            else
                offset += 8;
        }
        cInfo.setCurrVarOffset(offset);

        offset = cInfo.getCurrFunOffset();
        for(FunInfo fInfo: classScope.getFunctions().values()){
            if(fInfo.getName().equals("main")){  // Checking for the pseudo - static main
                VarInfo vInfo = (VarInfo)(fInfo.getParameters().values().toArray()[0]);
                if(vInfo.getType().equals("String[]"))
                    continue;
            }
            
            FunInfo overridden = fInfo.getOverridden();
            if(overridden == null){
                writer.println(cInfo.getName() +"."+  fInfo.getName() + " : " + offset);
                fInfo.setOffset(offset);
                offset += 8;
            }
            else
                fInfo.setOffset(overridden.getOffset()); // Same offset as the overridden function
        }
        cInfo.setCurrFunOffset(offset);
    }

    public boolean isSubType(String type1, String type2) {

        ClassInfo cInfo = this.lookupClass(type1);
        if(cInfo != null)
            return cInfo.hasAncestor(type2);
        return false;
    }

    public void checkNonPrimType(String type, String str) throws SemanticError {

            ClassInfo cInfo = this.lookupClass(type);
            if(cInfo == null)
                throw new SemanticError("Unknown type " + type + " at \n\t --> " + str);
       
    }

    public static VarInfo getClassField(Scope classScope, String fieldName) {
        
        VarInfo vInfo = classScope.searchVar(fieldName);
        if(vInfo != null) // Field found in class
            return vInfo;
        else{
            ClassInfo cInfo = (ClassInfo)(classScope.getInfo());
            Scope temp = classScope.getParentScope();
            List<String> ancestorNames = cInfo.getAncestorNames();

            if(ancestorNames.size() > 0){
        
                int currAncestor = 0; // Start from parent class
                
                while(currAncestor < ancestorNames.size()){
                    ClassInfo ancestorClass = temp.searchClass(ancestorNames.get(currAncestor));  
                    if(ancestorClass != null){ // If the ancenstor class was found in the current scope
                        Scope ancestorScope = temp.getChild(ancestorClass.getScopeIndex()); // Getting ancenstor class scope
                        vInfo = ancestorScope.searchVar(fieldName);
                        if(vInfo != null) // Field found in the ancenstor class
                            return vInfo;
                        else
                            currAncestor++;
                    }
                    else
                        temp = temp.getParentScope();
                }
                return null;
                
            }
            else
                return null;
        }            
    }


    public static Scope getClassScopeOfField(Scope classScope, String fieldName) {
        
        if(classScope.searchVar(fieldName) != null) // Field found in class
            return classScope;
        else{
            ClassInfo cInfo = (ClassInfo)(classScope.getInfo());
            Scope temp = classScope.getParentScope();
            List<String> ancestorNames = cInfo.getAncestorNames();

            if(ancestorNames.size() > 0){
        
                int currAncestor = 0; // Start from parent class
                
                while(currAncestor < ancestorNames.size()){
                    ClassInfo ancestorClass = temp.searchClass(ancestorNames.get(currAncestor));  
                    if(ancestorClass != null){ // If the ancenstor class was found in the current scope
                        Scope ancestorScope = temp.getChild(ancestorClass.getScopeIndex()); // Getting ancenstor class scope
                        if(ancestorScope.searchVar(fieldName) != null) // Field found in the ancenstor class
                            return ancestorScope;
                        else
                            currAncestor++;
                    }
                    else
                        temp = temp.getParentScope();
                }
                return null;
                
            }
            else
                return null;
        }            
    }



    public static FunInfo getClassFunction(Scope classScope, String funName) {
        
        FunInfo fInfo = classScope.searchFun(funName);
        if(fInfo != null) // Function found in class
            return fInfo;
        else{
            ClassInfo cInfo = (ClassInfo)(classScope.getInfo());
            Scope temp = classScope.getParentScope();
            List<String> ancestorNames = cInfo.getAncestorNames();

            if(ancestorNames.size() > 0){
        
                int currAncestor = 0; // Start from parent class
                
                while(currAncestor < ancestorNames.size()){
                    ClassInfo ancestorClass = temp.searchClass(ancestorNames.get(currAncestor));  
                    if(ancestorClass != null){ // If the ancenstor class was found in the current scope
                        Scope ancestorScope = temp.getChild(ancestorClass.getScopeIndex()); // Getting ancenstor class scope
                        fInfo = ancestorScope.searchFun(funName);
                        if(fInfo != null) // Function found in the ancenstor class
                            return fInfo;
                        else
                            currAncestor++;
                    }
                    else
                        temp = temp.getParentScope();
                }
                return null;
                
            }
            else
                return null;
        }           
    }

    public void checkStaticCont() throws SemanticError {
        Scope temp = this.currScope;

        while(temp != null){
            FunInfo fInfo = temp.searchFun("main");
            if(fInfo != null){  // Checking for the pseudo - static main
                VarInfo vInfo = (VarInfo)(fInfo.getParameters().values().toArray()[0]);
                if(vInfo.getType().equals("String[]"))
                    throw new SemanticError("Cannot use \"this\" from a static context at\n\t --> public static void main(String[] "+vInfo.getName()+")");
            }
                   
            temp = temp.getParentScope();
        }
    }


    public void VTableCreate(ClassInfo cInfo) {

        Scope classScope = this.currScope.getChild(cInfo.getScopeIndex());
        List<String> ancestorNames = cInfo.getAncestorNames();
        VTable vTable = null;
 
        if(ancestorNames.size() > 0){
            ClassInfo parentInfo = this.lookupClass(cInfo.getParentName());
            VTable parVTable = parentInfo.getVTable();
            if(parVTable != null)
                vTable = parVTable.copy();
        }

        if(vTable == null)
            vTable = new VTable(cInfo);
        else
            vTable.setClassInfo(cInfo);

        for(Map.Entry<String, FunInfo> entry : classScope.getFunctions().entrySet())
            vTable.addFunction(entry.getKey(), entry.getValue());

        cInfo.setVTable(vTable);
       
    }

    public void UniqueFunNames(ClassInfo cInfo) {

        Scope classScope = this.currScope.getChild(cInfo.getScopeIndex());

        for(FunInfo fInfo : classScope.getFunctions().values())
            fInfo.setName(cInfo.getName()+ "." + fInfo.getName()); // Function rename in order to be distinguishable from other functions with the same name
            
    }

    // GETTERS & SETTERS


    public Scope getCurrScope() {
        return this.currScope;
    }

    public void setCurrScope(Scope currScope) {
        this.currScope = currScope;
    }


}


