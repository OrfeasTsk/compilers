import syntaxtree.*;
import visitor.*;
import extras.*;

import java.util.Map;
import java.util.Iterator;

import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception {
        if(args.length < 1){
            System.err.println("Usage: java Main <inputFile> ...");
            System.exit(1);
        }

        FileInputStream fis = null;
        for(int i = 0; i < args.length; i++){
            try{
                System.out.println("Checking file " + args[i]);
                fis = new FileInputStream(args[i]);
                MiniJavaParser parser = new MiniJavaParser(fis);
                Goal root = parser.Goal();

                System.out.println("Program parsed successfully.");

                SymbolTable symTable = new SymbolTable();
                Scope globalScope = new Scope(new Info("Global"),'g');
                
                ClassCollector classCollector = new ClassCollector(globalScope, symTable);
                root.accept(classCollector, null);
                
                SymbolCollector symCollector = new SymbolCollector(globalScope, symTable);
                root.accept(symCollector, null);

                TypeChecker typeChecker = new TypeChecker(globalScope, symTable);
                root.accept(typeChecker, null);

                symTable.enter(globalScope);
                PrintWriter writer = new PrintWriter(System.out);
                for(ClassInfo cInfo: globalScope.getClasses().values()) // Accessing all classes from the global scope
                    symTable.OffsetPrint(cInfo, writer); //  Offsets
                writer.flush();
                symTable.exit();

                PrintWriter irWriter = new PrintWriter(System.out);
                IRCreator irCreator= new IRCreator(globalScope, symTable, irWriter); // Initialization of IR (vtable creation, common constants, common declarations and common definitions)
                root.accept(irCreator, null);

            }
            catch(ParseException ex){
                System.out.println(ex.getMessage());
            }
            catch(FileNotFoundException ex){
                System.err.println(ex.getMessage());
            }
            catch(SemanticError ex){
                System.err.println(ex.getMessage());
            }
            finally{
                try{
                    if(fis != null) fis.close();
                }
                catch(IOException ex){
                    System.err.println(ex.getMessage());
                }
            }
        }
    }
}

class ClassCollector extends GJDepthFirst<Info, Object> {

    Scope globalScope;
    SymbolTable symTable;


    public ClassCollector(Scope globalScope, SymbolTable symTable){
        this.globalScope = globalScope;
        this.symTable = symTable;
    }

    /**
    * f0 -> MainClass()
    * f1 -> ( TypeDeclaration() )*
    * f2 -> <EOF>
    */
    @Override
    public Info visit(Goal n, Object obj) throws Exception {

        this.symTable.enter(this.globalScope); // Global scope
        ClassInfo cInfo = (ClassInfo)(n.f0.accept(this, null));
        this.symTable.insert(cInfo);
        for(Node node: n.f1.nodes){
            cInfo = (ClassInfo)(node.accept(this, null));
            String parentName = cInfo.getParentName();
            if(parentName != null){
                ClassInfo parentInfo = this.symTable.lookupClass(parentName);
                if(parentInfo == null)  // Parent class must have been defined before
                    throw new SemanticError("Class " + parentName + " has not been defined before class " + cInfo.getName());
                else
                    cInfo.concatAncestorNames(parentInfo.getAncestorNames());
            }
            this.symTable.insert(cInfo);
        }
        this.symTable.exit(); // Global scope
        
        return null;
    }

    /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> "public"
    * f4 -> "static"
    * f5 -> "void"
    * f6 -> "main"
    * f7 -> "("
    * f8 -> "String"
    * f9 -> "["
    * f10 -> "]"
    * f11 -> Identifier()
    * f12 -> ")"
    * f13 -> "{"
    * f14 -> ( VarDeclaration() )*
    * f15 -> ( Statement() )*
    * f16 -> "}"
    * f17 -> "}"
    */
    @Override
    public Info visit(MainClass n, Object obj) throws Exception {

        String name = n.f1.accept(this, null).getName();
        int nextIndex = this.symTable.getCurrScope().getCurrChild() + 1;
        ClassInfo cInfo = new ClassInfo(nextIndex, name);
        this.symTable.enter(new Scope(cInfo,'c'));  // MainClass scope
        this.symTable.exit(); // MainClass scope
        
        return cInfo;
    }

    /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> ( VarDeclaration() )*
    * f4 -> ( MethodDeclaration() )*
    * f5 -> "}"
    */
    @Override
    public Info visit(ClassDeclaration n, Object obj) throws Exception {

        String name = n.f1.accept(this, null).getName();
        int nextIndex = this.symTable.getCurrScope().getCurrChild() + 1;
        ClassInfo cInfo = new ClassInfo(nextIndex, name);
        this.symTable.enter(new Scope(cInfo,'c')); // ClassDeclaration scope
        this.symTable.exit(); // ClassDeclaration scope
        
        return cInfo;
    }

    /**
     * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "extends"
    * f3 -> Identifier()
    * f4 -> "{"
    * f5 -> ( VarDeclaration() )*
    * f6 -> ( MethodDeclaration() )*
    * f7 -> "}"
    */
    @Override
    public Info visit(ClassExtendsDeclaration n, Object obj) throws Exception {
        
        String name = n.f1.accept(this, null).getName();
        String parentName = n.f3.accept(this, null).getName();
        int nextIndex = this.symTable.getCurrScope().getCurrChild() + 1;
        ClassInfo cInfo = new ClassInfo(nextIndex, name, parentName);
        this.symTable.enter(new Scope(cInfo,'c')); // ClassExtendsDeclaration scope
        this.symTable.exit(); // ClassExtendsDeclaration scope

        return cInfo;
    }

    @Override
    public Info visit(Identifier n, Object obj) throws Exception {
        return new Info(n.f0.toString());
    }
}


class SymbolCollector extends GJDepthFirst<Info, Object> {

    Scope globalScope;
    SymbolTable symTable;


    public SymbolCollector(Scope globalScope, SymbolTable symTable){
        this.globalScope = globalScope;
        this.symTable = symTable;
    }
    /**
    * f0 -> MainClass()
    * f1 -> ( TypeDeclaration() )*
    * f2 -> <EOF>
    */
    @Override
    public Info visit(Goal n, Object obj) throws Exception {

        this.symTable.enter(this.globalScope); // Global scope
        n.f0.accept(this, null);
        for(Node node: n.f1.nodes)
            node.accept(this, null);
        for(ClassInfo cInfo: this.globalScope.getClasses().values())
            this.symTable.checkOverride(cInfo); // Search for overriding methods
        this.symTable.exit(); // Global scope

        return null;
    }

