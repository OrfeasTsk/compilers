package extras;

import java.util.List;
import java.util.ArrayList;



public class ClassInfo extends Info {

    private int scopeIndex; // Scope index at previous scope 
    private List<String> ancestorNames;
    private VTable vTable;
    private int currVarOffset;
    private int currFunOffset;

    public ClassInfo(int index, String name) {
        super(name);
        this.scopeIndex = index;
        this.ancestorNames = new ArrayList<>();
        this.vTable = null;
        this.currVarOffset = 0;
        this.currFunOffset = 0;
    }

    public ClassInfo(int index, String name, String parentName) {
        super(name);
        this.scopeIndex = index;
        this.ancestorNames = new ArrayList<>();
        this.ancestorNames.add(parentName);
        this.vTable = null;
        this.currVarOffset = 0;
        this.currFunOffset = 0;
    }

    public String getParentName() {
        if(ancestorNames.size() > 0)
            return this.ancestorNames.get(0);
        else
            return null;
    }

    public void setParentName(String parentName) {
        this.ancestorNames.set(0,parentName);
    }

    public void concatAncestorNames(List<String> ancestorNames){
        this.ancestorNames.addAll(ancestorNames);
    }

    public boolean hasAncestor(String name){
        return ancestorNames.contains(name);
    }

    //GETTERS & SETTERS


    public int getScopeIndex() {
        return this.scopeIndex;
    }

    public void setScopeIndex(int scopeIndex) {
        this.scopeIndex = scopeIndex;
    }

    public List<String> getAncestorNames() {
        return this.ancestorNames;
    }

    public void setAncestorNames(List<String> ancestorNames) {
        this.ancestorNames = ancestorNames;
    }

    public VTable getVTable() {
        return this.vTable;
    }

    public void setVTable(VTable vTable) {
        this.vTable = vTable;
    }

    public int getCurrVarOffset() {
        return this.currVarOffset;
    }

    public void setCurrVarOffset(int currVarOffset) {
        this.currVarOffset = currVarOffset;
    }

    public int getCurrFunOffset() {
        return this.currFunOffset;
    }

    public void setCurrFunOffset(int currFunOffset) {
        this.currFunOffset = currFunOffset;
    }

}