class Main{

    public static void main(String[] args){
        int x;
    }

}


class A{
    int i;
    boolean flag;
    int j;
    public int foo(int i) { return 0; }
    public int fa() { A x; int y; return x.foo(5); }
}

class B extends A{
    A type;
    int k;
    public int foo(int i) { return 0; }
    public boolean bla() { return true; }
}