    /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> "public"
    * f4 -> "static"
    * f5 -> "void"
    * f6 -> "main"
    * f7 -> "("
    * f8 -> "String"
    * f9 -> "["
    * f10 -> "]"
    * f11 -> Identifier()
    * f12 -> ")"
    * f13 -> "{"
    * f14 -> ( VarDeclaration() )*
    * f15 -> ( Statement() )*
    * f16 -> "}"
    * f17 -> "}"
    */
    @Override
    public Info visit(MainClass n, Object obj) throws Exception {

        this.symTable.enter();  // MainClass scope
        int nextIndex = this.symTable.getCurrScope().getCurrChild() + 1;
        FunInfo fInfo = new FunInfo(nextIndex, "main", "void");
        String name = n.f11.accept(this, null).getName();
        VarInfo vInfo = new VarInfo(name, "String[]");
        fInfo.addParameter(vInfo);
        this.symTable.insert(fInfo);
        this.symTable.enter(new Scope(fInfo,'f'));  // main() scope
        this.symTable.insert(vInfo); // Parameter is added to the variables
        for(Node node: n.f14.nodes){
           vInfo = (VarInfo)(node.accept(this, null));
           this.symTable.insert(vInfo);
        }
        this.symTable.exit(); // main() scope
        this.symTable.exit(); // MainClass scope
        
        return null;
    }

    /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> ( VarDeclaration() )*
    * f4 -> ( MethodDeclaration() )*
    * f5 -> "}"
    */
    @Override
    public Info visit(ClassDeclaration n, Object obj) throws Exception {

        this.symTable.enter(); // ClassDeclaration scope
        for(Node node: n.f3.nodes){
            VarInfo vInfo = (VarInfo)(node.accept(this, null));
            this.symTable.insert(vInfo);
        }
        for(Node node: n.f4.nodes){
            FunInfo fInfo = (FunInfo)(node.accept(this, null));
            this.symTable.insert(fInfo);
        }
        this.symTable.exit(); // ClassDeclaration scope
        
        return null;
    }

    /**
     * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "extends"
    * f3 -> Identifier()
    * f4 -> "{"
    * f5 -> ( VarDeclaration() )*
    * f6 -> ( MethodDeclaration() )*
    * f7 -> "}"
    */
    @Override
    public Info visit(ClassExtendsDeclaration n, Object obj) throws Exception {
        
        this.symTable.enter(); // ClassExtendsDeclaration scope
        for(Node node: n.f5.nodes){
            VarInfo vInfo = (VarInfo)(node.accept(this, null));
            this.symTable.insert(vInfo);
        }
        for(Node node: n.f6.nodes){
            FunInfo fInfo = (FunInfo)(node.accept(this, null));
            this.symTable.insert(fInfo);
        }
        this.symTable.exit(); // ClassExtendsDeclaration scope

        return null;
    }

    /**
    * f0 -> Type()
    * f1 -> Identifier()
    * f2 -> ";"
    */
    @Override
    public Info visit(VarDeclaration n, Object obj) throws Exception {

        String type = n.f0.accept(this, null).getName();
        String name = n.f1.accept(this, null).getName();
        VarInfo vInfo = new VarInfo(name, type);

        return vInfo;
    }

    /**
    * f0 -> "public"
    * f1 -> Type()
    * f2 -> Identifier()
    * f3 -> "("
    * f4 -> ( FormalParameterList() )?
    * f5 -> ")"
    * f6 -> "{"
    * f7 -> ( VarDeclaration() )*
    * f8 -> ( Statement() )*
    * f9 -> "return"
    * f10 -> Expression()
    * f11 -> ";"
    * f12 -> "}"
    */
    @Override
    public Info visit(MethodDeclaration n, Object obj) throws Exception {

        String type = n.f1.accept(this, null).getName();
        String name = n.f2.accept(this, null).getName();
        int nextIndex = this.symTable.getCurrScope().getCurrChild() + 1;
        FunInfo fInfo = new FunInfo(nextIndex, name, type);
        if(n.f4.present())
            n.f4.accept(this, fInfo);
        this.symTable.enter(new Scope(fInfo,'f'));  // MethodDeclaration scope
        if(fInfo.getParamNum() > 0) // Every parameter is added to the variables
            for(String keyName: fInfo.getParameters().keySet())
                this.symTable.insert(fInfo.getParameter(keyName));
        for(Node node: n.f7.nodes){
            VarInfo vInfo = (VarInfo)(node.accept(this, null));
            this.symTable.insert(vInfo);
        }
        this.symTable.exit(); // MethodDeclaration scope

        return fInfo;
    }

    /**
    * f0 -> FormalParameter()
    * f1 -> FormalParameterTail()
    */
    @Override
    public Info visit(FormalParameterList n, Object obj) throws Exception {
        
        FunInfo fInfo = (FunInfo)obj;
        VarInfo vInfo = (VarInfo)(n.f0.accept(this, null));
        fInfo.addParameter(vInfo);
        n.f1.accept(this, fInfo);
        
        return null;
    }


    /**
     * f0 -> ( FormalParameterTerm() )*
    */
    @Override
    public Info visit(FormalParameterTail n, Object obj) throws Exception {

        FunInfo fInfo = (FunInfo)obj;
        for(Node node: n.f0.nodes){ // Getting all the parameters
            VarInfo vInfo = (VarInfo)(node.accept(this, null));
            fInfo.addParameter(vInfo);
         }        

        return null;
    }

    /**
     * f0 -> ","
    * f1 -> FormalParameter()
    */
    @Override
    public Info visit(FormalParameterTerm n, Object obj) throws Exception {        
        return n.f1.accept(this, null);
    }

    /**
     * f0 -> Type()
    * f1 -> Identifier()
    */
    @Override
    public Info visit(FormalParameter n, Object obj) throws Exception {

        String type = n.f0.accept(this, null).getName();
        String name = n.f1.accept(this, null).getName();
        VarInfo vInfo = new VarInfo(name, type);

        return vInfo;
    }


    @Override
    public Info visit(ArrayType n, Object obj) throws Exception {
        return new Info("int[]");
    }

    @Override
    public Info visit(BooleanType n, Object obj) throws Exception {
        return new Info("boolean");
    }

    @Override
    public Info visit(IntegerType n, Object obj) throws Exception {
        return new Info("int");
    }

    @Override
    public Info visit(Identifier n, Object obj) throws Exception {
        return new Info(n.f0.toString());
    }
}



class TypeChecker extends GJDepthFirst<ExprInfo, Object>{

    Scope globalScope;
    SymbolTable symTable;


    public TypeChecker(Scope globalScope,  SymbolTable symTable){
        this.globalScope = globalScope;
        this.symTable = symTable;
    }

