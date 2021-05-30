@.BubbleSort_vtable = global [0 x i8*] []
@.BBS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*,i32)* @BBS.Start to i8*), i8* bitcast (i32 (i8*)* @BBS.Sort to i8*), i8* bitcast (i32 (i8*)* @BBS.Print to i8*), i8* bitcast (i32 (i8*,i32)* @BBS.Init to i8*)]


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
    %_2 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 0
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

define i32 @BBS.Start(i8* %this, i32 %.sz) {
    %sz = alloca i32
    store i32 %.sz, i32* %sz
    %aux01 = alloca i32
    store i32 0, i32* %aux01
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
    %_10 = getelementptr i8, i8* %_9, i32 16
    %_11 = bitcast i8* %_10 to i8**
    %_12 = load i8*, i8** %_11
    %_13 = bitcast i8* %_12 to i32 (i8*)*
    %_14 = call i32 %_13(i8* %this)
    store i32 %_14, i32* %aux01
    call void (i32) @print_int(i32 99999)
    %_15 = bitcast i8* %this to i8**
    %_16 = load i8*, i8** %_15
    %_17 = getelementptr i8, i8* %_16, i32 8
    %_18 = bitcast i8* %_17 to i8**
    %_19 = load i8*, i8** %_18
    %_20 = bitcast i8* %_19 to i32 (i8*)*
    %_21 = call i32 %_20(i8* %this)
    store i32 %_21, i32* %aux01
    %_22 = bitcast i8* %this to i8**
    %_23 = load i8*, i8** %_22
    %_24 = getelementptr i8, i8* %_23, i32 16
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = bitcast i8* %_26 to i32 (i8*)*
    %_28 = call i32 %_27(i8* %this)
    store i32 %_28, i32* %aux01

    ret i32 0
}

