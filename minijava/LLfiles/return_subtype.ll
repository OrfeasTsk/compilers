@.Test1_vtable = global [0 x i8*] []
@.A_vtable = global [1 x i8*] [i8* bitcast (i8* (i8*)* @A.test to i8*)]
@.B_vtable = global [2 x i8*] [i8* bitcast (i8* (i8*)* @A.test to i8*), i8* bitcast (i8 (i8*)* @B.bla to i8*)]


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
    %rv = alloca i8
    store i8 0, i8* %rv
    %a = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 8)
    store i8* %_0, i8** %a
    %b = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 20)
    store i8* %_1, i8** %b
    %_2 = call i8* @calloc(i32 1, i32 20)
    %_3 = bitcast i8* %_2 to i8**
    %_4 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
    %_5 = bitcast i8** %_4 to i8*
    store i8* %_5, i8** %_3
    store i8* %_2, i8** %b


    ret i32 0
}

define i8* @A.test(i8* %this) {
    %_0 = call i8* @calloc(i32 1, i32 20)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1

    ret i8* %_0
}

define i8 @B.bla(i8* %this) {
    %x = alloca i32
    store i32 0, i32* %x

    ret i8 1
}
