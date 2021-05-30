@.Main_vtable = global [0 x i8*] []
@.A_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*,i32)* @A.foo to i8*)]


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
    %_0 = call i8* @calloc(i32 1, i32 8)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.A_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1
    %_4 = bitcast i8* %_0 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = getelementptr i8, i8* %_5, i32 0
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %_7
    %_9 = bitcast i8* %_8 to i32 (i8*, i32)*
    %_10 = call i32 %_9(i8* %_0, i32 1)
    call void (i32) @print_int(i32 %_10)
    %_11 = call i8* @calloc(i32 1, i32 8)
    %_12 = bitcast i8* %_11 to i8**
    %_13 = getelementptr [1 x i8*], [1 x i8*]* @.A_vtable, i32 0, i32 0
    %_14 = bitcast i8** %_13 to i8*
    store i8* %_14, i8** %_12
    %_15 = bitcast i8* %_11 to i8**
    %_16 = load i8*, i8** %_15
    %_17 = getelementptr i8, i8* %_16, i32 0
    %_18 = bitcast i8* %_17 to i8**
    %_19 = load i8*, i8** %_18
    %_20 = bitcast i8* %_19 to i32 (i8*, i32)*
    %_21 = call i32 %_20(i8* %_11, i32 2)
    call void (i32) @print_int(i32 %_21)


    ret i32 0
}

define i32 @A.foo(i8* %this, i32 %.a) {
    %a = alloca i32
    store i32 %.a, i32* %a
    %_0 = load i32, i32* %a
    %_1 = icmp slt i32 %_0, 2
    %_2 = zext i1 %_1 to i8
    %_3 = trunc i8 %_2 to i1
    br i1 %_3, label %label0, label %label1

label0:
    store i32 3, i32* %a
    br label %label2

label1:
    store i32 4, i32* %a
    br label %label2

label2:
    %_4 = load i32, i32* %a

    ret i32 %_4
}
