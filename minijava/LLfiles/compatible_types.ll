@.Main_vtable = global [0 x i8*] []
@.A_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*)* @A.test to i8*), i8* bitcast (i32 (i8*,i8*)* @A.test2 to i8*), i8* bitcast (i32 (i8*)* @A.test3 to i8*)]
@.B_vtable = global [0 x i8*] []
@.C_vtable = global [0 x i8*] []
@.D_vtable = global [0 x i8*] []


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

define i32 @A.test(i8* %this) {
    %b = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 8)
    store i8* %_0, i8** %b
    %c = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 8)
    store i8* %_1, i8** %c
    %_2 = call i8* @calloc(i32 1, i32 8)
    %_3 = bitcast i8* %_2 to i8**
    %_4 = getelementptr [0 x i8*], [0 x i8*]* @.C_vtable, i32 0, i32 0
    %_5 = bitcast i8** %_4 to i8*
    store i8* %_5, i8** %_3
    store i8* %_2, i8** %c
    %_6 = load i8*, i8** %c
    store i8* %_6, i8** %b

    ret i32 1
}

define i32 @A.test2(i8* %this, i8* %.b) {
    %b = alloca i8*
    store i8* %.b, i8** %b

    ret i32 2
}

define i32 @A.test3(i8* %this) {
    %c = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 8)
    store i8* %_0, i8** %c
    %d = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 8)
    store i8* %_1, i8** %d
    %_2 = call i8* @calloc(i32 1, i32 8)
    %_3 = bitcast i8* %_2 to i8**
    %_4 = getelementptr [0 x i8*], [0 x i8*]* @.C_vtable, i32 0, i32 0
    %_5 = bitcast i8** %_4 to i8*
    store i8* %_5, i8** %_3
    store i8* %_2, i8** %c
    %_6 = call i8* @calloc(i32 1, i32 8)
    %_7 = bitcast i8* %_6 to i8**
    %_8 = getelementptr [0 x i8*], [0 x i8*]* @.D_vtable, i32 0, i32 0
    %_9 = bitcast i8** %_8 to i8*
    store i8* %_9, i8** %_7
    store i8* %_6, i8** %d
    %_10 = bitcast i8* %this to i8**
    %_11 = load i8*, i8** %_10
    %_12 = getelementptr i8, i8* %_11, i32 8
    %_13 = bitcast i8* %_12 to i8**
    %_14 = load i8*, i8** %_13
    %_15 = bitcast i8* %_14 to i32 (i8*, i8*)*
    %_17 = load i8*, i8** %c
    %_16 = call i32 %_15(i8* %this, i8* %_17)
    %_18 = bitcast i8* %this to i8**
    %_19 = load i8*, i8** %_18
    %_20 = getelementptr i8, i8* %_19, i32 8
    %_21 = bitcast i8* %_20 to i8**
    %_22 = load i8*, i8** %_21
    %_23 = bitcast i8* %_22 to i32 (i8*, i8*)*
    %_25 = load i8*, i8** %d
    %_24 = call i32 %_23(i8* %this, i8* %_25)
    %_26 = add i32 %_16, %_24

    ret i32 %_26
}
