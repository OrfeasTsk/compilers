@.Main_vtable = global [0 x i8*] []
@.A_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*)* @A.foo to i8*), i8* bitcast (i1 (i8*,i32,i32)* @A.fa to i8*), i8* bitcast (i32 (i8*)* @A.bar to i8*)]
@.B_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*)* @B.foo to i8*), i8* bitcast (i1 (i8*,i32,i32)* @A.fa to i8*), i8* bitcast (i32 (i8*)* @B.bar to i8*), i8* bitcast (i1 (i8*,i32,i32)* @B.bla to i8*)]


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
    %_0 = call i8* @calloc(i32 1, i32 29)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [4 x i8*], [4 x i8*]* @.B_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1
    %_4 = bitcast i8* %_0 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = getelementptr i8, i8* %_5, i32 16
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %_7
    %_9 = bitcast i8* %_8 to i32 (i8*)*
    %_10 = call i32 %_9(i8* %_0)
    call void (i32) @print_int(i32 %_10)

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
    %y = alloca i32
    %_0 = load i8*, i8** %x
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 24
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i1 (i8*, i32, i32)*
    %_7 = call i1 %_6(i8* %_0, i32 5, i32 5)

    ret i1 %_7
}

define i32 @A.bar(i8* %this) {

    ret i32 0
}

define i32 @B.foo(i8* %this) {

    ret i32 1
}

define i1 @B.bla(i8* %this, i32 %.i, i32 %.j) {
    %i = alloca i32
    store i32 %.i, i32* %i
    %j = alloca i32
    store i32 %.j, i32* %j

    ret i1 1
}

define i32 @B.bar(i8* %this) {

    ret i32 25
}