define i32 @BBS.Sort(i8* %this) {
    %nt = alloca i32
    store i32 0, i32* %nt
    %i = alloca i32
    store i32 0, i32* %i
    %aux02 = alloca i32
    store i32 0, i32* %aux02
    %aux04 = alloca i32
    store i32 0, i32* %aux04
    %aux05 = alloca i32
    store i32 0, i32* %aux05
    %aux06 = alloca i32
    store i32 0, i32* %aux06
    %aux07 = alloca i32
    store i32 0, i32* %aux07
    %j = alloca i32
    store i32 0, i32* %j
    %t = alloca i32
    store i32 0, i32* %t
    %_0 = getelementptr i8, i8* %this, i32 16
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %_1
    %_3 = sub i32 %_2, 1
    store i32 %_3, i32* %i
    %_4 = sub i32 0, 1
    store i32 %_4, i32* %aux02
    br label %label1

label1:
    %_5 = load i32, i32* %aux02
    %_6 = load i32, i32* %i
    %_7 = icmp slt i32 %_5, %_6
    %_8 = zext i1 %_7 to i8
    %_9 = trunc i8 %_8 to i1
    br i1 %_9, label %label0, label %label2

label0:
    store i32 1, i32* %j
    br label %label4

label4:
    %_10 = load i32, i32* %j
    %_11 = load i32, i32* %i
    %_12 = add i32 %_11, 1
    %_13 = icmp slt i32 %_10, %_12
    %_14 = zext i1 %_13 to i8
    %_15 = trunc i8 %_14 to i1
    br i1 %_15, label %label3, label %label5

label3:
    %_16 = load i32, i32* %j
    %_17 = sub i32 %_16, 1
    store i32 %_17, i32* %aux07
    %_18 = getelementptr i8, i8* %this, i32 8
    %_19 = bitcast i8* %_18 to i32**
    %_20 = load i32*, i32** %_19
    %_21 = load i32, i32* %aux07
    %_22 = getelementptr i32, i32* %_20, i32 -1
    %_23 = load i32, i32* %_22
    %_24 = icmp ult i32 %_21, %_23
    br i1 %_24, label %label6, label %label7

label6:
    %_25 = getelementptr i32, i32* %_20, i32 %_21
    %_26 = load i32, i32* %_25
    br label %label8

label7:
    call void @throw_oob()
    br label %label8

label8:
    store i32 %_26, i32* %aux04
    %_27 = getelementptr i8, i8* %this, i32 8
    %_28 = bitcast i8* %_27 to i32**
    %_29 = load i32*, i32** %_28
    %_30 = load i32, i32* %j
    %_31 = getelementptr i32, i32* %_29, i32 -1
    %_32 = load i32, i32* %_31
    %_33 = icmp ult i32 %_30, %_32
    br i1 %_33, label %label9, label %label10

label9:
    %_34 = getelementptr i32, i32* %_29, i32 %_30
    %_35 = load i32, i32* %_34
    br label %label11

label10:
    call void @throw_oob()
    br label %label11

label11:
    store i32 %_35, i32* %aux05
    %_36 = load i32, i32* %aux05
    %_37 = load i32, i32* %aux04
    %_38 = icmp slt i32 %_36, %_37
    %_39 = zext i1 %_38 to i8
    %_40 = trunc i8 %_39 to i1
    br i1 %_40, label %label12, label %label13

label12:
    %_41 = load i32, i32* %j
    %_42 = sub i32 %_41, 1
    store i32 %_42, i32* %aux06
    %_43 = getelementptr i8, i8* %this, i32 8
    %_44 = bitcast i8* %_43 to i32**
    %_45 = load i32*, i32** %_44
    %_46 = load i32, i32* %aux06
    %_47 = getelementptr i32, i32* %_45, i32 -1
    %_48 = load i32, i32* %_47
    %_49 = icmp ult i32 %_46, %_48
    br i1 %_49, label %label15, label %label16

label15:
    %_50 = getelementptr i32, i32* %_45, i32 %_46
    %_51 = load i32, i32* %_50
    br label %label17

label16:
    call void @throw_oob()
    br label %label17

label17:
    store i32 %_51, i32* %t
    %_52 = getelementptr i8, i8* %this, i32 8
    %_53 = bitcast i8* %_52 to i32**
    %_54 = load i32*, i32** %_53
    %_55 = load i32, i32* %aux06
    %_56 = getelementptr i32, i32* %_54, i32 -1
    %_57 = load i32, i32* %_56
    %_58 = icmp ult i32 %_55, %_57
    br i1 %_58, label %label18, label %label19

label18:
    %_59 = getelementptr i32, i32* %_54, i32 %_55
    %_60 = getelementptr i8, i8* %this, i32 8
    %_61 = bitcast i8* %_60 to i32**
    %_62 = load i32*, i32** %_61
    %_63 = load i32, i32* %j
    %_64 = getelementptr i32, i32* %_62, i32 -1
    %_65 = load i32, i32* %_64
    %_66 = icmp ult i32 %_63, %_65
    br i1 %_66, label %label21, label %label22

label21:
    %_67 = getelementptr i32, i32* %_62, i32 %_63
    %_68 = load i32, i32* %_67
    br label %label23

label22:
    call void @throw_oob()
    br label %label23

label23:
    store i32 %_68, i32* %_59
    br label %label20

label19:
    call void @throw_oob()
    br label %label20

label20:
    %_69 = getelementptr i8, i8* %this, i32 8
    %_70 = bitcast i8* %_69 to i32**
    %_71 = load i32*, i32** %_70
    %_72 = load i32, i32* %j
    %_73 = getelementptr i32, i32* %_71, i32 -1
    %_74 = load i32, i32* %_73
    %_75 = icmp ult i32 %_72, %_74
    br i1 %_75, label %label24, label %label25

label24:
    %_76 = getelementptr i32, i32* %_71, i32 %_72
    %_77 = load i32, i32* %t
    store i32 %_77, i32* %_76
    br label %label26

label25:
    call void @throw_oob()
    br label %label26

label26:
    br label %label14

label13:
    store i32 0, i32* %nt
    br label %label14

label14:
    %_78 = load i32, i32* %j
    %_79 = add i32 %_78, 1
    store i32 %_79, i32* %j
    br label %label4

label5:
    %_80 = load i32, i32* %i
    %_81 = sub i32 %_80, 1
    store i32 %_81, i32* %i
    br label %label1

label2:

    ret i32 0
}

