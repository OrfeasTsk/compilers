class Main{

    public static void main(String[] args){
        int x;
        System.out.println(new B().bar());
    }

}


class A{
    int[] x;
    int i;
    boolean flag;
    int j;
    public int foo() { return 0; }
    public boolean fa(int i, int j) { B x; int y; return x.bla(5,5); }
    public int bar() {return 0;}
}

class B extends A{
    A type;
    int k;
    public int foo() { int y; y = 1-10; return y; }
    public boolean bla(int i, int j) { return true; }
    public int bar() { x = new int[2]; x[1] = 2; return x[2];}
}