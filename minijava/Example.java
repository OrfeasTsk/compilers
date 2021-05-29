class Main{

    public static void main(String[] args){
        int x;
        A a;
        B b;
        b = new B();
        a = b;
        System.out.println((a.test(new int[5])));
    }

}


class A{
    int[] x;
    int i;
    boolean flag;
    int j;
    public int foo() { return 2; }
    public boolean fa(int i, int j) { B x; int y; return x.bla(5,5); }
    public int bar() {return 0;}
    public int test(int[] k) {boolean j; j = ((k[2]) < 22) && ((k[2]) < 23); return i; }
}

class B extends A{
    A type;
    int k;
    public int foo() { int y; return 5; }
    public boolean bla(int i, int j) { return true; }
    public int bar() { x = new int[2]; x[1] = 2; return x[2];}
}