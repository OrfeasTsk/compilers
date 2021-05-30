@.Main_vtable = global [0 x i8*] []
@.A_vtable = global [7 x i8*] [i8* bitcast (i8 (i8*)* @A.t to i8*), i8* bitcast (i32 (i8*)* @A.t2 to i8*), i8* bitcast (i32 (i8*,i32*)* @A.lispy to i8*), i8* bitcast (i8 (i8*)* @A.t3 to i8*), i8* bitcast (i8 (i8*,i32,i32*)* @A.t4 to i8*), i8* bitcast (i32 (i8*,i32*)* @A.t5 to i8*), i8* bitcast (i8 (i8*,i8,i32*)* @A.t6 to i8*)]
@.C_vtable = global [1 x i8*] [i8* bitcast (i32* (i8*,i8)* @C.test to i8*)]
@.B_vtable = global [2 x i8*] [i8* bitcast (i32* (i8*,i8)* @C.test to i8*), i8* bitcast (i32* (i8*,i32)* @B.test2 to i8*)]


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


    ret i32 0
}

define i8 @A.t(i8* %this) {
    %_0 = icmp slt i32 1, 2
    %_1 = zext i1 %_0 to i8
    %_2 = xor i8 %_1, 1
    %_3 = trunc i8 %_2 to i1
    br i1 %_3, label %label0, label %label1

label0:
    %_4 = trunc i8 1 to i1
    br i1 %_4, label %label4, label %label5

label4:
    br label %label6

label6:
    br label %label7

label5:
    br label %label7

label7:
    %_5 = phi i8 [0, %label6], [1, %label5]
    br label %label2

label2:
    br label %label3

label1:
    br label %label3

label3:
    %_6 = phi i8 [%_5, %label2], [%_2, %label1]

    ret i8 %_6
}

define i32 @A.t2(i8* %this) {
    %_0 = add i32 1, 2
    %_1 = add i32 %_0, 3
    %_2 = add i32 %_1, 4

    ret i32 %_2
}

define i32 @A.lispy(i8* %this, i32* %.a) {
    %a = alloca i32*
    store i32* %.a, i32** %a
    %_0 = add i32 1, 2
    %_1 = load i32*, i32** %a
    %_2 = getelementptr i32, i32* %_1, i32 -1
    %_3 = load i32, i32* %_2
    %_4 = icmp ult i32 3, %_3
    br i1 %_4, label %label0, label %label1

label0:
    %_5 = getelementptr i32, i32* %_1, i32 3
    %_6 = load i32, i32* %_5
    br label %label2

label1:
    call void @throw_oob()
    br label %label2

label2:
    %_7 = add i32 %_0, %_6

    ret i32 %_7
}

define i8 @A.t3(i8* %this) {
    %a = alloca i32
    store i32 0, i32* %a
    %b = alloca i32
    store i32 0, i32* %b
    store i32 2, i32* %a
    store i32 2, i32* %b
    %_0 = add i32 349, 908
    %_1 = load i32, i32* %a
    %_2 = mul i32 23, %_1
    %_3 = load i32, i32* %b
    %_4 = sub i32 %_3, 2
    %_5 = sub i32 %_2, %_4
    %_6 = icmp slt i32 %_0, %_5
    %_7 = zext i1 %_6 to i8

    ret i8 %_7
}

