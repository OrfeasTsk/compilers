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
    %flag = alloca i8
    store i8 0, i8* %flag
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
    %_7 = load i32*, i32** %b
    %_8 = getelementptr i32, i32* %_7, i32 -1
    %_9 = load i32, i32* %_8
    %_10 = icmp ult i32 2, %_9
    br i1 %_10, label %label10, label %label11

label10:
    %_11 = getelementptr i32, i32* %_7, i32 2
    %_12 = load i32, i32* %_11
    br label %label12

label11:
    call void @throw_oob()
    br label %label12

label12:
    %_13 = icmp slt i32 %_12, 0
    %_14 = zext i1 %_13 to i8
    %_15 = xor i8 %_14, 1
    %_16 = trunc i8 %_15 to i1
    br i1 %_16, label %label6, label %label7

label6:
    %_17 = load i32*, i32** %b
    %_18 = getelementptr i32, i32* %_17, i32 -1
    %_19 = load i32, i32* %_18
    %_20 = icmp ult i32 2, %_19
    br i1 %_20, label %label13, label %label14

label13:
    %_21 = getelementptr i32, i32* %_17, i32 2
    %_22 = load i32, i32* %_21
    br label %label15

label14:
    call void @throw_oob()
    br label %label15

label15:
    %_23 = icmp slt i32 0, %_22
    %_24 = zext i1 %_23 to i8
    %_25 = xor i8 %_24, 1
    br label %label8

label8:
    br label %label9

label7:
    br label %label9

label9:
    %_26 = phi i8 [%_25, %label8], [%_15, %label7]
    %_27 = trunc i8 %_26 to i1
    br i1 %_27, label %label3, label %label4

label3:
    call void (i32) @print_int(i32 1)
    br label %label5

label4:
    call void (i32) @print_int(i32 0)
    br label %label5

label5:


    ret i32 0
}