    /**
    * f0 -> MainClass()
    * f1 -> ( TypeDeclaration() )*
    * f2 -> <EOF>
    */
    @Override
    public ExprInfo visit(Goal n, Object obj) throws Exception {

        this.symTable.enter(this.globalScope); // Global scope
        n.f0.accept(this, null);
        for(Node node: n.f1.nodes)
            node.accept(this, null);
        this.symTable.exit(); // Global scope

        return null;
    }

    /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> "public"
    * f4 -> "static"
    * f5 -> "void"
    * f6 -> "main"
    * f7 -> "("
    * f8 -> "String"
    * f9 -> "["
    * f10 -> "]"
    * f11 -> Identifier()
    * f12 -> ")"
    * f13 -> "{"
    * f14 -> ( VarDeclaration() )*
    * f15 -> ( Statement() )*
    * f16 -> "}"
    * f17 -> "}"
    */
    @Override
    public ExprInfo visit(MainClass n, Object obj) throws Exception {

        this.symTable.enter();  // MainClass scope
        this.symTable.enter();  // main() scope
        for(Node node: n.f15.nodes)
           node.accept(this, null);
        this.symTable.exit(); // main() scope
        this.symTable.exit(); // MainClass scope
        
        return null;
    }

    /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> ( VarDeclaration() )*
    * f4 -> ( MethodDeclaration() )*
    * f5 -> "}"
    */
    @Override
    public ExprInfo visit(ClassDeclaration n, Object obj) throws Exception {

        this.symTable.enter(); // ClassDeclaration scope
        for(Node node: n.f4.nodes)
            node.accept(this, null);
        this.symTable.exit(); // ClassDeclaration scope
        
        return null;
    }

    /**
     * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "extends"
    * f3 -> Identifier()
    * f4 -> "{"
    * f5 -> ( VarDeclaration() )*
    * f6 -> ( MethodDeclaration() )*
    * f7 -> "}"
    */
    @Override
    public ExprInfo visit(ClassExtendsDeclaration n, Object obj) throws Exception {
        
        this.symTable.enter(); // ClassExtendsDeclaration scope
        for(Node node: n.f6.nodes)
            node.accept(this, null);
        this.symTable.exit(); // ClassExtendsDeclaration scope

        return null;
    }

    /**
    * f0 -> "public"
    * f1 -> Type()
    * f2 -> Identifier()
    * f3 -> "("
    * f4 -> ( FormalParameterList() )?
    * f5 -> ")"
    * f6 -> "{"
    * f7 -> ( VarDeclaration() )*
    * f8 -> ( Statement() )*
    * f9 -> "return"
    * f10 -> Expression()
    * f11 -> ";"
    * f12 -> "}"
    */
    @Override
    public ExprInfo visit(MethodDeclaration n, Object obj) throws Exception {

        this.symTable.enter();  // MethodDeclaration scope
        for(Node node: n.f8.nodes)
            node.accept(this, null);
        FunInfo fInfo = (FunInfo)(this.symTable.getCurrScope().getInfo());
        ExprInfo eInfo = n.f10.accept(this, null);
        String retType = eInfo.getType();
        String expr = eInfo.getName();
        if(compatTypes(retType, fInfo.getType()) == false)
            throw new SemanticError("Incompatible return type in function "+ fInfo.toString() +" at \n\t --> return "+ expr +"\nRequired: "+ fInfo.getType()+"\nFound: "+ retType);
        
        //check me type
        this.symTable.exit(); // MethodDeclaration scope

        return null;
    }

    /**
        * f0 -> "{"
        * f1 -> ( Statement() )*
        * f2 -> "}"
        */
    @Override
    public ExprInfo visit(Block n, Object obj) throws Exception {

        n.f1.accept(this, null);
        return null;
    }

    /**
     * f0 -> Identifier()
    * f1 -> "="
    * f2 -> Expression()
    * f3 -> ";"
    */
    @Override
    public ExprInfo visit(AssignmentStatement n, Object obj) throws Exception {
        ExprInfo lEInfo = n.f0.accept(this, Boolean.valueOf(true));
        String lType = lEInfo.getType();
        String lExpr = lEInfo.getName();
        ExprInfo rEInfo = n.f2.accept(this, null);
        String rType = rEInfo.getType();
        String rExpr = rEInfo.getName();

        if(compatTypes(rType, lType) == false) // Right type must be compatible with the left type
            throw new SemanticError("Assignment between incompatible types at\n\t --> "+ lExpr +" = "+ rExpr +"\nLeft type: "+ lType+"\nRight type: "+ rType);

        return null;
    }

    /**
     * f0 -> Identifier()
    * f1 -> "["
    * f2 -> Expression()
    * f3 -> "]"
    * f4 -> "="
    * f5 -> Expression()
    * f6 -> ";"
    */
    @Override
    public ExprInfo visit(ArrayAssignmentStatement n,  Object obj) throws Exception {

        ExprInfo arrInfo = n.f0.accept(this, Boolean.valueOf(true));
        String arrType = arrInfo.getType();
        String arrName = arrInfo.getName();

        ExprInfo indInfo =  n.f2.accept(this, null);
        String indName = indInfo.getName();
        
        ExprInfo rEInfo = n.f5.accept(this, null);
        String rExpr = rEInfo.getName();

        if(!arrType.contains("[]"))
            throw new SemanticError("Array required but "+ arrType +" found at \n\t --> " +arrName +"["+ indName + "]" +" = " + rExpr);
        String indType = indInfo.getType();
        if(!indType.equals("int"))
            throw new SemanticError("Array index must be of type int at \n\t --> " +arrName +"["+ indName + "]" +" = " + rExpr +"\nFound: "+ indType);
        
        String lType = arrType.substring(0, arrType.length() - 2); // Always int
        String rType = rEInfo.getType();

        if(compatTypes(rType, lType) == false) // Right type must be compatible with the left type
            throw new SemanticError("Assignment between incompatible types at\n\t --> "+arrName +"["+ indName + "]" +" = " + rExpr +"\nLeft type: "+ lType+"\nRight type: "+ rType);

        return null;
    }

    /**
     * f0 -> "if"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> Statement()
    * f5 -> "else"
    * f6 -> Statement()
    */
    @Override
    public ExprInfo visit(IfStatement n, Object obj) throws Exception {

        ExprInfo eInfo = n.f2.accept(this, null);
        String condType = eInfo.getType();
        String expr = eInfo.getName();

        if(!condType.equals("boolean"))
            throw new SemanticError("Condition in \"if\" statement must be of type boolean at\n\t --> if("+expr+")\nFound: "+ condType);

        n.f4.accept(this, null);
        n.f6.accept(this, null);
        return null;
    }

