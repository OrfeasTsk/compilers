@.LinearSearch_vtable = global [0 x i8*] []
@.LS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*,i32)* @LS.Start to i8*), i8* bitcast (i32 (i8*)* @LS.Print to i8*), i8* bitcast (i32 (i8*,i32)* @LS.Search to i8*), i8* bitcast (i32 (i8*,i32)* @LS.Init to i8*)]


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
    %_0 = call i8* @calloc(i32 1, i32 20)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1
    %_4 = bitcast i8* %_0 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = getelementptr i8, i8* %_5, i32 0
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %_7
    %_9 = bitcast i8* %_8 to i32 (i8*, i32)*
    %_10 = call i32 %_9(i8* %_0, i32 10)
    call void (i32) @print_int(i32 %_10)

    ret i32 0
}

define i32 @LS.Start(i8* %this, i32 %.sz) {
    %sz = alloca i32
    store i32 %.sz, i32* %sz
    %aux01 = alloca i32
    %aux02 = alloca i32
    %_0 = bitcast i8* %this to i8**
    %_1 = load i8*, i8** %_0
    %_2 = getelementptr i8, i8* %_1, i32 24
    %_3 = bitcast i8* %_2 to i8**
    %_4 = load i8*, i8** %_3
    %_5 = bitcast i8* %_4 to i32 (i8*, i32)*
    %_7 = load i32, i32* %sz
    %_6 = call i32 %_5(i8* %this, i32 %_7)
    store i32 %_6, i32* %aux01
    %_8 = bitcast i8* %this to i8**
    %_9 = load i8*, i8** %_8
    %_10 = getelementptr i8, i8* %_9, i32 8
    %_11 = bitcast i8* %_10 to i8**
    %_12 = load i8*, i8** %_11
    %_13 = bitcast i8* %_12 to i32 (i8*)*
    %_14 = call i32 %_13(i8* %this)
    store i32 %_14, i32* %aux02
    call void (i32) @print_int(i32 9999)    %_15 = bitcast i8* %this to i8**
    %_16 = load i8*, i8** %_15
    %_17 = getelementptr i8, i8* %_16, i32 16
    %_18 = bitcast i8* %_17 to i8**
    %_19 = load i8*, i8** %_18
    %_20 = bitcast i8* %_19 to i32 (i8*, i32)*
    %_21 = call i32 %_20(i8* %this, i32 8)
    call void (i32) @print_int(i32 %_21)    %_22 = bitcast i8* %this to i8**
    %_23 = load i8*, i8** %_22
    %_24 = getelementptr i8, i8* %_23, i32 16
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = bitcast i8* %_26 to i32 (i8*, i32)*
    %_28 = call i32 %_27(i8* %this, i32 12)
    call void (i32) @print_int(i32 %_28)    %_29 = bitcast i8* %this to i8**
    %_30 = load i8*, i8** %_29
    %_31 = getelementptr i8, i8* %_30, i32 16
    %_32 = bitcast i8* %_31 to i8**
    %_33 = load i8*, i8** %_32
    %_34 = bitcast i8* %_33 to i32 (i8*, i32)*
    %_35 = call i32 %_34(i8* %this, i32 17)
    call void (i32) @print_int(i32 %_35)    %_36 = bitcast i8* %this to i8**
    %_37 = load i8*, i8** %_36
    %_38 = getelementptr i8, i8* %_37, i32 16
    %_39 = bitcast i8* %_38 to i8**
    %_40 = load i8*, i8** %_39
    %_41 = bitcast i8* %_40 to i32 (i8*, i32)*
    %_42 = call i32 %_41(i8* %this, i32 50)
    call void (i32) @print_int(i32 %_42)
    ret i32 55
}

define i32 @LS.Print(i8* %this) {
    %j = alloca i32
    store i32 1, i32* %j
    br label %label1

label1:
    %_0 = load i32, i32* %j
    %_1 = getelementptr i8, i8* %this, i32 16
    %_2 = bitcast i8* %_1 to i32*
    %_3 = load i32, i32* %_2
    %_4 = icmp slt i32 %_0, %_3
    br i1 %_4, label %label0, label %label2

label0:
    %_5 = getelementptr i8, i8* %this, i32 8
    %_6 = bitcast i8* %_5 to i32**
    %_7 = load i32*, i32** %_6
    %_8 = load i32, i32* %j
    %_9 = getelementptr i32, i32* %_7, i32 -1
    %_10 = load i32, i32* %_9
    %_11 = icmp ult i32 %_8, %_10
    br i1 %_11, label %label3, label %label4

label3:
    %_12 = getelementptr i32, i32* %_7, i32 %_8
    %_13 = load i32, i32* %_12
    br label %label5

label4:
    call void @throw_oob()
    br label %label5

label5:
    call void (i32) @print_int(i32 %_13)    %_14 = load i32, i32* %j
    %_15 = add i32 %_14, 1
    store i32 %_15, i32* %j
    br label %label1

label2:

    ret i32 0
}

