@.Main_vtable = global [0 x i8*] []
@.A_vtable = global [2 x i8*] [i8* bitcast (i32 (i8*,i32*,i32)* @A.test to i8*), i8* bitcast (i32 (i8*,i32,i32)* @A.test2 to i8*)]


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


    ret i32 0
}

define i32 @A.test(i8* %this, i32* %.b, i32 %.c) {
    %b = alloca i32*
    store i32* %.b, i32** %b
    %c = alloca i32
    store i32 %.c, i32* %c
    %_0 = bitcast i8* %this to i8**
    %_1 = load i8*, i8** %_0
    %_2 = getelementptr i8, i8* %_1, i32 0
    %_3 = bitcast i8* %_2 to i8**
    %_4 = load i8*, i8** %_3
    %_5 = bitcast i8* %_4 to i32 (i8*, i32*, i32)*
    %_7 = load i32*, i32** %b
    %_8 = load i32*, i32** %b
    %_9 = load i32, i32* %c
    %_10 = getelementptr i32, i32* %_8, i32 -1
    %_11 = load i32, i32* %_10
    %_12 = icmp ult i32 %_9, %_11
    br i1 %_12, label %label0, label %label1

label0:
    %_13 = getelementptr i32, i32* %_8, i32 %_9
    %_14 = load i32, i32* %_13
    br label %label2

label1:
    call void @throw_oob()
    br label %label2

label2:
    %_6 = call i32 %_5(i8* %this, i32* %_7, i32 %_14)

    ret i32 %_6
}

define i32 @A.test2(i8* %this, i32 %.a, i32 %.b) {
    %a = alloca i32
    store i32 %.a, i32* %a
    %b = alloca i32
    store i32 %.b, i32* %b
    %_0 = call i8* @calloc(i32 1, i32 12)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [2 x i8*], [2 x i8*]* @.A_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1
    %_4 = bitcast i8* %_0 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = getelementptr i8, i8* %_5, i32 8
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %_7
    %_9 = bitcast i8* %_8 to i32 (i8*, i32, i32)*
    %_11 = load i32, i32* %a
    %_12 = sub i32 %_11, 1
    %_13 = load i32, i32* %b
    %_14 = load i32, i32* %a
    %_15 = add i32 %_13, %_14
    %_10 = call i32 %_9(i8* %_0, i32 %_12, i32 %_15)

    ret i32 %_10
}
