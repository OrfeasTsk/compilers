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
    %c = alloca i32
    store i32 0, i32* %c
    %_2 = icmp slt i32 2, 0
    br i1 %_2, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_3 = add i32 2, 1
    %_4 = call i8* @calloc(i32 %_3, i32 4)
    %_5 = bitcast i8* %_4 to i32*
    store i32 2, i32* %_5
    %_6 = getelementptr i32, i32* %_5, i32 1
    br label %label2

label2:
    store i32* %_6, i32** %b
    %_7 = sub i32 0, 1
    store i32 %_7, i32* %c
    %_8 = load i32*, i32** %b
    %_9 = load i32, i32* %c
    %_10 = getelementptr i32, i32* %_8, i32 -1
    %_11 = load i32, i32* %_10
    %_12 = icmp ult i32 %_9, %_11
    br i1 %_12, label %label6, label %label7

label6:
    %_13 = getelementptr i32, i32* %_8, i32 %_9
    %_14 = load i32, i32* %_13
    br label %label8

label7:
    call void @throw_oob()
    br label %label8

label8:
    %_15 = icmp slt i32 %_14, 1
    %_16 = zext i1 %_15 to i8
    %_17 = trunc i8 %_16 to i1
    br i1 %_17, label %label3, label %label4

label3:
    call void (i32) @print_int(i32 1)
    br label %label5

label4:
    call void (i32) @print_int(i32 0)
    br label %label5

label5:


    ret i32 0
}