define i8 @A.t4(i8* %this, i32 %.a, i32* %.b) {
    %a = alloca i32
    store i32 %.a, i32* %a
    %b = alloca i32*
    store i32* %.b, i32** %b
    %arr = alloca i32*
    %_0 = call i8* @calloc(i32 0, i32 4)
    %_1 = bitcast i8* %_0 to i32*
    store i32* %_1, i32** %arr
    %_2 = icmp slt i32 10, 0
    br i1 %_2, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_3 = add i32 10, 1
    %_4 = call i8* @calloc(i32 %_3, i32 4)
    %_5 = bitcast i8* %_4 to i32*
    store i32 10, i32* %_5
    %_6 = getelementptr i32, i32* %_5, i32 1
    br label %label2

label2:
    store i32* %_6, i32** %arr
    %_7 = bitcast i8* %this to i8**
    %_8 = load i8*, i8** %_7
    %_9 = getelementptr i8, i8* %_8, i32 8
    %_10 = bitcast i8* %_9 to i8**
    %_11 = load i8*, i8** %_10
    %_12 = bitcast i8* %_11 to i32 (i8*)*
    %_13 = call i32 %_12(i8* %this)
    %_14 = add i32 29347, %_13
    %_15 = icmp slt i32 %_14, 12
    %_16 = zext i1 %_15 to i8
    %_17 = trunc i8 %_16 to i1
    br i1 %_17, label %label3, label %label4

label3:
    %_18 = load i32, i32* %a
    %_19 = load i32*, i32** %arr
    %_20 = getelementptr i32, i32* %_19, i32 -1
    %_21 = load i32, i32* %_20
    %_22 = icmp ult i32 0, %_21
    br i1 %_22, label %label15, label %label16

label15:
    %_23 = getelementptr i32, i32* %_19, i32 0
    %_24 = load i32, i32* %_23
    br label %label17

label16:
    call void @throw_oob()
    br label %label17

label17:
    %_25 = icmp slt i32 %_18, %_24
    %_26 = zext i1 %_25 to i8
    %_27 = trunc i8 %_26 to i1
    br i1 %_27, label %label11, label %label12

label11:
    %_28 = bitcast i8* %this to i8**
    %_29 = load i8*, i8** %_28
    %_30 = getelementptr i8, i8* %_29, i32 24
    %_31 = bitcast i8* %_30 to i8**
    %_32 = load i8*, i8** %_31
    %_33 = bitcast i8* %_32 to i8 (i8*)*
    %_34 = call i8 %_33(i8* %this)
    br label %label13

label13:
    br label %label14

label12:
    br label %label14

label14:
    %_35 = phi i8 [%_34, %label13], [%_26, %label12]
    %_36 = trunc i8 %_35 to i1
    br i1 %_36, label %label7, label %label8

label7:
    %_37 = bitcast i8* %this to i8**
    %_38 = load i8*, i8** %_37
    %_39 = getelementptr i8, i8* %_38, i32 32
    %_40 = bitcast i8* %_39 to i8**
    %_41 = load i8*, i8** %_40
    %_42 = bitcast i8* %_41 to i8 (i8*, i32, i32*)*
    %_44 = bitcast i8* %this to i8**
    %_45 = load i8*, i8** %_44
    %_46 = getelementptr i8, i8* %_45, i32 8
    %_47 = bitcast i8* %_46 to i8**
    %_48 = load i8*, i8** %_47
    %_49 = bitcast i8* %_48 to i32 (i8*)*
    %_50 = call i32 %_49(i8* %this)
    %_51 = load i32*, i32** %arr
    %_43 = call i8 %_42(i8* %this, i32 %_50, i32* %_51)
    br label %label9

label9:
    br label %label10

label8:
    br label %label10

label10:
    %_52 = phi i8 [%_43, %label9], [%_35, %label8]
    br label %label5

label5:
    br label %label6

label4:
    br label %label6

label6:
    %_53 = phi i8 [%_52, %label5], [%_16, %label4]

    ret i8 %_53
}