define i32 @BBS.Print(i8* %this) {
    %j = alloca i32
    store i32 0, i32* %j
    store i32 0, i32* %j
    br label %label1

label1:
    %_0 = load i32, i32* %j
    %_1 = getelementptr i8, i8* %this, i32 16
    %_2 = bitcast i8* %_1 to i32*
    %_3 = load i32, i32* %_2
    %_4 = icmp slt i32 %_0, %_3
    %_5 = zext i1 %_4 to i8
    %_6 = trunc i8 %_5 to i1
    br i1 %_6, label %label0, label %label2

label0:
    %_7 = getelementptr i8, i8* %this, i32 8
    %_8 = bitcast i8* %_7 to i32**
    %_9 = load i32*, i32** %_8
    %_10 = load i32, i32* %j
    %_11 = getelementptr i32, i32* %_9, i32 -1
    %_12 = load i32, i32* %_11
    %_13 = icmp ult i32 %_10, %_12
    br i1 %_13, label %label3, label %label4

label3:
    %_14 = getelementptr i32, i32* %_9, i32 %_10
    %_15 = load i32, i32* %_14
    br label %label5

label4:
    call void @throw_oob()
    br label %label5

label5:
    call void (i32) @print_int(i32 %_15)
    %_16 = load i32, i32* %j
    %_17 = add i32 %_16, 1
    store i32 %_17, i32* %j
    br label %label1

label2:

    ret i32 0
}

