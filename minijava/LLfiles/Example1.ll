@.Example1_vtable = global [0 x i8*] []
@.Test1_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*,i32,i8)* @Test1.Start to i8*)]


declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32)

@_cint = constant [4 x i8] c"%d\0a\00"
@_cOOB = constant [15 x i8] c"Out of bounds\0a\00"
define void @print_int(i32 %i) {
    %_str = bitcast [4 x i8]* @_cint to i8*
    call i32 (i8*, ...) @printf(i8* %_str, i32 %i)
    ret void
}

define void @throw_oob() {
    %_str = bitcast [15 x i8]* @_cOOB to i8*
    call i32 (i8*, ...) @printf(i8* %_str)
    call void @exit(i32 1)
    ret void
}

define i32 @main() { 
    %_0 = call i8* @calloc(i32 1, i32 12)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.Test1_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1
    %_4 = bitcast i8* %_0 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = getelementptr i8, i8* %_5, i32 0
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %_7
    %_9 = bitcast i8* %_8 to i32 (i8*, i32, i8)*
    %_10 = call i32 %_9(i8* %_0, i32 5, i8 1)
    call void (i32) @print_int(i32 %_10)


    ret i32 0
}

define i32 @Test1.Start(i8* %this, i32 %.b, i8 %.c) {
    %b = alloca i32
    store i32 %.b, i32* %b
    %c = alloca i8
    store i8 %.c, i8* %c
    %ntb = alloca i8
    store i8 0, i8* %ntb
    %nti = alloca i32*
    %_0 = call i8* @calloc(i32 0, i32 4)
    %_1 = bitcast i8* %_0 to i32*
    store i32* %_1, i32** %nti
    %ourint = alloca i32
    store i32 0, i32* %ourint
    %_2 = load i32, i32* %b
    %_3 = icmp slt i32 %_2, 0
    br i1 %_3, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_4 = add i32 %_2, 1
    %_5 = call i8* @calloc(i32 %_4, i32 4)
    %_6 = bitcast i8* %_5 to i32*
    store i32 %_2, i32* %_6
    %_7 = getelementptr i32, i32* %_6, i32 1
    br label %label2

label2:
    store i32* %_7, i32** %nti
    %_8 = load i32*, i32** %nti
    %_9 = getelementptr i32, i32* %_8, i32 -1
    %_10 = load i32, i32* %_9
    %_11 = icmp ult i32 0, %_10
    br i1 %_11, label %label3, label %label4

label3:
    %_12 = getelementptr i32, i32* %_8, i32 0
    %_13 = load i32, i32* %_12
    br label %label5

label4:
    call void @throw_oob()
    br label %label5

label5:
    store i32 %_13, i32* %ourint
    %_14 = load i32, i32* %ourint
    call void (i32) @print_int(i32 %_14)
    %_15 = load i32*, i32** %nti
    %_16 = getelementptr i32, i32* %_15, i32 -1
    %_17 = load i32, i32* %_16
    %_18 = icmp ult i32 0, %_17
    br i1 %_18, label %label6, label %label7

label6:
    %_19 = getelementptr i32, i32* %_15, i32 0
    %_20 = load i32, i32* %_19
    br label %label8

label7:
    call void @throw_oob()
    br label %label8

label8:

    ret i32 %_20
}
