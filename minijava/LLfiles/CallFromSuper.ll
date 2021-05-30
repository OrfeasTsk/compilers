@.CallFromSuper_vtable = global [0 x i8*] []
@.A_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @A.foo to i8*)]
@.B_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @A.foo to i8*)]


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
    %b = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 8)
    store i8* %_0, i8** %b
    %rv = alloca i32
    store i32 0, i32* %rv
    %_1 = call i8* @calloc(i32 1, i32 8)
    %_2 = bitcast i8* %_1 to i8**
    %_3 = getelementptr [1 x i8*], [1 x i8*]* @.B_vtable, i32 0, i32 0
    %_4 = bitcast i8** %_3 to i8*
    store i8* %_4, i8** %_2
    store i8* %_1, i8** %b
    %_5 = load i8*, i8** %b
    %_6 = bitcast i8* %_5 to i8**
    %_7 = load i8*, i8** %_6
    %_8 = getelementptr i8, i8* %_7, i32 0
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    %_11 = bitcast i8* %_10 to i32 (i8*)*
    %_12 = call i32 %_11(i8* %_5)
    store i32 %_12, i32* %rv
    %_13 = load i32, i32* %rv
    call void (i32) @print_int(i32 %_13)


    ret i32 0
}

define i32 @A.foo(i8* %this) {

    ret i32 1
}
