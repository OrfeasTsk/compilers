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
        else if(type.contains("[]")){ //.equals(), .hashCode() and functions are allowed (return type boolean and int respectively) (only for project 2)
          /*  if(funName.equals("equals")){
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
            */
            throw new SemanticError("Function "+ funName +" cannot be found in class " + type); // Cannot call functions on arrays at project 3 because class Object is missing as well as its function implementations
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

class IRCreator extends GJDepthFirst<RegInfo, Object> {

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
    public RegInfo visit(Goal n, Object obj) throws Exception {

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
    public RegInfo visit(MainClass n, Object obj) throws Exception {

        this.symTable.enter();  // MainClass scope
        this.symTable.enter();  // main() scope
        this.CounterInit();
        Scope mainFunScope = this.symTable.getCurrScope();
        //FunInfo fInfo = (FunInfo)(mainFunScope.getInfo());
        this.emit("\ndefine i32 @main() { \n");

        Iterator<VarInfo> varIt = mainFunScope.getVariables().values().iterator(); 
        VarInfo vInfo = varIt.next();  // Args skipped
        while(varIt.hasNext()){
            vInfo = varIt.next();
            String varName = vInfo.getName();
            String varType = vInfo.getIRType();
            this.emit("     ");
            instr_alloca(varType, "%" + varName);
            /*if(fInfo.getParameters().containsKey(varName)){
                instr_store(varType, "%." + varName , varType +"*", "%" + varName);
            }*/
        }

        this.emit("\n     ret i32 0\n}\n");

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
    public RegInfo visit(ClassDeclaration n, Object obj) throws Exception {

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
    public RegInfo visit(ClassExtendsDeclaration n, Object obj) throws Exception {
        
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
    public RegInfo visit(MethodDeclaration n, Object obj) throws Exception {

        this.symTable.enter();  // MethodDeclaration scope
        this.CounterInit();
        Scope funScope = this.symTable.getCurrScope();
        FunInfo fInfo = (FunInfo)(funScope.getInfo());
        this.instr_define(fInfo);
        for(VarInfo vInfo : funScope.getVariables().values()){
            String varName = vInfo.getName();
            String varType = vInfo.getIRType();
            this.emit("     ");
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
    public RegInfo visit(AndExpression n, Object obj) throws Exception {

        String thenLabel = this.newLabel();
        String elseLabel = this.newLabel();
        String endLabel = this.newLabel();
        RegInfo res1 = n.f0.accept(this, obj);
        String regName1 = res1.getName();
        if(res1.getIRType().equals("i1*")) // Non constant is returned
            regName1 = this.instr_load("i1*", regName1);
        this.instr_cond_br(regName1, thenLabel, elseLabel);
        this.emit("\n" + thenLabel +":\n");  // Left expression is true so the result depends on the right expression
        RegInfo res2 = n.f2.accept(this, obj);
        String regName2 = res2.getName();
        if(res2.getIRType().contains("i1*")) // Non constant is returned
            regName2 = this.instr_load("i1*", regName2);
        this.instr_br(endLabel);
        this.emit("\n" + elseLabel +":\n");
        this.instr_br(endLabel);
        this.emit("\n" + endLabel +":\n");
        regName1 = this.instr_phi("i1", regName2, thenLabel, regName1, elseLabel); // Right result if control flow entered the "then" block and left result if control flow entered the "else" block

        return new RegInfo(regName1, "i1", "boolean");
     }
  
    /**
    * f0 -> PrimaryExpression()
    * f1 -> "<"
    * f2 -> PrimaryExpression()
    */
    @Override
    public RegInfo visit(CompareExpression n, Object obj) throws Exception {
        
        RegInfo res1 = n.f0.accept(this, obj);
        String regName1 = res1.getName();
        if(res1.getIRType().equals("i32*")) // Non constant is returned
            regName1 = this.instr_load("i32*", regName1);
        RegInfo res2 = n.f2.accept(this, obj);
        String regName2 = res2.getName();
        if(res2.getIRType().equals("i32*")) // Non constant is returned
            regName2 = this.instr_load("i32*", regName2);
        regName1 = this.instr_icmp("slt", "i32" , regName1, regName2); 
        
        return new RegInfo(regName1, "i1", "boolean");
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "+"
    * f2 -> PrimaryExpression()
    */
    @Override
    public RegInfo visit(PlusExpression n, Object obj) throws Exception {

        RegInfo res1 = n.f0.accept(this, obj);
        String regName1 = res1.getName();
        if(res1.getIRType().equals("i32*")) // Non constant is returned
            regName1 = this.instr_load("i32*", regName1);
        RegInfo res2 = n.f2.accept(this, obj);
        String regName2 = res2.getName();
        if(res2.getIRType().equals("i32*")) // Non constant is returned
            regName2 = this.instr_load("i32*", regName2);
        regName1 = this.instr_math_op("add", "i32", regName1, regName2);
        
        return new RegInfo(regName1, "i32", "int");
    }

    /**
     * f0 -> PrimaryExpression()
    * f1 -> "-"
    * f2 -> PrimaryExpression()
    */
    @Override
    public RegInfo visit(MinusExpression n, Object obj) throws Exception {

        RegInfo res1 = n.f0.accept(this, obj);
        String regName1 = res1.getName();
        if(res1.getIRType().equals("i32*")) // Non constant is returned
            regName1 = this.instr_load("i32*", regName1);
        RegInfo res2 = n.f2.accept(this, obj);
        String regName2 = res2.getName();
        if(res2.getIRType().equals("i32*")) // Non constant is returned
            regName2 = this.instr_load("i32*", regName2);
        regName1 = this.instr_math_op("sub", "i32", regName1, regName2);
        
        return new RegInfo(regName1, "i32", "int");
    }

    /**
     * f0 -> PrimaryExpression()
    * f1 -> "*"
    * f2 -> PrimaryExpression()
    */
    @Override
    public RegInfo visit(TimesExpression n, Object obj) throws Exception {

        RegInfo res1 = n.f0.accept(this, obj);
        String regName1 = res1.getName();
        if(res1.getIRType().equals("i32*")) // Non constant is returned
            regName1 = this.instr_load("i32*", regName1);
        RegInfo res2 = n.f2.accept(this, obj);
        String regName2 = res2.getName();
        if(res2.getIRType().equals("i32*")) // Non constant is returned
            regName2 = this.instr_load("i32*", regName2);
        regName1 = this.instr_math_op("mul", "i32", regName1, regName2);
        
        return new RegInfo(regName1, "i32", "int");
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "["
    * f2 -> PrimaryExpression()
    * f3 -> "]"
    */
    public RegInfo visit(ArrayLookup n, Object obj) throws Exception {

        String thenLabel = this.newLabel();
        String elseLabel = this.newLabel();
        String endLabel = this.newLabel();
        RegInfo res1 = n.f0.accept(this, obj);
        String regName1 = res1.getName();
        if(res1.getIRType().equals("i32**")) // A pointer to the array is returned
            regName1 = this.instr_load("i32**", regName1);
        RegInfo res2 = n.f2.accept(this, obj);
        String regName2 = res2.getName();
        if(res2.getIRType().equals("i32*")) // Non constant is returned
            regName2 = this.instr_load("i32*", regName2);
        String regName = this.instr_gep("i32", "i32*", regName1, String.valueOf(-1)); // Pointer to the length of the array
        regName = this.instr_load("i32*", regName); //  Length of the array 
        regName = this.instr_icmp("ult", "i32" , regName2, regName); // Bounds checking (unsigned check because if the signed value is negative its unsigned value is larger than every signed positive value)
        this.instr_cond_br(regName, thenLabel, elseLabel);
        this.emit("\n" + thenLabel +":\n");
        regName = this.instr_gep("i32", "i32*", regName1, regName2); // A pointer to the requested element
        regName = this.instr_load("i32*", regName); // Element of the array is loaded because the lookup expression always returns a value in minijava
        this.instr_br(endLabel);
        this.throw_out_of_bounds(elseLabel, endLabel);
        this.emit("\n" + endLabel +":\n");
        
        return new RegInfo(regName, "i32", "int");
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "."
    * f2 -> "length"
    */
    @Override
    public RegInfo visit(ArrayLength n, Object obj) throws Exception {

        RegInfo res = n.f0.accept(this, obj);
        String regName = res.getName();
        if(res.getIRType().equals("i32**")) // A pointer to the array is returned
            regName = this.instr_load("i32**", regName);
        regName = this.instr_gep("i32", "i32*", regName, String.valueOf(-1)); // Pointer to the length of the array
        regName = this.instr_load("i32*", regName); //  Length of the array 
        
        return new RegInfo(regName, "i32", "int");
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "."
    * f2 -> Identifier()
    * f3 -> "("
    * f4 -> ( ExpressionList() )?
    * f5 -> ")"
    */
    public RegInfo visit(MessageSend n, Object obj) throws Exception {
       
        RegInfo caller = n.f0.accept(this, obj);
        String callerName = caller.getName();
        if(caller.getIRType().equals("i8**")) // A pointer to the array is returned
            callerName = this.instr_load("i8**", callerName);
        String regName = this.instr_bitcast("i8*", callerName, "i8**"); // In order to get the pointer to the beginning of the vTable
        regName = this.instr_load("i8**", regName); // Pointer to the first byte of vTable
        Info info = new Info();
        n.f2.accept(this, info); // Info contains the name of the function
        FunInfo fInfo = this.symTable.lookupFun(caller.getExprType(), info.getName());
        regName = this.instr_gep("i8", "i8*", regName, String.valueOf(fInfo.getOffset())); // Pointer to the function offset in the vTable
        regName = this.instr_bitcast("i8*", regName, "i8**"); // Function pointer fixed
        regName = this.instr_load("i8**", regName); // Function loaded
        String funStr = fInfo.getIRType() + " (i8*";
        for(VarInfo vInfo : fInfo.getParameters().values())
            funStr += "," + vInfo.getIRType();
        funStr += ")*"; 
        regName = this.instr_bitcast("i8*", regName, funStr); // From i8* to function pointer

        StringBuilder argsBuilder = new StringBuilder();
        argsBuilder.append("    call " + fInfo.getIRType() + " " + regName + "(i8* " + callerName);
        if(n.f4.present())
            n.f4.accept(this, argsBuilder);
        this.emit(argsBuilder.toString() + ")\n");
        
        return null;
    }

    /**
    * f0 -> Expression()
    * f1 -> ExpressionTail()
    */
    public RegInfo visit(ExpressionList n, Object obj) throws Exception {
        
        StringBuilder argsBuilder = (StringBuilder)obj;
        RegInfo res = n.f0.accept(this, null);
        String type = toIRType(res.getExprType()); // Real type of expression
        String regName = res.getName();
        if(res.getIRType().equals(type + "*")) // A pointer is returned
            regName = this.instr_load(type, regName);
        argsBuilder.append(", " + regName);
        n.f1.accept(this, argsBuilder);

        return null;
    }

    /**
     * f0 -> ( ExpressionTerm() )*
    */
    @Override
    public RegInfo visit(ExpressionTail n, Object obj) throws Exception {

        for(Node node: n.f0.nodes) // Getting all the other arguments
            node.accept(this, obj);

        return null;
    }

    /**
     * f0 -> ","
    * f1 -> Expression()
    */
    public RegInfo visit(ExpressionTerm n, Object obj) throws Exception {

        StringBuilder argsBuilder = (StringBuilder)obj;
        RegInfo res = n.f1.accept(this, null);
        String type = toIRType(res.getExprType()); // Real type of expression
        String regName = res.getName();
        if(res.getIRType().equals(type + "*")) // A pointer is returned
            regName = this.instr_load(type, regName);
        argsBuilder.append(", " + regName);

        return null;
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
    public RegInfo visit(PrimaryExpression n, Object obj) throws Exception {
        if(n.f0.which == 3) // If the choice is identifier (so the register name and type of the variable must be returned)
            return n.f0.accept(this, null);
        else
            return n.f0.accept(this, obj);
    }

    @Override
    public RegInfo visit(IntegerLiteral n, Object obj) throws Exception {
        return new RegInfo(n.f0.toString(), "i32", "int");
    }
  
    @Override
    public RegInfo visit(TrueLiteral n, Object obj) throws Exception {
        return new RegInfo("1", "i1", "boolean"); // Every non zero value is true
    }
  
    @Override
    public RegInfo visit(FalseLiteral n, Object obj) throws Exception {
        return new RegInfo("0", "i1", "boolean"); // Zero value is false
    }
  
    @Override
    public RegInfo visit(Identifier n, Object obj) throws Exception {

        if(obj != null){
            Info info = (Info)obj;
            info.setName(n.f0.toString());
            return null;  // Only the name of the indentifier was needed
        }
        else{ // Info for register name and type will be returned only if obj is null (identifier is variable) 
            Scope scope = this.symTable.lookupScopeOfVar(n.f0.toString()); // A scope will always be found
            VarInfo vInfo = scope.searchVar(n.f0.toString());
            if(scope.getType() == 'c'){
                String regName = this.instr_gep("i8", "i8*", "%this", String.valueOf(vInfo.getOffset() + 8)); // Field is located 8 bytes (vTable size) after its offset 
                regName = this.instr_bitcast("i8*", regName, vInfo.getIRType() + "*"); // A pointer to the allocated memory will be returned
                return new RegInfo(regName, vInfo.getIRType() + "*", vInfo.getType()); 
            }
            else
                return new RegInfo("%" + vInfo.getName(), vInfo.getIRType() + "*", vInfo.getType());  // A pointer to the stack (same with the pointer of alloca) will be returned
        }
    }

  
    @Override
    public RegInfo visit(ThisExpression n, Object obj) throws Exception {
        ClassInfo cInfo = this.symTable.lookupClass();
        return new RegInfo("%this", "i8*", cInfo.getName());
    }

    /**
    * f0 -> "new"
    * f1 -> "int"
    * f2 -> "["
    * f3 -> Expression()
    * f4 -> "]"
    */
    @Override
    public RegInfo visit(ArrayAllocationExpression n, Object obj) throws Exception {   
         
        String thenLabel = this.newLabel();
        String elseLabel = this.newLabel();
        String endLabel = this.newLabel();
        RegInfo res = n.f3.accept(this, obj);
        String lenRegName = res.getName();
        if(res.getIRType().equals("i32*")) // Non constant is returned
            lenRegName = this.instr_load("i32*", lenRegName);
        String regName = this.instr_icmp("slt", "i32" , lenRegName, "0"); // Bounds checking
        this.instr_cond_br(regName, thenLabel, elseLabel);
        this.throw_out_of_bounds(thenLabel, endLabel);
        this.emit("\n" + elseLabel +":\n");
        lenRegName = this.instr_math_op("add", "i32" , lenRegName, "1"); // 1 extra byte for saving the array length
        regName = this.calloc_call(String.valueOf(4), lenRegName); // Allocation of 4 * length bytes (4 ints)
        regName = this.instr_bitcast("i8*", regName, "i32*"); // Cast to i32* (int*)
        this.instr_store("i32", lenRegName, "i32*", regName); // Length saved at the beginning of the array
        regName = this.instr_gep("i32", "i32*", regName, String.valueOf(1)); // Array pointer has been moved to the real start of the array
        this.instr_br(endLabel);
        this.emit("\n" + endLabel +":\n");
        
        return new RegInfo(regName, "i32*", "int[]");
    }

    /**
    * f0 -> "new"
    * f1 -> Identifier()
    * f2 -> "("
    * f3 -> ")"
    */
    public RegInfo visit(AllocationExpression n, Object obj) throws Exception {

        Info info = new Info();
        n.f1.accept(this, info); // Name of the identifier
        String idName = info.getName();
        ClassInfo cInfo = this.symTable.lookupClass(idName);
        VTable vTable = cInfo.getVTable();
        String retRegName = this.calloc_call("1", String.valueOf(cInfo.getCurrVarOffset() + 8)); // Object size equals to the size of the vTable pointer (8 bytes) plus the size of all its fields (current offset)
        String regName = this.instr_bitcast("i8*", retRegName, "i8**" ); // Pointer to the beginning of the allocated memory changed to a pointer to a pointer to the beginning of vTable
        String tmpReg = this.newTempReg();
        String pType = "[" + vTable.getFunctions().size() + " x i8*]";
        this.emit("    " + tmpReg + " = getelementptr " + pType + ", " + pType + "* @." + vTable.getName() + ", i32 0, i32 0\n" ); // vTable
        tmpReg = this.instr_bitcast("i8**", tmpReg, "i8*" ); // Pointer to the first byte of vTable
        this.instr_store("i8*", tmpReg, "i8**", regName); // vTable is stored at the beginning of the allocated memory

        return new RegInfo(retRegName, "i8*", idName);
    }

    /**
    * f0 -> "!"
    * f1 -> PrimaryExpression()
    */
    public RegInfo visit(NotExpression n, Object obj) throws Exception {

        RegInfo res = n.f1.accept(this, obj);
        String regName = res.getName();
        if(res.getIRType().equals("i1*")) // Non constant is returned
            regName = this.instr_load("i1*", regName);
        regName = this.instr_math_op("xor", "i1", regName , "1"); // Complement by xor operation -> 1(true) xor 1 = 0 (false) , 0(false) xor 1 = 1 (true)
        
        return new RegInfo(regName, "i1", "boolean");
    }

    /**
     * f0 -> "("
    * f1 -> Expression()
    * f2 -> ")"
    */
    public RegInfo visit(BracketExpression n, Object obj) throws Exception {
        return n.f1.accept(this, obj);
    }




















    public void IRInit() throws Exception {

        Iterator<ClassInfo> classIt = this.globalScope.getClasses().values().iterator();
        ClassInfo cInfo = classIt.next(); // MainClass
        this.emit("@." + cInfo.getName() + "_vtable = global [0 x i8*] []\n"); // MainClass has only the pseudo static main function which cannot be part of vtable
        while(classIt.hasNext()){ 
            cInfo = classIt.next();
            this.symTable.UniqueFunNames(cInfo);
            this.symTable.VTableCreate(cInfo); 
            this.emit(cInfo.getVTable().toString());
        }

        //Common constants, declarations and definitions
        this.emit("\n\ndeclare i8* @calloc(i32, i32)\ndeclare i32 @printf(i8*, ...)\ndeclare void @exit(i32)\n\n@_cint = constant [4 x i8] c\"%d\\0a\\00\"\n");
        this.emit("@_cOOB = constant [15 x i8] c\"Out of bounds\\0a\\00\"\ndefine void @print_int(i32 %i) {\n    %_str = bitcast [4 x i8]* @_cint to i8*\n    ");
        this.emit("call i32 (i8*, ...) @printf(i8* %_str, i32 %i)\n    ret void\n}\n\ndefine void @throw_oob() {\n    %_str = bitcast [15 x i8]* @_cOOB to i8*\n    ");
        this.emit("call i32 (i8*, ...) @printf(i8* %_str)\n    call void @exit(i32 1)\n    ret void\n}\n");   
        
    }

    public void CounterInit(){
        this.regCounter = 0;
        this.labCounter = 0;
    }

    public void emit(String str){
        this.writer.write(str);
        this.writer.flush();
    }

    public static String toIRType(String type) {

        if(type.equals("int"))
            return "i32";
        else if(type.equals("boolean"))
            return "i1";
        else if(type.equals("int[]"))
            return "i32*";
        else
            return "i8*"; 
    }

    public String newTempReg() {
        return "%_" + this.regCounter++;

    }

    public String newLabel() {
        return "label" + this.labCounter++;
    }

    public void throw_out_of_bounds(String sLabel, String eLabel) {
        this.emit("\n"+ sLabel +":\n    call void @throw_oob()\n");
        this.instr_br(eLabel);
    }

    public void instr_define(FunInfo fInfo) {
        this.emit("\ndefine " + fInfo.getIRType() + " @" + fInfo.getName() +"(i8* %this");
        for(VarInfo vInfo : fInfo.getParameters().values())
                this.emit(", " + vInfo.getIRType() + " %." + vInfo.getName());

        this.emit(") {\n");
    }

    public void instr_alloca(String type, String regName) {
        this.emit(regName + " = alloca " + type +"\n" );
    }

    public void instr_store(String type1, String regName1, String type2, String regName2) {
        this.emit("    store "+ type1 + " " + regName1 +", "+ type2 + " " + regName2 + "\n" );
    }

    public String instr_load(String type, String regName) {
        String tmpReg = this.newTempReg();
        String retType = type.substring(0, type.length() - 1);
        this.emit("    " + tmpReg + " = load "+ retType + ", " + type + " " + regName + "\n");
        return tmpReg; // Result is stored at tmpReg
    }

    public String instr_icmp(String operation, String type, String lOperand, String rOperand) {
        String tmpReg = this.newTempReg();
        this.emit("    " + tmpReg + " = icmp " + operation + " " + type + " " + lOperand + ", " + rOperand + "\n");
        return tmpReg; // Result is stored at tmpReg
    }

    public String instr_math_op(String operation, String type, String lOperand, String rOperand) {
        String tmpReg = this.newTempReg();
        this.emit("    " + tmpReg + " = " + operation + " " + type + " " + lOperand + ", " + rOperand + "\n");
        return tmpReg; // Result is stored at tmpReg
    }

    public String instr_bitcast(String type1, String regName, String type2) {
        String tmpReg = this.newTempReg();
        this.emit("    " + tmpReg +" = bitcast "+ type1 + " " + regName + " to " + type2 + "\n");
        return tmpReg;  // Result is stored at tmpReg
    }

    public String calloc_call(String nitems, String size) {
        String tmpReg = this.newTempReg();
        this.emit("    " + tmpReg +" = call i8* @calloc(i32 "+ nitems +", i32 "+ size +")\n");
        return tmpReg; // Result is stored at tmpReg
    }

    public void instr_cond_br(String regName, String thenLabel, String elseLabel ) {
        this.emit("    br i1 " + regName + ", label " + thenLabel + ", label " + elseLabel + "\n");
    }

    public void instr_br(String label) {
        this.emit("    br label " + label + "\n");
    }

    public String instr_gep(String type1, String type2, String ptr, String idx) {
        String tmpReg = this.newTempReg();
        this.emit("    " + tmpReg +" = getelementptr "+ type1 +", "+ type2 + " " + ptr + ", i32 "+ idx +"\n");
        return tmpReg; // Result is stored at tmpReg
    }

    public String instr_phi(String type, String optReg1, String optLab1, String optReg2, String optLab2) {
        String tmpReg = this.newTempReg();
        this.emit("    " + tmpReg +" = phi "+ type +" ["+ optReg1 +", "+ optLab1 + "], [" + optReg2 +", "+ optLab2 + "]\n");
        return tmpReg; // Result is stored at tmpReg
    }
    

}