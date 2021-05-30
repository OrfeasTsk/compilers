@.Main_vtable = global [0 x i8*] []


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
    %b = alloca i32*
    %_0 = call i8* @calloc(i32 0, i32 4)
    %_1 = bitcast i8* %_0 to i32*
    store i32* %_1, i32** %b
    %x = alloca i32
    store i32 0, i32* %x
    %_2 = sub i32 1, 2
    store i32 %_2, i32* %x
    %_3 = load i32, i32* %x
    %_4 = icmp slt i32 %_3, 0
    br i1 %_4, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_5 = add i32 %_3, 1
    %_6 = call i8* @calloc(i32 %_5, i32 4)
    %_7 = bitcast i8* %_6 to i32*
    store i32 %_3, i32* %_7
    %_8 = getelementptr i32, i32* %_7, i32 1
    br label %label2

label2:
    store i32* %_8, i32** %b


    ret i32 0
}