define i32 @A.t5(i8* %this, i32* %.a) {
    %a = alloca i32*
    store i32* %.a, i32** %a
    %b = alloca i32
    store i32 0, i32* %b
    %_0 = bitcast i8* %this to i8**
    %_1 = load i8*, i8** %_0
    %_2 = getelementptr i8, i8* %_1, i32 8
    %_3 = bitcast i8* %_2 to i8**
    %_4 = load i8*, i8** %_3
    %_5 = bitcast i8* %_4 to i32 (i8*)*
    %_6 = call i32 %_5(i8* %this)
    %_7 = bitcast i8* %this to i8**
    %_8 = load i8*, i8** %_7
    %_9 = getelementptr i8, i8* %_8, i32 16
    %_10 = bitcast i8* %_9 to i8**
    %_11 = load i8*, i8** %_10
    %_12 = bitcast i8* %_11 to i32 (i8*, i32*)*
    %_14 = load i32*, i32** %a
    %_15 = getelementptr i32, i32* %_14, i32 -1
    %_16 = load i32, i32* %_15
    %_17 = icmp ult i32 0, %_16
    br i1 %_17, label %label15, label %label16

label15:
    %_18 = getelementptr i32, i32* %_14, i32 0
    %_19 = load i32, i32* %_18
    br label %label17

label16:
    call void @throw_oob()
    br label %label17

label17:
    %_20 = icmp slt i32 %_19, 0
    br i1 %_20, label %label12, label %label13

label12:
    call void @throw_oob()
    br label %label14

label13:
    %_21 = add i32 %_19, 1
    %_22 = call i8* @calloc(i32 %_21, i32 4)
    %_23 = bitcast i8* %_22 to i32*
    store i32 %_19, i32* %_23
    %_24 = getelementptr i32, i32* %_23, i32 1
    br label %label14

label14:
    %_13 = call i32 %_12(i8* %this, i32* %_24)
    %_25 = add i32 %_6, %_13
    %_26 = icmp slt i32 %_25, 0
    br i1 %_26, label %label9, label %label10

label9:
    call void @throw_oob()
    br label %label11

label10:
    %_27 = add i32 %_25, 1
    %_28 = call i8* @calloc(i32 %_27, i32 4)
    %_29 = bitcast i8* %_28 to i32*
    store i32 %_25, i32* %_29
    %_30 = getelementptr i32, i32* %_29, i32 1
    br label %label11

label11:
    %_31 = getelementptr i32, i32* %_30, i32 -1
    %_32 = load i32, i32* %_31
    %_33 = icmp ult i32 0, %_32
    br i1 %_33, label %label6, label %label7

label6:
    %_34 = getelementptr i32, i32* %_30, i32 0
    %_35 = load i32, i32* %_34
    br label %label8

label7:
    call void @throw_oob()
    br label %label8

label8:
    %_36 = add i32 %_35, 10
    %_37 = icmp slt i32 %_36, 0
    br i1 %_37, label %label3, label %label4

label3:
    call void @throw_oob()
    br label %label5

label4:
    %_38 = add i32 %_36, 1
    %_39 = call i8* @calloc(i32 %_38, i32 4)
    %_40 = bitcast i8* %_39 to i32*
    store i32 %_36, i32* %_40
    %_41 = getelementptr i32, i32* %_40, i32 1
    br label %label5

label5:
    %_42 = getelementptr i32, i32* %_41, i32 -1
    %_43 = load i32, i32* %_42
    %_44 = icmp ult i32 2, %_43
    br i1 %_44, label %label0, label %label1

label0:
    %_45 = getelementptr i32, i32* %_41, i32 2
    %_46 = load i32, i32* %_45
    br label %label2

label1:
    call void @throw_oob()
    br label %label2

label2:
    store i32 %_46, i32* %b
    %_47 = load i32*, i32** %a
    %_48 = load i32, i32* %b
    %_49 = getelementptr i32, i32* %_47, i32 -1
    %_50 = load i32, i32* %_49
    %_51 = icmp ult i32 %_48, %_50
    br i1 %_51, label %label18, label %label19

label18:
    %_52 = getelementptr i32, i32* %_47, i32 %_48
    %_53 = load i32, i32* %_52
    br label %label20

label19:
    call void @throw_oob()
    br label %label20

label20:

    ret i32 %_53
}

define i8 @A.t6(i8* %this, i8 %.dummy, i32* %.arr) {
    %dummy = alloca i8
    store i8 %.dummy, i8* %dummy
    %arr = alloca i32*
    store i32* %.arr, i32** %arr
    %a = alloca i32
    store i32 0, i32* %a
    %c = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 8)
    store i8* %_0, i8** %c
    store i32 2, i32* %a
    %_1 = call i8* @calloc(i32 1, i32 8)
    %_2 = bitcast i8* %_1 to i8**
    %_3 = getelementptr [1 x i8*], [1 x i8*]* @.C_vtable, i32 0, i32 0
    %_4 = bitcast i8** %_3 to i8*
    store i8* %_4, i8** %_2
    store i8* %_1, i8** %c
    %_5 = bitcast i8* %this to i8**
    %_6 = load i8*, i8** %_5
    %_7 = getelementptr i8, i8* %_6, i32 8
    %_8 = bitcast i8* %_7 to i8**
    %_9 = load i8*, i8** %_8
    %_10 = bitcast i8* %_9 to i32 (i8*)*
    %_11 = call i32 %_10(i8* %this)
    %_12 = add i32 29347, %_11
    %_13 = icmp slt i32 %_12, 12
    %_14 = zext i1 %_13 to i8
    %_15 = trunc i8 %_14 to i1
    br i1 %_15, label %label0, label %label1

label0:
    %_16 = load i32, i32* %a
    %_17 = load i32*, i32** %arr
    %_18 = getelementptr i32, i32* %_17, i32 -1
    %_19 = load i32, i32* %_18
    %_20 = icmp ult i32 0, %_19
    br i1 %_20, label %label12, label %label13

label12:
    %_21 = getelementptr i32, i32* %_17, i32 0
    %_22 = load i32, i32* %_21
    br label %label14

label13:
    call void @throw_oob()
    br label %label14

label14:
    %_23 = icmp slt i32 %_16, %_22
    %_24 = zext i1 %_23 to i8
    %_25 = trunc i8 %_24 to i1
    br i1 %_25, label %label8, label %label9

label8:
    %_26 = bitcast i8* %this to i8**
    %_27 = load i8*, i8** %_26
    %_28 = getelementptr i8, i8* %_27, i32 24
    %_29 = bitcast i8* %_28 to i8**
    %_30 = load i8*, i8** %_29
    %_31 = bitcast i8* %_30 to i8 (i8*)*
    %_32 = call i8 %_31(i8* %this)
    br label %label10

