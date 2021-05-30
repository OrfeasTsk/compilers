@.Main_vtable = global [0 x i8*] []
@.ArrayTest_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*,i32)* @ArrayTest.test to i8*)]
@.B_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*,i32)* @B.test to i8*)]


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
    %ab = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 20)
    store i8* %_0, i8** %ab
    %_1 = call i8* @calloc(i32 1, i32 20)
    %_2 = bitcast i8* %_1 to i8**
    %_3 = getelementptr [1 x i8*], [1 x i8*]* @.ArrayTest_vtable, i32 0, i32 0
    %_4 = bitcast i8** %_3 to i8*
    store i8* %_4, i8** %_2
    store i8* %_1, i8** %ab
    %_5 = load i8*, i8** %ab
    %_6 = bitcast i8* %_5 to i8**
    %_7 = load i8*, i8** %_6
    %_8 = getelementptr i8, i8* %_7, i32 0
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    %_11 = bitcast i8* %_10 to i32 (i8*, i32)*
    %_12 = call i32 %_11(i8* %_5, i32 3)
    call void (i32) @print_int(i32 %_12)


    ret i32 0
}

define i32 @ArrayTest.test(i8* %this, i32 %.num) {
    %num = alloca i32
    store i32 %.num, i32* %num
    %i = alloca i32
    store i32 0, i32* %i
    %intArray = alloca i32*
    %_0 = call i8* @calloc(i32 0, i32 4)
    %_1 = bitcast i8* %_0 to i32*
    store i32* %_1, i32** %intArray
    %_2 = load i32, i32* %num
    %_3 = icmp slt i32 %_2, 0
    br i1 %_3, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_4 = add i32 %_2, 1
    %_5 = call i8* @calloc(i32 %_4, i32 4)
    %_6 = bitcast i8* %_5 to i32*
    store i32 %_2, i32* %_6
    %_7 = getelementptr i32, i32* %_6, i32 1
    br label %label2

label2:
    store i32* %_7, i32** %intArray
    %_8 = getelementptr i8, i8* %this, i32 16
    %_9 = bitcast i8* %_8 to i32*
    store i32 0, i32* %_9
    %_10 = getelementptr i8, i8* %this, i32 16
    %_11 = bitcast i8* %_10 to i32*
    %_12 = load i32, i32* %_11
    call void (i32) @print_int(i32 %_12)
    %_13 = load i32*, i32** %intArray
    %_14 = getelementptr i32, i32* %_13, i32 -1
    %_15 = load i32, i32* %_14
    call void (i32) @print_int(i32 %_15)
    store i32 0, i32* %i
    call void (i32) @print_int(i32 111)
    br label %label4

label4:
    %_16 = load i32, i32* %i
    %_17 = load i32*, i32** %intArray
    %_18 = getelementptr i32, i32* %_17, i32 -1
    %_19 = load i32, i32* %_18
    %_20 = icmp slt i32 %_16, %_19
    %_21 = zext i1 %_20 to i8
    %_22 = trunc i8 %_21 to i1
    br i1 %_22, label %label3, label %label5

label3:
    %_23 = load i32, i32* %i
    %_24 = add i32 %_23, 1
    call void (i32) @print_int(i32 %_24)
    %_25 = load i32*, i32** %intArray
    %_26 = load i32, i32* %i
    %_27 = getelementptr i32, i32* %_25, i32 -1
    %_28 = load i32, i32* %_27
    %_29 = icmp ult i32 %_26, %_28
    br i1 %_29, label %label6, label %label7

label6:
    %_30 = getelementptr i32, i32* %_25, i32 %_26
    %_31 = load i32, i32* %i
    %_32 = add i32 %_31, 1
    store i32 %_32, i32* %_30
    br label %label8

label7:
    call void @throw_oob()
    br label %label8

label8:
    %_33 = load i32, i32* %i
    %_34 = add i32 %_33, 1
    store i32 %_34, i32* %i
    br label %label4

label5:
    call void (i32) @print_int(i32 222)
    store i32 0, i32* %i
    br label %label10

label10:
    %_35 = load i32, i32* %i
    %_36 = load i32*, i32** %intArray
    %_37 = getelementptr i32, i32* %_36, i32 -1
    %_38 = load i32, i32* %_37
    %_39 = icmp slt i32 %_35, %_38
    %_40 = zext i1 %_39 to i8
    %_41 = trunc i8 %_40 to i1
    br i1 %_41, label %label9, label %label11

label9:
    %_42 = load i32*, i32** %intArray
    %_43 = load i32, i32* %i
    %_44 = getelementptr i32, i32* %_42, i32 -1
    %_45 = load i32, i32* %_44
    %_46 = icmp ult i32 %_43, %_45
    br i1 %_46, label %label12, label %label13

label12:
    %_47 = getelementptr i32, i32* %_42, i32 %_43
    %_48 = load i32, i32* %_47
    br label %label14

label13:
    call void @throw_oob()
    br label %label14

label14:
    call void (i32) @print_int(i32 %_48)
    %_49 = load i32, i32* %i
    %_50 = add i32 %_49, 1
    store i32 %_50, i32* %i
    br label %label10

label11:
    call void (i32) @print_int(i32 333)
    %_51 = load i32*, i32** %intArray
    %_52 = getelementptr i32, i32* %_51, i32 -1
    %_53 = load i32, i32* %_52

    ret i32 %_53
}

