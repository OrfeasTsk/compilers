@.ArrayTest_vtable = global [0 x i8*] []
@.Test_vtable = global [1 x i8*] [i8* bitcast (i8 (i8*,i32)* @Test.start to i8*)]


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
    %n = alloca i8
    store i8 0, i8* %n
    %_0 = call i8* @calloc(i32 1, i32 8)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.Test_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1
    %_4 = bitcast i8* %_0 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = getelementptr i8, i8* %_5, i32 0
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %_7
    %_9 = bitcast i8* %_8 to i8 (i8*, i32)*
    %_10 = call i8 %_9(i8* %_0, i32 10)
    store i8 %_10, i8* %n


    ret i32 0
}

define i8 @Test.start(i8* %this, i32 %.sz) {
    %sz = alloca i32
    store i32 %.sz, i32* %sz
    %b = alloca i32*
    %_0 = call i8* @calloc(i32 0, i32 4)
    %_1 = bitcast i8* %_0 to i32*
    store i32* %_1, i32** %b
    %l = alloca i32
    store i32 0, i32* %l
    %i = alloca i32
    store i32 0, i32* %i
    %_2 = load i32, i32* %sz
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
    store i32* %_7, i32** %b
    %_8 = load i32*, i32** %b
    %_9 = getelementptr i32, i32* %_8, i32 -1
    %_10 = load i32, i32* %_9
    store i32 %_10, i32* %l
    store i32 0, i32* %i
    br label %label4

label4:
    %_11 = load i32, i32* %i
    %_12 = load i32, i32* %l
    %_13 = icmp slt i32 %_11, %_12
    %_14 = zext i1 %_13 to i8
    %_15 = trunc i8 %_14 to i1
    br i1 %_15, label %label3, label %label5

label3:
    %_16 = load i32*, i32** %b
    %_17 = load i32, i32* %i
    %_18 = getelementptr i32, i32* %_16, i32 -1
    %_19 = load i32, i32* %_18
    %_20 = icmp ult i32 %_17, %_19
    br i1 %_20, label %label6, label %label7

label6:
    %_21 = getelementptr i32, i32* %_16, i32 %_17
    %_22 = load i32, i32* %i
    store i32 %_22, i32* %_21
    br label %label8

label7:
    call void @throw_oob()
    br label %label8

label8:
    %_23 = load i32*, i32** %b
    %_24 = load i32, i32* %i
    %_25 = getelementptr i32, i32* %_23, i32 -1
    %_26 = load i32, i32* %_25
    %_27 = icmp ult i32 %_24, %_26
    br i1 %_27, label %label9, label %label10

label9:
    %_28 = getelementptr i32, i32* %_23, i32 %_24
    %_29 = load i32, i32* %_28
    br label %label11

label10:
    call void @throw_oob()
    br label %label11

label11:
    call void (i32) @print_int(i32 %_29)
    %_30 = load i32, i32* %i
    %_31 = add i32 %_30, 1
    store i32 %_31, i32* %i
    br label %label4

label5:

    ret i8 1
}
