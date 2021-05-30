@.Main_vtable = global [0 x i8*] []
@.B_vtable = global [0 x i8*] []
@.A_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @A.test to i8*)]
@.D_vtable = global [0 x i8*] []
@.C_vtable = global [2 x i8*] [i8* bitcast (i32* (i8*)* @C.test to i8*), i8* bitcast (i8* (i8*)* @C.test2 to i8*)]
@.F_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @F.a to i8*)]
@.E_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @F.a to i8*)]
@.J_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @J.x to i8*)]


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
    %_0 = call i8* @calloc(i32 1, i32 16)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.A_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1
    %_4 = bitcast i8* %_0 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = getelementptr i8, i8* %_5, i32 0
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %_7
    %_9 = bitcast i8* %_8 to i32 (i8*)*
    %_10 = call i32 %_9(i8* %_0)
    call void (i32) @print_int(i32 %_10)


    ret i32 0
}

define i32 @A.test(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 12
    %_1 = bitcast i8* %_0 to i32*
    store i32 5, i32* %_1
    %_2 = getelementptr i8, i8* %this, i32 12
    %_3 = bitcast i8* %_2 to i32*
    %_4 = load i32, i32* %_3

    ret i32 %_4
}

define i32* @C.test(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 12
    %_1 = bitcast i8* %_0 to i32**
    %_2 = load i32*, i32** %_1

    ret i32* %_2
}

define i8* @C.test2(i8* %this) {
    %a = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 20)
    store i8* %_0, i8** %a
    %_1 = call i8* @calloc(i32 1, i32 20)
    %_2 = bitcast i8* %_1 to i8**
    %_3 = getelementptr [2 x i8*], [2 x i8*]* @.C_vtable, i32 0, i32 0
    %_4 = bitcast i8** %_3 to i8*
    store i8* %_4, i8** %_2
    store i8* %_1, i8** %a
    %_5 = load i8*, i8** %a

    ret i8* %_5
}

define i32 @F.a(i8* %this) {

    ret i32 1
}

define i32 @J.x(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %_1

    ret i32 %_2
}