define i32 @B.test(i8* %this, i32 %.num) {
    %num = alloca i32
    store i32 %.num, i32* %num
    %i = alloca i32
    store i32 0, i32* %i
    %intArray = alloca i32*
    %_0 = call i8* @calloc(i32 0, i32 4)
    %_1 = bitcast i8* %_0 to i32*
    store i32* %_1, i32** %intArray
    %_2 = load i32, i32* %num
    %_3 = icmp slt i32 %_2, 0
    br i1 %_3, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_4 = add i32 %_2, 1
    %_5 = call i8* @calloc(i32 %_4, i32 4)
    %_6 = bitcast i8* %_5 to i32*
    store i32 %_2, i32* %_6
    %_7 = getelementptr i32, i32* %_6, i32 1
    br label %label2

label2:
    store i32* %_7, i32** %intArray
    %_8 = getelementptr i8, i8* %this, i32 20
    %_9 = bitcast i8* %_8 to i32*
    store i32 12, i32* %_9
    %_10 = getelementptr i8, i8* %this, i32 20
    %_11 = bitcast i8* %_10 to i32*
    %_12 = load i32, i32* %_11
    call void (i32) @print_int(i32 %_12)
    %_13 = load i32*, i32** %intArray
    %_14 = getelementptr i32, i32* %_13, i32 -1
    %_15 = load i32, i32* %_14
    call void (i32) @print_int(i32 %_15)
    store i32 0, i32* %i
    call void (i32) @print_int(i32 111)
    br label %label4

label4:
    %_16 = load i32, i32* %i
    %_17 = load i32*, i32** %intArray
    %_18 = getelementptr i32, i32* %_17, i32 -1
    %_19 = load i32, i32* %_18
    %_20 = icmp slt i32 %_16, %_19
    %_21 = zext i1 %_20 to i8
    %_22 = trunc i8 %_21 to i1
    br i1 %_22, label %label3, label %label5

label3:
    %_23 = load i32, i32* %i
    %_24 = add i32 %_23, 1
    call void (i32) @print_int(i32 %_24)
    %_25 = load i32*, i32** %intArray
    %_26 = load i32, i32* %i
    %_27 = getelementptr i32, i32* %_25, i32 -1
    %_28 = load i32, i32* %_27
    %_29 = icmp ult i32 %_26, %_28
    br i1 %_29, label %label6, label %label7

label6:
    %_30 = getelementptr i32, i32* %_25, i32 %_26
    %_31 = load i32, i32* %i
    %_32 = add i32 %_31, 1
    store i32 %_32, i32* %_30
    br label %label8

label7:
    call void @throw_oob()
    br label %label8

label8:
    %_33 = load i32, i32* %i
    %_34 = add i32 %_33, 1
    store i32 %_34, i32* %i
    br label %label4

label5:
    call void (i32) @print_int(i32 222)
    store i32 0, i32* %i
    br label %label10

label10:
    %_35 = load i32, i32* %i
    %_36 = load i32*, i32** %intArray
    %_37 = getelementptr i32, i32* %_36, i32 -1
    %_38 = load i32, i32* %_37
    %_39 = icmp slt i32 %_35, %_38
    %_40 = zext i1 %_39 to i8
    %_41 = trunc i8 %_40 to i1
    br i1 %_41, label %label9, label %label11

label9:
    %_42 = load i32*, i32** %intArray
    %_43 = load i32, i32* %i
    %_44 = getelementptr i32, i32* %_42, i32 -1
    %_45 = load i32, i32* %_44
    %_46 = icmp ult i32 %_43, %_45
    br i1 %_46, label %label12, label %label13

label12:
    %_47 = getelementptr i32, i32* %_42, i32 %_43
    %_48 = load i32, i32* %_47
    br label %label14

label13:
    call void @throw_oob()
    br label %label14

label14:
    call void (i32) @print_int(i32 %_48)
    %_49 = load i32, i32* %i
    %_50 = add i32 %_49, 1
    store i32 %_50, i32* %i
    br label %label10

label11:
    call void (i32) @print_int(i32 333)
    %_51 = load i32*, i32** %intArray
    %_52 = getelementptr i32, i32* %_51, i32 -1
    %_53 = load i32, i32* %_52

    ret i32 %_53
}
