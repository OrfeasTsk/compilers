@.Main_vtable = global [0 x i8*] []
@.A_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*)* @A.foo to i8*), i8* bitcast (i1 (i8*,i32,i32)* @A.fa to i8*), i8* bitcast (i32 (i8*)* @A.bar to i8*), i8* bitcast (i32 (i8*)* @A.test to i8*)]
@.B_vtable = global [5 x i8*] [i8* bitcast (i32 (i8*)* @B.foo to i8*), i8* bitcast (i1 (i8*,i32,i32)* @A.fa to i8*), i8* bitcast (i32 (i8*)* @B.bar to i8*), i8* bitcast (i32 (i8*)* @A.test to i8*), i8* bitcast (i1 (i8*,i32,i32)* @B.bla to i8*)]


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
    %x = alloca i32
    store i32 0, i32* %x
    %a = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 25)
    store i8* %_0, i8** %a
    %b = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 37)
    store i8* %_1, i8** %b
    %_2 = call i8* @calloc(i32 1, i32 37)
    %_3 = bitcast i8* %_2 to i8**
    %_4 = getelementptr [5 x i8*], [5 x i8*]* @.B_vtable, i32 0, i32 0
    %_5 = bitcast i8** %_4 to i8*
    store i8* %_5, i8** %_3
    store i8* %_2, i8** %b
    %_6 = load i8*, i8** %b
    store i8* %_6, i8** %a
    %_7 = load i8*, i8** %a
    %_8 = bitcast i8* %_7 to i8**
    %_9 = load i8*, i8** %_8
    %_10 = getelementptr i8, i8* %_9, i32 24
    %_11 = bitcast i8* %_10 to i8**
    %_12 = load i8*, i8** %_11
    %_13 = bitcast i8* %_12 to i32 (i8*)*
    %_14 = call i32 %_13(i8* %_7)
    call void (i32) @print_int(i32 %_14)


    ret i32 0
}

define i32 @A.foo(i8* %this) {

    ret i32 0
}

define i1 @A.fa(i8* %this, i32 %.i, i32 %.j) {
    %i = alloca i32
    store i32 %.i, i32* %i
    %j = alloca i32
    store i32 %.j, i32* %j
    %x = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 37)
    store i8* %_0, i8** %x
    %y = alloca i32
    store i32 0, i32* %y
    %_1 = load i8*, i8** %x
    %_2 = bitcast i8* %_1 to i8**
    %_3 = load i8*, i8** %_2
    %_4 = getelementptr i8, i8* %_3, i32 32
    %_5 = bitcast i8* %_4 to i8**
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i1 (i8*, i32, i32)*
    %_8 = call i1 %_7(i8* %_1, i32 5, i32 5)

    ret i1 %_8
}

define i32 @A.bar(i8* %this) {

    ret i32 0
}

define i32 @A.test(i8* %this) {
    %x = alloca i32
    store i32 0, i32* %x
    %_0 = getelementptr i8, i8* %this, i32 20
    %_1 = bitcast i8* %_0 to i1*
    store i1 0, i1* %_1
    %_2 = getelementptr i8, i8* %this, i32 20
    %_3 = bitcast i8* %_2 to i1*
    %_4 = load i1, i1* %_3
    br i1 %_4, label %label0, label %label1

label0:
    store i32 1, i32* %x
    br label %label2

label1:
    store i32 0, i32* %x
    br label %label2

label2:
    %_5 = load i32, i32* %x

    ret i32 %_5
}

define i32 @B.foo(i8* %this) {
    %y = alloca i32
    store i32 0, i32* %y
    %_0 = load i32, i32* %y

    ret i32 %_0
}

define i1 @B.bla(i8* %this, i32 %.i, i32 %.j) {
    %i = alloca i32
    store i32 %.i, i32* %i
    %j = alloca i32
    store i32 %.j, i32* %j

    ret i1 1
}

define i32 @B.bar(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32**
    %_2 = icmp slt i32 2, 0
    br i1 %_2, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_3 = add i32 2, 1
    %_4 = call i8* @calloc(i32 %_3, i32 4)
    %_5 = bitcast i8* %_4 to i32*
    store i32 2, i32* %_5
    %_6 = getelementptr i32, i32* %_5, i32 1
    br label %label2

label2:
    store i32* %_6, i32** %_1
    %_7 = getelementptr i8, i8* %this, i32 8
    %_8 = bitcast i8* %_7 to i32**
    %_9 = load i32*, i32** %_8
    %_10 = getelementptr i32, i32* %_9, i32 -1
    %_11 = load i32, i32* %_10
    %_12 = icmp ult i32 1, %_11
    br i1 %_12, label %label3, label %label4

label3:
    %_13 = getelementptr i32, i32* %_9, i32 1
    store i32 2, i32* %_13
    br label %label5

label4:
    call void @throw_oob()
    br label %label5

label5:
    %_14 = getelementptr i8, i8* %this, i32 8
    %_15 = bitcast i8* %_14 to i32**
    %_16 = load i32*, i32** %_15
    %_17 = getelementptr i32, i32* %_16, i32 -1
    %_18 = load i32, i32* %_17
    %_19 = icmp ult i32 2, %_18
    br i1 %_19, label %label6, label %label7

label6:
    %_20 = getelementptr i32, i32* %_16, i32 2
    %_21 = load i32, i32* %_20
    br label %label8

label7:
    call void @throw_oob()
    br label %label8

label8:

    ret i32 %_21
}
