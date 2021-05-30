@.Main_vtable = global [0 x i8*] []
@.A_vtable = global [2 x i8*] [i8* bitcast (i32 (i8*)* @A.foo to i8*), i8* bitcast (i32 (i8*,i32,i8)* @A.bar to i8*)]


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
    %dummy = alloca i32
    store i32 0, i32* %dummy
    %a = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 8)
    store i8* %_0, i8** %a
    %_1 = call i8* @calloc(i32 1, i32 8)
    %_2 = bitcast i8* %_1 to i8**
    %_3 = getelementptr [2 x i8*], [2 x i8*]* @.A_vtable, i32 0, i32 0
    %_4 = bitcast i8** %_3 to i8*
    store i8* %_4, i8** %_2
    store i8* %_1, i8** %a
    %_5 = load i8*, i8** %a
    %_6 = bitcast i8* %_5 to i8**
    %_7 = load i8*, i8** %_6
    %_8 = getelementptr i8, i8* %_7, i32 0
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    %_11 = bitcast i8* %_10 to i32 (i8*)*
    %_12 = call i32 %_11(i8* %_5)
    store i32 %_12, i32* %dummy


    ret i32 0
}

define i32 @A.foo(i8* %this) {
    %a = alloca i32
    store i32 0, i32* %a
    %b = alloca i32
    store i32 0, i32* %b
    store i32 3, i32* %a
    br label %label1

label1:
    %_0 = load i32, i32* %a
    %_1 = icmp slt i32 %_0, 4
    %_2 = zext i1 %_1 to i8
    %_3 = trunc i8 %_2 to i1
    br i1 %_3, label %label0, label %label2

label0:
    %_4 = load i32, i32* %a
    %_5 = add i32 %_4, 1
    store i32 %_5, i32* %a
    br label %label1

label2:
    %_6 = load i32, i32* %a
    call void (i32) @print_int(i32 %_6)
    %_7 = bitcast i8* %this to i8**
    %_8 = load i8*, i8** %_7
    %_9 = getelementptr i8, i8* %_8, i32 8
    %_10 = bitcast i8* %_9 to i8**
    %_11 = load i8*, i8** %_10
    %_12 = bitcast i8* %_11 to i32 (i8*, i32, i8)*
    %_13 = call i32 %_12(i8* %this, i32 7, i8 1)
    store i32 %_13, i32* %b
    %_14 = load i32, i32* %b
    call void (i32) @print_int(i32 %_14)

    ret i32 0
}

define i32 @A.bar(i8* %this, i32 %.a, i8 %.cond) {
    %a = alloca i32
    store i32 %.a, i32* %a
    %cond = alloca i8
    store i8 %.cond, i8* %cond
    %b = alloca i32
    store i32 0, i32* %b
    br label %label1

label1:
    %_0 = load i8, i8* %cond
    %_1 = trunc i8 %_0 to i1
    br i1 %_1, label %label0, label %label2

label0:
    %_2 = load i32, i32* %a
    store i32 %_2, i32* %b
    %_3 = load i8, i8* %cond
    %_4 = trunc i8 %_3 to i1
    br i1 %_4, label %label3, label %label4

label3:
    store i32 2, i32* %a
    br label %label5

label4:
    br label %label5

label5:
    store i8 0, i8* %cond
    br label %label1

label2:
    %_5 = load i32, i32* %b

    ret i32 %_5
}
