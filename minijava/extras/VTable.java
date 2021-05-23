package extras;

import java.util.Map;
import java.util.LinkedHashMap;
import java.util.Iterator;

public class VTable {

    ClassInfo cInfo; 
    Map<String,FunInfo> functions;

    public VTable(ClassInfo cInfo) {
        this.cInfo = cInfo;
        this.functions = new LinkedHashMap<>();
    }


    public String getName() {
        return this.cInfo.getName() + "_vtable";
    }


    public String toString() {

        int funNum = this.functions.size();
        String str = "@." + this.getName() + " = global [" + funNum + " x i8*] [";
        
        if(funNum > 0){ // if it has at least one function
            Iterator<FunInfo> it = this.functions.values().iterator();
            FunInfo fInfo = it.next();
            for(int i = 0; i < funNum - 1; i++){
                str += "i8* bitcast (" + fInfo.getIRType() + " (i8*";
                for(VarInfo vInfo : fInfo.getParameters().values())
                    str += "," + vInfo.getIRType();
                str += ")* @" + fInfo.getName() + " to i8*), ";
                fInfo = it.next();
            }

            str += "i8* bitcast (" + fInfo.getIRType() + " (i8*";
            for(VarInfo vInfo : fInfo.getParameters().values())
                str += "," + vInfo.getIRType();
            str += ")* @" + fInfo.getName() + " to i8*)";
        }
        str += "]\n";

        return str;
    }

    public VTable copy() { // VTable clone
       
        VTable vTable = new VTable(this.cInfo); 
        for(Map.Entry<String, FunInfo> entry : this.functions.entrySet())
            vTable.addFunction(entry.getKey(), entry.getValue());

        return vTable;
    }

    public void addFunction(String name ,FunInfo fInfo) {
        this.functions.put(name, fInfo);
    }


    // GETTERS & SETTERS


    public ClassInfo getClassInfo() {
        return this.cInfo;
    }

    public void setClassInfo(ClassInfo cInfo) {
        this.cInfo = cInfo;
    }

    public Map<String,FunInfo> getFunctions() {
        return this.functions;
    }

    public void setFunctions(Map<String,FunInfo> functions) {
        this.functions = functions;
    }

}