define i32 @BBS.Init(i8* %this, i32 %.sz) {
    %sz = alloca i32
    store i32 %.sz, i32* %sz
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
    %_8 = call i8* @calloc(i32 %_7, i32 4)
    %_9 = bitcast i8* %_8 to i32*
    store i32 %_5, i32* %_9
    %_10 = getelementptr i32, i32* %_9, i32 1
    br label %label2

label2:
    store i32* %_10, i32** %_4
    %_11 = getelementptr i8, i8* %this, i32 8
    %_12 = bitcast i8* %_11 to i32**
    %_13 = load i32*, i32** %_12
    %_14 = getelementptr i32, i32* %_13, i32 -1
    %_15 = load i32, i32* %_14
    %_16 = icmp ult i32 0, %_15
    br i1 %_16, label %label3, label %label4

label3:
    %_17 = getelementptr i32, i32* %_13, i32 0
    store i32 20, i32* %_17
    br label %label5

label4:
    call void @throw_oob()
    br label %label5

label5:
    %_18 = getelementptr i8, i8* %this, i32 8
    %_19 = bitcast i8* %_18 to i32**
    %_20 = load i32*, i32** %_19
    %_21 = getelementptr i32, i32* %_20, i32 -1
    %_22 = load i32, i32* %_21
    %_23 = icmp ult i32 1, %_22
    br i1 %_23, label %label6, label %label7

label6:
    %_24 = getelementptr i32, i32* %_20, i32 1
    store i32 7, i32* %_24
    br label %label8

label7:
    call void @throw_oob()
    br label %label8

label8:
    %_25 = getelementptr i8, i8* %this, i32 8
    %_26 = bitcast i8* %_25 to i32**
    %_27 = load i32*, i32** %_26
    %_28 = getelementptr i32, i32* %_27, i32 -1
    %_29 = load i32, i32* %_28
    %_30 = icmp ult i32 2, %_29
    br i1 %_30, label %label9, label %label10

label9:
    %_31 = getelementptr i32, i32* %_27, i32 2
    store i32 12, i32* %_31
    br label %label11

label10:
    call void @throw_oob()
    br label %label11

label11:
    %_32 = getelementptr i8, i8* %this, i32 8
    %_33 = bitcast i8* %_32 to i32**
    %_34 = load i32*, i32** %_33
    %_35 = getelementptr i32, i32* %_34, i32 -1
    %_36 = load i32, i32* %_35
    %_37 = icmp ult i32 3, %_36
    br i1 %_37, label %label12, label %label13

label12:
    %_38 = getelementptr i32, i32* %_34, i32 3
    store i32 18, i32* %_38
    br label %label14

label13:
    call void @throw_oob()
    br label %label14

label14:
    %_39 = getelementptr i8, i8* %this, i32 8
    %_40 = bitcast i8* %_39 to i32**
    %_41 = load i32*, i32** %_40
    %_42 = getelementptr i32, i32* %_41, i32 -1
    %_43 = load i32, i32* %_42
    %_44 = icmp ult i32 4, %_43
    br i1 %_44, label %label15, label %label16

label15:
    %_45 = getelementptr i32, i32* %_41, i32 4
    store i32 2, i32* %_45
    br label %label17

label16:
    call void @throw_oob()
    br label %label17

label17:
    %_46 = getelementptr i8, i8* %this, i32 8
    %_47 = bitcast i8* %_46 to i32**
    %_48 = load i32*, i32** %_47
    %_49 = getelementptr i32, i32* %_48, i32 -1
    %_50 = load i32, i32* %_49
    %_51 = icmp ult i32 5, %_50
    br i1 %_51, label %label18, label %label19

label18:
    %_52 = getelementptr i32, i32* %_48, i32 5
    store i32 11, i32* %_52
    br label %label20

label19:
    call void @throw_oob()
    br label %label20

label20:
    %_53 = getelementptr i8, i8* %this, i32 8
    %_54 = bitcast i8* %_53 to i32**
    %_55 = load i32*, i32** %_54
    %_56 = getelementptr i32, i32* %_55, i32 -1
    %_57 = load i32, i32* %_56
    %_58 = icmp ult i32 6, %_57
    br i1 %_58, label %label21, label %label22

label21:
    %_59 = getelementptr i32, i32* %_55, i32 6
    store i32 6, i32* %_59
    br label %label23

label22:
    call void @throw_oob()
    br label %label23

label23:
    %_60 = getelementptr i8, i8* %this, i32 8
    %_61 = bitcast i8* %_60 to i32**
    %_62 = load i32*, i32** %_61
    %_63 = getelementptr i32, i32* %_62, i32 -1
    %_64 = load i32, i32* %_63
    %_65 = icmp ult i32 7, %_64
    br i1 %_65, label %label24, label %label25

label24:
    %_66 = getelementptr i32, i32* %_62, i32 7
    store i32 9, i32* %_66
    br label %label26

label25:
    call void @throw_oob()
    br label %label26

label26:
    %_67 = getelementptr i8, i8* %this, i32 8
    %_68 = bitcast i8* %_67 to i32**
    %_69 = load i32*, i32** %_68
    %_70 = getelementptr i32, i32* %_69, i32 -1
    %_71 = load i32, i32* %_70
    %_72 = icmp ult i32 8, %_71
    br i1 %_72, label %label27, label %label28

label27:
    %_73 = getelementptr i32, i32* %_69, i32 8
    store i32 19, i32* %_73
    br label %label29

label28:
    call void @throw_oob()
    br label %label29

label29:
    %_74 = getelementptr i8, i8* %this, i32 8
    %_75 = bitcast i8* %_74 to i32**
    %_76 = load i32*, i32** %_75
    %_77 = getelementptr i32, i32* %_76, i32 -1
    %_78 = load i32, i32* %_77
    %_79 = icmp ult i32 9, %_78
    br i1 %_79, label %label30, label %label31

label30:
    %_80 = getelementptr i32, i32* %_76, i32 9
    store i32 5, i32* %_80
    br label %label32

label31:
    call void @throw_oob()
    br label %label32

label32:

    ret i32 0
}