label10:
    br label %label11

label9:
    br label %label11

label11:
    %_33 = phi i8 [%_32, %label10], [%_24, %label9]
    %_34 = trunc i8 %_33 to i1
    br i1 %_34, label %label4, label %label5

label4:
    %_35 = bitcast i8* %this to i8**
    %_36 = load i8*, i8** %_35
    %_37 = getelementptr i8, i8* %_36, i32 48
    %_38 = bitcast i8* %_37 to i8**
    %_39 = load i8*, i8** %_38
    %_40 = bitcast i8* %_39 to i8 (i8*, i8, i32*)*
    %_42 = bitcast i8* %this to i8**
    %_43 = load i8*, i8** %_42
    %_44 = getelementptr i8, i8* %_43, i32 32
    %_45 = bitcast i8* %_44 to i8**
    %_46 = load i8*, i8** %_45
    %_47 = bitcast i8* %_46 to i8 (i8*, i32, i32*)*
    %_49 = call i8* @calloc(i32 1, i32 8)
    %_50 = bitcast i8* %_49 to i8**
    %_51 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
    %_52 = bitcast i8** %_51 to i8*
    store i8* %_52, i8** %_50
    %_53 = bitcast i8* %_49 to i8**
    %_54 = load i8*, i8** %_53
    %_55 = getelementptr i8, i8* %_54, i32 0
    %_56 = bitcast i8* %_55 to i8**
    %_57 = load i8*, i8** %_56
    %_58 = bitcast i8* %_57 to i32* (i8*, i8)*
    %_59 = call i32* %_58(i8* %_49, i8 1)
    %_60 = getelementptr i32, i32* %_59, i32 -1
    %_61 = load i32, i32* %_60
    %_62 = icmp ult i32 0, %_61
    br i1 %_62, label %label15, label %label16

label15:
    %_63 = getelementptr i32, i32* %_59, i32 0
    %_64 = load i32, i32* %_63
    br label %label17

label16:
    call void @throw_oob()
    br label %label17

label17:
    %_65 = load i32*, i32** %arr
    %_48 = call i8 %_47(i8* %this, i32 %_64, i32* %_65)
    %_66 = load i32*, i32** %arr
    %_67 = getelementptr i32, i32* %_66, i32 -1
    %_68 = load i32, i32* %_67
    %_69 = icmp ult i32 0, %_68
    br i1 %_69, label %label21, label %label22

label21:
    %_70 = getelementptr i32, i32* %_66, i32 0
    %_71 = load i32, i32* %_70
    br label %label23

label22:
    call void @throw_oob()
    br label %label23

label23:
    %_72 = icmp slt i32 %_71, 0
    br i1 %_72, label %label18, label %label19

label18:
    call void @throw_oob()
    br label %label20

label19:
    %_73 = add i32 %_71, 1
    %_74 = call i8* @calloc(i32 %_73, i32 4)
    %_75 = bitcast i8* %_74 to i32*
    store i32 %_71, i32* %_75
    %_76 = getelementptr i32, i32* %_75, i32 1
    br label %label20

label20:
    %_41 = call i8 %_40(i8* %this, i8 %_48, i32* %_76)
    br label %label6

label6:
    br label %label7

label5:
    br label %label7

label7:
    %_77 = phi i8 [%_41, %label6], [%_33, %label5]
    br label %label2

label2:
    br label %label3

label1:
    br label %label3

label3:
    %_78 = phi i8 [%_77, %label2], [%_14, %label1]

    ret i8 %_78
}

define i32* @C.test(i8* %this, i8 %.a) {
    %a = alloca i8
    store i8 %.a, i8* %a
    %_0 = icmp slt i32 10, 0
    br i1 %_0, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_1 = add i32 10, 1
    %_2 = call i8* @calloc(i32 %_1, i32 4)
    %_3 = bitcast i8* %_2 to i32*
    store i32 10, i32* %_3
    %_4 = getelementptr i32, i32* %_3, i32 1
    br label %label2

label2:

    ret i32* %_4
}

define i32* @B.test2(i8* %this, i32 %.i) {
    %i = alloca i32
    store i32 %.i, i32* %i
    %_0 = load i32, i32* %i
    %_1 = icmp slt i32 %_0, 0
    br i1 %_1, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_2 = add i32 %_0, 1
    %_3 = call i8* @calloc(i32 %_2, i32 4)
    %_4 = bitcast i8* %_3 to i32*
    store i32 %_0, i32* %_4
    %_5 = getelementptr i32, i32* %_4, i32 1
    br label %label2

label2:

    ret i32* %_5
}