define i32 @LS.Search(i8* %this, i32 %.num) {
    %num = alloca i32
    store i32 %.num, i32* %num
    %j = alloca i32
    %ls01 = alloca i1
    %ifound = alloca i32
    %aux01 = alloca i32
    %aux02 = alloca i32
    %nt = alloca i32
    store i32 1, i32* %j
    store i1 0, i1* %ls01
    store i32 0, i32* %ifound
    br label %label1

label1:
    %_0 = load i32, i32* %j
    %_1 = getelementptr i8, i8* %this, i32 16
    %_2 = bitcast i8* %_1 to i32*
    %_3 = load i32, i32* %_2
    %_4 = icmp slt i32 %_0, %_3
    br i1 %_4, label %label0, label %label2

label0:
    %_5 = getelementptr i8, i8* %this, i32 8
    %_6 = bitcast i8* %_5 to i32**
    %_7 = load i32*, i32** %_6
    %_8 = load i32, i32* %j
    %_9 = getelementptr i32, i32* %_7, i32 -1
    %_10 = load i32, i32* %_9
    %_11 = icmp ult i32 %_8, %_10
    br i1 %_11, label %label3, label %label4

label3:
    %_12 = getelementptr i32, i32* %_7, i32 %_8
    %_13 = load i32, i32* %_12
    br label %label5

label4:
    call void @throw_oob()
    br label %label5

label5:
    store i32 %_13, i32* %aux01
    %_14 = load i32, i32* %num
    %_15 = add i32 %_14, 1
    store i32 %_15, i32* %aux02
    %_16 = load i32, i32* %aux01
    %_17 = load i32, i32* %num
    %_18 = icmp slt i32 %_16, %_17
    br i1 %_18, label %label6, label %label7

label6:
    store i32 0, i32* %nt
    br label %label8

label7:
    %_19 = load i32, i32* %aux01
    %_20 = load i32, i32* %aux02
    %_21 = icmp slt i32 %_19, %_20
    %_22 = xor i1 %_21, 1
    br i1 %_22, label %label9, label %label10

label9:
    store i32 0, i32* %nt
    br label %label11

label10:
    store i1 1, i1* %ls01
    store i32 1, i32* %ifound
    %_23 = getelementptr i8, i8* %this, i32 16
    %_24 = bitcast i8* %_23 to i32*
    %_25 = load i32, i32* %_24
    store i32 %_25, i32* %j
    br label %label11

label11:
    br label %label8

label8:
    %_26 = load i32, i32* %j
    %_27 = add i32 %_26, 1
    store i32 %_27, i32* %j
    br label %label1

label2:
    %_28 = load i32, i32* %ifound

    ret i32 %_28
}

define i32 @LS.Init(i8* %this, i32 %.sz) {
    %sz = alloca i32
    store i32 %.sz, i32* %sz
    %j = alloca i32
    %k = alloca i32
    %aux01 = alloca i32
    %aux02 = alloca i32
    %_0 = getelementptr i8, i8* %this, i32 16
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %sz
    store i32 %_2, i32* %_1
    %_3 = getelementptr i8, i8* %this, i32 8
    %_4 = bitcast i8* %_3 to i32**
    %_5 = load i32, i32* %sz
    %_6 = icmp slt i32 %_5, 0
    br i1 %_6, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_7 = add i32 %_5, 1
    %_8 = call i8* @calloc(i32 4, i32 %_7)
    %_9 = bitcast i8* %_8 to i32*
    store i32 %_7, i32* %_9
    %_10 = getelementptr i32, i32* %_9, i32 1
    br label %label2

label2:
    store i32* %_10, i32** %_4
    store i32 1, i32* %j
    %_11 = getelementptr i8, i8* %this, i32 16
    %_12 = bitcast i8* %_11 to i32*
    %_13 = load i32, i32* %_12
    %_14 = add i32 %_13, 1
    store i32 %_14, i32* %k
    br label %label4

label4:
    %_15 = load i32, i32* %j
    %_16 = getelementptr i8, i8* %this, i32 16
    %_17 = bitcast i8* %_16 to i32*
    %_18 = load i32, i32* %_17
    %_19 = icmp slt i32 %_15, %_18
    br i1 %_19, label %label3, label %label5

label3:
    %_20 = load i32, i32* %j
    %_21 = mul i32 2, %_20
    store i32 %_21, i32* %aux01
    %_22 = load i32, i32* %k
    %_23 = sub i32 %_22, 3
    store i32 %_23, i32* %aux02
    %_24 = getelementptr i8, i8* %this, i32 8
    %_25 = bitcast i8* %_24 to i32**
    %_26 = load i32*, i32** %_25
    %_27 = load i32, i32* %j
    %_28 = getelementptr i32, i32* %_26, i32 -1
    %_29 = load i32, i32* %_28
    %_30 = icmp ult i32 %_27, %_29
    br i1 %_30, label %label6, label %label7

label6:
    %_31 = getelementptr i32, i32* %_26, i32 %_27
    %_32 = load i32, i32* %aux01
    %_33 = load i32, i32* %aux02
    %_34 = add i32 %_32, %_33
    store i32 %_34, i32* %_31
    br label %label8

label7:
    call void @throw_oob()
    br label %label8

label8:
    %_35 = load i32, i32* %j
    %_36 = add i32 %_35, 1
    store i32 %_36, i32* %j
    %_37 = load i32, i32* %k
    %_38 = sub i32 %_37, 1
    store i32 %_38, i32* %k
    br label %label4

label5:

    ret i32 0
}