    /**
     * f0 -> "while"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> Statement()
    */
    @Override
    public ExprInfo visit(WhileStatement n, Object obj) throws Exception {

        ExprInfo eInfo = n.f2.accept(this, null);
        String condType = eInfo.getType();
        String expr = eInfo.getName();

        if(!condType.equals("boolean"))
            throw new SemanticError("Condition in \"while\" loop  must be of type boolean at\n\t --> while("+expr+")\nFound: "+ condType);

        n.f4.accept(this, null);
        return null;
    }

    /**
     * f0 -> "System.out.println"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> ";"
    */
    @Override
    public ExprInfo visit(PrintStatement n, Object obj) throws Exception {
        ExprInfo eInfo = n.f2.accept(this, null);
        String type = eInfo.getType();
        String expr = eInfo.getName();

        if(!type.equals("int"))
            throw new SemanticError("Non int types cannot be printed at\n\t --> System.out.println("+expr+")\nFound: "+ type);

        return null;
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "&&"
    * f2 -> PrimaryExpression()
    */
    @Override
    public ExprInfo visit(AndExpression n, Object obj) throws Exception {
        
        ExprInfo eInfo1 = n.f0.accept(this, null);
        ExprInfo eInfo2 = n.f2.accept(this, null);
        String type1 = eInfo1.getType();
        String type2 = eInfo2.getType();
        String expr = eInfo1.getName() + " && " + eInfo2.getName();

        if(!type1.equals("boolean") || !type2.equals("boolean"))
            throw new SemanticError("Bad operand types for binary operator '&&' at \n\t --> "+expr+"\nLeft type required: boolean\nLeft type found: "+ type1 +"\nRight type required: boolean\nRight type found: " + type2);

        return new ExprInfo(expr, "boolean");
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "<"
    * f2 -> PrimaryExpression()
    */
    @Override
    public ExprInfo visit(CompareExpression n, Object obj) throws Exception {

        ExprInfo eInfo1 = n.f0.accept(this, null);
        ExprInfo eInfo2 = n.f2.accept(this, null);
        String type1 = eInfo1.getType();
        String type2 = eInfo2.getType();
        String expr = eInfo1.getName() + " < " + eInfo2.getName();

        if(!type1.equals("int") || !type2.equals("int"))
            throw new SemanticError("Bad operand types for binary operator '<' at \n\t --> "+expr+"\nLeft type required: int\nLeft type found: "+ type1 +"\nRight type required: int\nRight type found: " + type2);

        return new ExprInfo(expr, "boolean");
    }

    /**
     * f0 -> PrimaryExpression()
    * f1 -> "+"
    * f2 -> PrimaryExpression()
    */
    @Override
    public ExprInfo visit(PlusExpression n, Object obj) throws Exception {

        ExprInfo eInfo1 = n.f0.accept(this, null);
        ExprInfo eInfo2 = n.f2.accept(this, null);
        String type1 = eInfo1.getType();
        String type2 = eInfo2.getType();
        String expr = eInfo1.getName() + " + " + eInfo2.getName();

        if(!type1.equals("int") || !type2.equals("int"))
            throw new SemanticError("Bad operand types for binary operator '+' at \n\t --> "+expr+"\nLeft type required: int\nLeft type found: "+ type1 +"\nRight type required: int\nRight type found: " + type2);

        return new ExprInfo(expr, "int");
    }

    /**
     * f0 -> PrimaryExpression()
    * f1 -> "-"
    * f2 -> PrimaryExpression()
    */
    @Override
    public ExprInfo visit(MinusExpression n, Object obj) throws Exception {

        ExprInfo eInfo1 = n.f0.accept(this, null);
        ExprInfo eInfo2 = n.f2.accept(this, null);
        String type1 = eInfo1.getType();
        String type2 = eInfo2.getType();
        String expr = eInfo1.getName() + " - " + eInfo2.getName();

        if(!type1.equals("int") || !type2.equals("int"))
            throw new SemanticError("Bad operand types for binary operator '-' at \n\t --> "+expr+"\nLeft type required: int\nLeft type found: "+ type1 +"\nRight type required: int\nRight type found: " + type2);

        return new ExprInfo(expr, "int");
    }

    /**
     * f0 -> PrimaryExpression()
    * f1 -> "*"
    * f2 -> PrimaryExpression()
    */
    @Override
    public ExprInfo visit(TimesExpression n, Object obj) throws Exception {
        
        ExprInfo eInfo1 = n.f0.accept(this, null);
        ExprInfo eInfo2 = n.f2.accept(this, null);
        String type1 = eInfo1.getType();
        String type2 = eInfo2.getType();
        String expr = eInfo1.getName() + " * " + eInfo2.getName();

        if(!type1.equals("int") || !type2.equals("int"))
            throw new SemanticError("Bad operand types for binary operator '*' at \n\t --> "+expr+"\nLeft type required: int\nLeft type found: "+ type1 +"\nRight type required: int\nRight type found: " + type2);

        return new ExprInfo(expr, "int");
    }

    /**
     * f0 -> PrimaryExpression()
    * f1 -> "["
    * f2 -> PrimaryExpression()
    * f3 -> "]"
    */
    @Override
    public ExprInfo visit(ArrayLookup n, Object obj) throws Exception {

        ExprInfo eInfo1 = n.f0.accept(this, null);
        ExprInfo eInfo2 = n.f2.accept(this, null);
        String type1 = eInfo1.getType();
        String type2 = eInfo2.getType();
        String expr = eInfo1.getName() + "["+ eInfo2.getName()+ "]";

        if(!type1.contains("[]"))
            throw new SemanticError("Array required but "+ type1 +" found at \n\t --> " + expr);
        if(!type2.equals("int"))
            throw new SemanticError("Array index must be of type int at \n\t --> "+expr+"\nFound: "+ type2);
        
        return new ExprInfo(expr, "int");
    }

    /**
     * f0 -> PrimaryExpression()
    * f1 -> "."
    * f2 -> "length"
    */
    @Override
    public ExprInfo visit(ArrayLength n, Object obj) throws Exception {
        
        ExprInfo eInfo = n.f0.accept(this, null);
        String type = eInfo.getType();
        String expr = eInfo.getName() + ".length";
        if(type.equals("int") || type.equals("boolean"))
            throw new SemanticError("Type "+ type +" cannot be dereferenced at\n\t --> " + expr);
        else if(!type.contains("[]"))
                throw new SemanticError("Class "+ type +" cannot have member named \"length\" at\n\t --> " + expr);

        return new ExprInfo(expr, "int");
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "."
    * f2 -> Identifier()
    * f3 -> "("
    * f4 -> ( ExpressionList() )?
    * f5 -> ")"
    */
    @Override
    public ExprInfo visit(MessageSend n, Object obj) throws Exception {
        
        ExprInfo eInfo = n.f0.accept(this, null);
        String type = eInfo.getType();
        String expr = eInfo.getName();
        String funName = n.f2.accept(this, Boolean.valueOf(false)).getName();
        if(type.equals("int") || type.equals("boolean")){
            ArgCollector args = new ArgCollector();
            if(n.f4.present())
                n.f4.accept(this, args);
            expr += "."+ funName + "("+ args.concatArgs() +")";
            throw new SemanticError("Type "+ type +" cannot be dereferenced at \n\t --> " + expr);
        }
        else if(type.contains("[]")){ //.equals(), .hashCode() and functions are allowed (return type boolean and int respectively)
            if(funName.equals("equals")){
                if(n.f4.present()){
                    ArgCollector args = new ArgCollector();
                    n.f4.accept(this, args);
                    expr += "."+ funName + "("+ args.concatArgs() +")";
                    if(args.getArgNumber() != 1){
                        String str = "";
                        int i;
                        for(i = 0; i < args.getArgNumber() - 1; i++){
                            str += args.get(i).getType() + ", ";
                        }
                        str += args.get(i).getType();
                        throw new SemanticError("Function equals(Object obj) cannot be applied to given types at \n\t --> "+expr+"\nRequired: Object\nFound: " + str);
                    }
                    else if(args.get(0).getType().equals("int") || args.get(0).getType().equals("boolean"))
                        throw new SemanticError("Function equals(Object obj) cannot be applied to given types at \n\t --> "+expr+"\nRequired: Object\nFound: " + args.get(0).getType());
                    else
                        return new ExprInfo(expr, "boolean");
                }
                else
                    throw new SemanticError("Function equals(Object obj) cannot be applied to given types at \n\t --> "+expr+".equals()\nRequired: Object\nFound: no arguments");
                
            }
            else if(funName.equals("hashCode")){
                if(n.f4.present()){
                    ArgCollector args = new ArgCollector();
                    n.f4.accept(this, args);
                    expr += "."+ funName + "("+ args.concatArgs() +")";
                    String str = "";
                    int i;
                    for(i = 0; i < args.getArgNumber() - 1; i++){
                        str += args.get(i).getType() + ", ";
                    }
                    str += args.get(i).getType();
                    throw new SemanticError("Function hashCode() cannot be applied to given types at \n\t --> "+expr+"\nRequired: no arguments\nFound: " + str);
                }
                else
                    return new ExprInfo(expr+".hashCode()", "int");
            }
            else
                throw new SemanticError("Function "+ funName +" cannot be found in class " + type);
        }
        else{
            FunInfo fInfo = this.symTable.lookupFun(type, funName);
            if(fInfo == null)
                throw new SemanticError("Function "+ funName +" cannot be found in class " + type);
            else{
                ArgCollector args = new ArgCollector();
                if(n.f4.present())
                    n.f4.accept(this, args);
                expr += "."+ funName + "("+ args.concatArgs() +")";
                if(args.getArgNumber() != fInfo. getParamNum()){ // Different number of parameters and arguments
                    String str1 = "";
                    String str2 = "";

                    if(fInfo.getParamNum() > 0){     
                        for(Map.Entry<String, VarInfo> entry: fInfo.getParameters().entrySet())
                            str1 += entry.getValue().getType() + ", ";
                        str1 = str1.substring(0,str1.length() - 2);
                    }
                    else
                        str1 = "no arguments";
                    
                    if(args.getArgNumber() > 0){     
                        int i;
                        for(i = 0; i < args.getArgNumber() - 1; i++){
                            str2 += args.get(i).getType() + ", ";
                        }
                        str2 += args.get(i).getType();
                    }
                    else
                        str2 = "no arguments";

                    throw new SemanticError("Function "+ fInfo.toString() +" cannot be applied to given types at \n\t --> "+ expr +"\nRequired: "+ str1 +"\nFound: "+ str2 );
                }
                else{
                    Iterator<Map.Entry<String, VarInfo>> it = fInfo.getParameters().entrySet().iterator();
                    int i = 0;
                    while(it.hasNext()){ // Type checking between parameters and arguments
                        Map.Entry<String, VarInfo> par = it.next();
                        String parType = par.getValue().getType();
                        String argType = args.get(i).getType();

                        if(compatTypes(argType, parType) == false){
                            String str1 = "";
                            String str2 = "";
                            for(Map.Entry<String, VarInfo> entry: fInfo.getParameters().entrySet())
                                str1 += entry.getValue().getType() + ", ";
                            str1 = str1.substring(0,str1.length() - 2);
            
                            for(i = 0; i < args.getArgNumber() - 1; i++){
                                str2 += args.get(i).getType() + ", ";
                            }
                            str2 += args.get(i).getType();
                            throw new SemanticError("Function "+ fInfo.toString() +" cannot be applied to given types at \n\t --> "+ expr +"\nRequired: "+ str1 +"\nFound: "+ str2 );
                        }
                        i++;
                    }

                }    
                return new ExprInfo(expr, fInfo.getType()); // Return type of function
            } 
        }  
    }

    /**
     * f0 -> Expression()
    * f1 -> ExpressionTail()
    */
    @Override
    public ExprInfo visit(ExpressionList n, Object obj) throws Exception {
       
        ArgCollector args = (ArgCollector)obj;
        args.add(n.f0.accept(this, args));
        n.f1.accept(this, args);
        return null;
    }

    /**
     * f0 -> ( ExpressionTerm() )*
    */
    @Override
    public ExprInfo visit(ExpressionTail n, Object obj) throws Exception {

        ArgCollector args = (ArgCollector)obj;
        for(Node node: n.f0.nodes) // Getting all the arguments
            args.add(node.accept(this, null));
        return null;
    }

    /**
     * f0 -> ","
    * f1 -> Expression()
    */
    @Override
    public ExprInfo visit(ExpressionTerm n, Object obj) throws Exception {
        ExprInfo eInfo = n.f1.accept(this, null);
        return new ExprInfo(", " + eInfo.getName(), eInfo.getType());
    }

    /**
    * f0 -> IntegerLiteral()
    *       | TrueLiteral()
    *       | FalseLiteral()
    *       | Identifier()
    *       | ThisExpression()
    *       | ArrayAllocationExpression()
    *       | AllocationExpression()
    *       | NotExpression()
    *       | BracketExpression()
    */
    @Override
    public ExprInfo visit(PrimaryExpression n, Object obj) throws Exception {
        if(n.f0.which == 3) // If the choice is identifier (so type must be returned)
            return n.f0.accept(this, Boolean.valueOf(true));
        else
            return n.f0.accept(this, null);
    }

    @Override
    public ExprInfo visit(IntegerLiteral n, Object obj) throws Exception {
        return new ExprInfo(n.f0.toString(), "int");
    }

    @Override
    public ExprInfo visit(TrueLiteral n, Object obj) throws Exception {
        return new ExprInfo("true", "boolean");
    }

    @Override
    public ExprInfo visit(FalseLiteral n, Object obj) throws Exception {
        return new ExprInfo("false", "boolean");
    }

    @Override
    public ExprInfo visit(Identifier n, Object obj) throws Exception{
        Boolean lookup = (Boolean)obj;
        if(lookup == false)
            return new ExprInfo(n.f0.toString(), n.f0.toString()); // Just the name is returned (type is the same as the name)
        else { // Search in symbol table
            VarInfo vInfo = this.symTable.lookupVar(n.f0.toString());
            if(vInfo == null)
                throw new SemanticError("Undeclared variable " + n.f0.toString());
            else
                return new ExprInfo(n.f0.toString(), vInfo.getType());
        }      
    }

    @Override
    public ExprInfo visit(ThisExpression n, Object obj) throws Exception {
        this.symTable.checkStaticCont();
        ClassInfo cInfo = this.symTable.lookupClass();
        return new ExprInfo("this", cInfo.getName());
    }

    /**
    * f0 -> "new"
    * f1 -> "int"
    * f2 -> "["
    * f3 -> Expression()
    * f4 -> "]"
    */
    @Override
    public ExprInfo visit(ArrayAllocationExpression n, Object obj) throws Exception {
        ExprInfo eInfo = n.f3.accept(this, null);
        String type = eInfo.getType();
        String expr = "new int["+ eInfo.getName() +"]";
        if(!type.equals("int"))
            throw new SemanticError("Array size must be of type int at\n\t --> "+expr+"\nFound: "+ type);
        return new ExprInfo(expr , "int[]");
    }

    /**
    * f0 -> "new"
    * f1 -> Identifier()
    * f2 -> "("
    * f3 -> ")"
    */
    @Override
    public ExprInfo visit(AllocationExpression n,  Object obj) throws Exception {
        String name = n.f1.accept(this, Boolean.valueOf(false)).getName();
        String expr = "new " + name + "()";
        this.symTable.checkNonPrimType(name, expr);
        return new ExprInfo(expr, name);
    }

    /**
    * f0 -> "!"
    * f1 -> PrimaryExpression()
    */
    @Override
    public ExprInfo visit(NotExpression n, Object obj) throws Exception {
        ExprInfo eInfo = n.f1.accept(this, null);
        String type = eInfo.getType();
        String expr = "!" + eInfo.getName();
        if(!type.equals("boolean"))
            throw new SemanticError("Bad operand type for unary operator '!' at\n\t --> "+expr+"\nRequired: boolean\nFound: " + type);
        return new ExprInfo(expr, "boolean");
    }

    /**
    * f0 -> "("
    * f1 -> Expression()
    * f2 -> ")"
    */
    @Override
    public ExprInfo visit(BracketExpression n, Object obj) throws Exception {
        ExprInfo eInfo = n.f1.accept(this, null);
        return new ExprInfo("("+eInfo.getName()+")", eInfo.getType());
    }

    public boolean compatTypes(String type1, String type2){

        if(!type1.equals("int") && !type1.equals("int[]") && !type1.equals("boolean") && !type2.equals("int") && !type2.equals("int[]") && !type2.equals("boolean")){ // Both types are non primitive
            if(!type1.equals(type2) && !this.symTable.isSubType(type1, type2)) // Subtype check
                return false;
        }
        else if(!type1.equals(type2))  // Check for different type by name
                return false;

        return true;
    }
}

class IRCreator extends GJDepthFirst<ExprInfo, Object> {

    Scope globalScope;
    SymbolTable symTable;
    int regCounter;
    int labCounter;
    PrintWriter writer;


    public IRCreator(Scope globalScope, SymbolTable symTable, PrintWriter writer) {
        this.globalScope = globalScope;
        this.symTable = symTable;
        this.writer = writer;
        this.CounterInit();
    }


    /**
    * f0 -> MainClass()
    * f1 -> ( TypeDeclaration() )*
    * f2 -> <EOF>
    */
    @Override
    public ExprInfo visit(Goal n, Object obj) throws Exception {

        this.symTable.enter(this.globalScope); // Global scope
        this.IRInit();
        n.f0.accept(this, null);
        for(Node node: n.f1.nodes)
            node.accept(this, null);
        this.symTable.exit(); // Global scope

        return null;
    }

    /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> "public"
    * f4 -> "static"
    * f5 -> "void"
    * f6 -> "main"
    * f7 -> "("
    * f8 -> "String"
    * f9 -> "["
    * f10 -> "]"
    * f11 -> Identifier()
    * f12 -> ")"
    * f13 -> "{"
    * f14 -> ( VarDeclaration() )*
    * f15 -> ( Statement() )*
    * f16 -> "}"
    * f17 -> "}"
    */
    @Override
    public ExprInfo visit(MainClass n, Object obj) throws Exception {

        this.symTable.enter();  // MainClass scope
        this.symTable.enter();  // main() scope
        this.CounterInit();
        Scope mainFunScope = this.symTable.getCurrScope();
        //FunInfo fInfo = (FunInfo)(mainFunScope.getInfo());
        this.writer.write("\ndefine i32 @main() { \n");
        this.writer.flush();

        Iterator<VarInfo> varIt = mainFunScope.getVariables().values().iterator(); 
        VarInfo vInfo = varIt.next();  // Args skipped
        while(varIt.hasNext()){
            vInfo = varIt.next();
            String varName = vInfo.getName();
            String varType = vInfo.getIRType();
            this.writer.write("     ");
            instr_alloca(varType, "%" + varName);
            /*if(fInfo.getParameters().containsKey(varName)){
                instr_store(varType, "%." + varName , varType +"*", "%" + varName);
            }*/
        }

        this.writer.write("\n     ret i32 0\n}\n");
        this.writer.flush();

        for(Node node: n.f15.nodes)
           node.accept(this, null);
        this.symTable.exit(); // main() scope
        this.symTable.exit(); // MainClass scope
        
        return null;
    }

    /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> ( VarDeclaration() )*
    * f4 -> ( MethodDeclaration() )*
    * f5 -> "}"
    */
    @Override
    public ExprInfo visit(ClassDeclaration n, Object obj) throws Exception {

        this.symTable.enter(); // ClassDeclaration scope
        for(Node node: n.f4.nodes)
            node.accept(this, null);
        this.symTable.exit(); // ClassDeclaration scope
        
        return null;
    }

    /**
     * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "extends"
    * f3 -> Identifier()
    * f4 -> "{"
    * f5 -> ( VarDeclaration() )*
    * f6 -> ( MethodDeclaration() )*
    * f7 -> "}"
    */
    @Override
    public ExprInfo visit(ClassExtendsDeclaration n, Object obj) throws Exception {
        
        this.symTable.enter(); // ClassExtendsDeclaration scope
        for(Node node: n.f6.nodes)
            node.accept(this, null);
        this.symTable.exit(); // ClassExtendsDeclaration scope

        return null;
    }
    

    /**
    * f0 -> "public"
    * f1 -> Type()
    * f2 -> Identifier()
    * f3 -> "("
    * f4 -> ( FormalParameterList() )?
    * f5 -> ")"
    * f6 -> "{"
    * f7 -> ( VarDeclaration() )*
    * f8 -> ( Statement() )*
    * f9 -> "return"
    * f10 -> Expression()
    * f11 -> ";"
    * f12 -> "}"
    */
    @Override
    public ExprInfo visit(MethodDeclaration n, Object obj) throws Exception {

        this.symTable.enter();  // MethodDeclaration scope
        this.CounterInit();
        Scope funScope = this.symTable.getCurrScope();
        FunInfo fInfo = (FunInfo)(funScope.getInfo());
        instr_define(fInfo);
        for(VarInfo vInfo : funScope.getVariables().values()){
            String varName = vInfo.getName();
            String varType = vInfo.getIRType();
            this.writer.write("     ");
            instr_alloca(varType, "%" + varName);
            if(fInfo.getParameters().containsKey(varName))
                instr_store(varType, "%." + varName , varType +"*", "%" + varName);
        }

        for(Node node: n.f8.nodes)
            node.accept(this, null);
        n.f10.accept(this, null);
        this.symTable.exit(); // MethodDeclaration scope

        return null;
    }


    /**
    * f0 -> PrimaryExpression()
    * f1 -> "&&"
    * f2 -> PrimaryExpression()
    */
    @Override
    public ExprInfo visit(AndExpression n, Object obj) throws Exception {
        String thenLabel = this.newLabel();
        String elseLabel = this.newLabel();
        String endLabel = this.newLabel();
        ExprInfo res1 = n.f0.accept(this, obj);
        if(res1.getType().contains("*")) // Non constant is returned
            res1 = this.instr_load(res1.getType(), res1.getName());
        this.instr_cond_br(res1.getName(), thenLabel, elseLabel);
        this.writer.write("\n" + thenLabel +":\n");  // Left expression is true so the result depends on the right expression
        this.writer.flush();
        ExprInfo res2 = n.f2.accept(this, obj);
        if(res2.getType().contains("*")) // Non constant is returned
            res2 = this.instr_load(res2.getType(), res2.getName());
        this.instr_br(endLabel);
        this.writer.write("\n" + elseLabel +":\n");
        this.writer.flush();
        this.instr_br(endLabel);
        this.writer.write("\n" + endLabel +":\n");
        this.writer.flush();
        
        return this.instr_phi(res1.getType(), res2.getName(), thenLabel, res1.getName(), elseLabel); // Right result if control flow entered the "then" block and left result if control flow entered the "else" block
     }
  
     /**
      * f0 -> PrimaryExpression()
      * f1 -> "<"
      * f2 -> PrimaryExpression()
    */
    @Override
    public ExprInfo visit(CompareExpression n, Object obj) throws Exception {
        
        n.f0.accept(this, null);
        n.f1.accept(this, null);
        n.f2.accept(this, null);
        return null;
    }




    @Override
    public ExprInfo visit(IntegerLiteral n, Object obj) throws Exception {
        return new ExprInfo(n.f0.toString(), "i32");
    }
  
    @Override
    public ExprInfo visit(TrueLiteral n, Object obj) throws Exception {
        return new ExprInfo("1", "i1"); // Every non zero value is true
    }
  
    @Override
    public ExprInfo visit(FalseLiteral n, Object obj) throws Exception {
        return new ExprInfo("0", "i1"); // Zero value is false
    }
  
    @Override
    public ExprInfo visit(Identifier n, Object obj) throws Exception {
        return new ExprInfo(n.f0.toString(), null); // Type will be defined later
    }
  
    @Override
    public ExprInfo visit(ThisExpression n, Object obj) throws Exception {
        return new ExprInfo("%this", "i8*");
    }

    /**
    * f0 -> "new"
    * f1 -> "int"
    * f2 -> "["
    * f3 -> Expression()
    * f4 -> "]"
    */
    @Override
    public ExprInfo visit(ArrayAllocationExpression n, Object obj) throws Exception {    
        String thenLabel = this.newLabel();
        String elseLabel = this.newLabel();
        ExprInfo length = n.f3.accept(this, null);
        if(length.getType().contains("*")) // Non constant is returned
            length = this.instr_load(length.getType(), length.getName());
        ExprInfo res = this.instr_icmp("slt", length.getType() , length.getName(), "0"); // Bounds checking
        this.instr_cond_br(res.getName(), thenLabel, elseLabel);
        this.throw_out_of_bounds(thenLabel, elseLabel);
        this.writer.write("\n" + elseLabel +":\n");
        this.writer.flush();
        length = this.instr_math_op("add", length.getType() , length.getName(), "1"); // 1 extra byte for saving the array length
        res = this.calloc_call(String.valueOf(4), length.getName()); // Allocation of 4 * length bytes (4 ints)
        res = this.instr_bitcast(res.getType(), res.getName(), "i32*"); // Cast to i32* (int*)
        this.instr_store(length.getType(), length.getName(), res.getType(), res.getName()); // Length saved at the beginning of the array

        return this.instr_gep("i32", res.getType(), res.getName(), String.valueOf(1)); // Array pointer has been moved to the real start of the array
    }

    /**
    * f0 -> "new"
    * f1 -> Identifier()
    * f2 -> "("
    * f3 -> ")"
    */
    public ExprInfo visit(AllocationExpression n, Object obj) throws Exception {
        String idName = n.f1.accept(this, null).getName();
        ClassInfo cInfo = this.symTable.lookupClass(idName);
        VTable vTable = cInfo.getVTable();
        ExprInfo ret = this.calloc_call("1", String.valueOf(cInfo.getCurrVarOffset() + 8)); // Object size equals to the size of the vTable pointer (8 bytes) plus the size of all its fields (current offset)
        ExprInfo res = this.instr_bitcast(ret.getType(), ret.getName(), "i8***" ); // Pointer at the beginning of the allocated memory changed to a vTable pointer (vTable is of type i8**)
        String tmpReg = this.newTempReg();
        String pType = "[" + vTable.getFunctions().size() + " x i8*]";
        this.writer.write("    " + tmpReg + " = getelementptr " + pType + ", " + pType + "* @." + vTable.getName() + ", i32 0, i32 0\n" ); // vTable
        this.writer.flush();
        this.instr_store("i8**", tmpReg, res.getType(), res.getName()); // vTable is stored at the beginning of the allocated memory

        return ret;
    }

    /**
    * f0 -> "!"
    * f1 -> PrimaryExpression()
    */
    public ExprInfo visit(NotExpression n, Object obj) throws Exception {
        ExprInfo res = n.f1.accept(this, obj);
        if(res.getType().contains("*")) // Non constant is returned
            res = this.instr_load(res.getType(), res.getName());
        return this.instr_math_op("xor", res.getType(), res.getName() , "1"); // Complement by xor operation -> 1(true) xor 1 = 0 (false) , 0(false) xor 1 = 1 (true)
    }

    /**
     * f0 -> "("
    * f1 -> Expression()
    * f2 -> ")"
    */
    public ExprInfo visit(BracketExpression n, Object obj) throws Exception {
        return n.f1.accept(this, obj);
    }




















    public void IRInit() throws Exception {

        Iterator<ClassInfo> classIt = this.globalScope.getClasses().values().iterator();
        ClassInfo cInfo = classIt.next(); // MainClass
        this.writer.write("@." + cInfo.getName() + "_vtable = global [0 x i8*] []\n"); // MainClass has only the pseudo static main function which cannot be part of vtable
        this.writer.flush();
        while(classIt.hasNext()){ 
            cInfo = classIt.next();
            this.symTable.UniqueFunNames(cInfo);
            this.symTable.VTableCreate(cInfo); 
            this.writer.write(cInfo.getVTable().toString());
            this.writer.flush();
        }

        //Common constants, declarations and definitions
        this.writer.write("\n\ndeclare i8* @calloc(i32, i32)\ndeclare i32 @printf(i8*, ...)\ndeclare void @exit(i32)\n\n@_cint = constant [4 x i8] c\"%d\\0a\\00\"\n");
        this.writer.flush();
        this.writer.write("@_cOOB = constant [15 x i8] c\"Out of bounds\\0a\\00\"\ndefine void @print_int(i32 %i) {\n    %_str = bitcast [4 x i8]* @_cint to i8*\n    ");
        this.writer.flush(); 
        this.writer.write("call i32 (i8*, ...) @printf(i8* %_str, i32 %i)\n    ret void\n}\n\ndefine void @throw_oob() {\n    %_str = bitcast [15 x i8]* @_cOOB to i8*\n    ");
        this.writer.flush();
        this.writer.write("call i32 (i8*, ...) @printf(i8* %_str)\n    call void @exit(i32 1)\n    ret void\n}\n");
        this.writer.flush();    
        
    }

    public void CounterInit(){
        this.regCounter = 0;
        this.labCounter = 0;
    }

    public String newTempReg() {
        return "%_" + this.regCounter++;

    }

    public String newLabel() {
        return "label" + this.labCounter++;
    }

    public void throw_out_of_bounds(String sLabel, String eLabel) {
        this.writer.write("\n"+ sLabel +":\n    call void @throw_oob()\n");
        this.writer.flush();
        this.instr_br(eLabel);
    }

    public void instr_define(FunInfo fInfo) {
        this.writer.write("\ndefine " + fInfo.getIRType() + " @" + fInfo.getName() +"(i8* %this");
        this.writer.flush();
          
        for(VarInfo vInfo : fInfo.getParameters().values()){
                this.writer.write(", " + vInfo.getIRType() + " %." + vInfo.getName());
                this.writer.flush();
        }

        this.writer.write(") {\n");
        this.writer.flush();
    }

    public void instr_alloca(String type, String regName) {
        this.writer.write(regName + " = alloca " + type +"\n" );
        this.writer.flush();
    }

    public void instr_store(String type1, String regName1, String type2, String regName2) {
        this.writer.write("    store "+ type1 + " " + regName1 +", "+ type2 + " " + regName2 + "\n" );
        this.writer.flush();
    }

    public ExprInfo instr_load(String type, String regName) {
        String tmpReg = this.newTempReg();
        String retType = type.substring(0, type.length() - 1);
        this.writer.write("    " + tmpReg + " = load "+ retType + ", " + type + " " + regName + "\n");
        this.writer.flush();
        return new ExprInfo(tmpReg, retType); // Result is stored at tmpReg and the value type is returned
    }

    public ExprInfo instr_icmp(String operation, String type, String lOperand, String rOperand) {
        String tmpReg = this.newTempReg();
        this.writer.write("    " + tmpReg + " = icmp " + operation + " " + type + " " + lOperand + ", " + rOperand + "\n");
        this.writer.flush();
        return new ExprInfo(tmpReg, "i1"); // Result is stored at tmpReg and the type is i1
    }

    public ExprInfo instr_math_op(String operation, String type, String lOperand, String rOperand) {
        String tmpReg = this.newTempReg();
        this.writer.write("    " + tmpReg + " = " + operation + " " + type + " " + lOperand + ", " + rOperand + "\n");
        this.writer.flush();
        return new ExprInfo(tmpReg, type); // Result is stored at tmpReg and the type remains the same
    }

    public ExprInfo instr_bitcast(String type1, String regName, String type2) {
        String tmpReg = this.newTempReg();
        this.writer.write("    " + tmpReg +" = bitcast "+ type1 + " " + regName + " to " + type2 + "\n");
        this.writer.flush();
        return new ExprInfo(tmpReg,type2);  // Result is stored at tmpReg and the type changes to the new type
    }

    public ExprInfo calloc_call(String nitems, String size) {
        String tmpReg = this.newTempReg();
        this.writer.write("    " + tmpReg +" = call i8* @calloc(i32 "+ nitems +", i32 "+ size +")\n");
        this.writer.flush();
        return new ExprInfo(tmpReg, "i8*");
    }

    public void instr_cond_br(String regName, String thenLabel, String elseLabel ) {
        this.writer.write("    br i1 " + regName + ", label " + thenLabel + ", label " + elseLabel + "\n");
        this.writer.flush();

    }

    public void instr_br(String label) {
        this.writer.write("    br label " + label + "\n");
        this.writer.flush();
    }

    public ExprInfo instr_gep(String type1, String type2, String ptr, String idx) {
        String tmpReg = this.newTempReg();
        this.writer.write("    " + tmpReg +" = getelementptr "+ type1 +", "+ type2 + " " + ptr + ", i32 "+ idx +"\n");
        this.writer.flush();
        return new ExprInfo(tmpReg, type2);
    }

    public ExprInfo instr_phi(String type, String optReg1, String optLab1, String optReg2, String optLab2) {
        String tmpReg = this.newTempReg();
        this.writer.write("    " + tmpReg +" = phi "+ type +" ["+ optReg1 +", "+ optLab1 + "], [" + optReg2 +", "+ optLab2 + "]\n");
        this.writer.flush();
        return new ExprInfo(tmpReg, type);
    }
    

}