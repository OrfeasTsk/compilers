@.DerivedCall_vtable = global [0 x i8*] []
@.A_vtable = global [0 x i8*] []
@.B_vtable = global [0 x i8*] []
@.F_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*,i8*)* @F.foo to i8*)]


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
    %i = alloca i32
    store i32 0, i32* %i
    %b = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 16)
    store i8* %_0, i8** %b
    %f = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 8)
    store i8* %_1, i8** %f
    %_2 = call i8* @calloc(i32 1, i32 8)
    %_3 = bitcast i8* %_2 to i8**
    %_4 = getelementptr [1 x i8*], [1 x i8*]* @.F_vtable, i32 0, i32 0
    %_5 = bitcast i8** %_4 to i8*
    store i8* %_5, i8** %_3
    store i8* %_2, i8** %f
    %_6 = call i8* @calloc(i32 1, i32 16)
    %_7 = bitcast i8* %_6 to i8**
    %_8 = getelementptr [0 x i8*], [0 x i8*]* @.B_vtable, i32 0, i32 0
    %_9 = bitcast i8** %_8 to i8*
    store i8* %_9, i8** %_7
    store i8* %_6, i8** %b
    %_10 = load i8*, i8** %f
    %_11 = bitcast i8* %_10 to i8**
    %_12 = load i8*, i8** %_11
    %_13 = getelementptr i8, i8* %_12, i32 0
    %_14 = bitcast i8* %_13 to i8**
    %_15 = load i8*, i8** %_14
    %_16 = bitcast i8* %_15 to i32 (i8*, i8*)*
    %_18 = load i8*, i8** %b
    %_17 = call i32 %_16(i8* %_10, i8* %_18)
    store i32 %_17, i32* %i
    %_19 = load i32, i32* %i
    call void (i32) @print_int(i32 %_19)


    ret i32 0
}

define i32 @F.foo(i8* %this, i8* %.a) {
    %a = alloca i8*
    store i8* %.a, i8** %a

    ret i32 0
}
