@.LetTheFunBegin_vtable = global [0 x i8*] []
@.A_vtable = global [3 x i8*] [i8* bitcast (i32* (i8*)* @A.foo to i8*), i8* bitcast (i32 (i8*,i32)* @A.bar to i8*), i8* bitcast (i32* (i8*)* @A.another to i8*)]
@.B_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*)* @B.fill_arr to i8*), i8* bitcast (i32 (i8*)* @B.get_a to i8*), i8* bitcast (i8 (i8*)* @B.get_c to i8*)]


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
    %_0 = call i8* @calloc(i32 0, i32 21)
    store i8* %_0, i8** %b
    %c = alloca i32*
    %_1 = call i8* @calloc(i32 0, i32 4)
    %_2 = bitcast i8* %_1 to i32*
    store i32* %_2, i32** %c
    %d = alloca i32
    store i32 0, i32* %d
    %a = alloca i8*
    %_3 = call i8* @calloc(i32 0, i32 8)
    store i8* %_3, i8** %a
    %_4 = call i8* @calloc(i32 1, i32 8)
    %_5 = bitcast i8* %_4 to i8**
    %_6 = getelementptr [3 x i8*], [3 x i8*]* @.A_vtable, i32 0, i32 0
    %_7 = bitcast i8** %_6 to i8*
    store i8* %_7, i8** %_5
    store i8* %_4, i8** %a
    %_8 = icmp slt i32 2, 0
    br i1 %_8, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_9 = add i32 2, 1
    %_10 = call i8* @calloc(i32 %_9, i32 4)
    %_11 = bitcast i8* %_10 to i32*
    store i32 2, i32* %_11
    %_12 = getelementptr i32, i32* %_11, i32 1
    br label %label2

label2:
    store i32* %_12, i32** %c
    %_13 = load i32*, i32** %c
    %_14 = getelementptr i32, i32* %_13, i32 -1
    %_15 = load i32, i32* %_14
    %_16 = icmp ult i32 1, %_15
    br i1 %_16, label %label3, label %label4

label3:
    %_17 = getelementptr i32, i32* %_13, i32 1
    store i32 0, i32* %_17
    br label %label5

label4:
    call void @throw_oob()
    br label %label5

label5:
    %_18 = trunc i8 0 to i1
    br i1 %_18, label %label6, label %label7

label6:
    call void (i32) @print_int(i32 1)
    br label %label8

label7:
    %_19 = trunc i8 0 to i1
    br i1 %_19, label %label9, label %label10

label9:
    call void (i32) @print_int(i32 10)
    br label %label11

label10:
    call void (i32) @print_int(i32 20)
    br label %label11

label11:
    br label %label8

label8:
    %_20 = load i8*, i8** %a
    %_21 = bitcast i8* %_20 to i8**
    %_22 = load i8*, i8** %_21
    %_23 = getelementptr i8, i8* %_22, i32 8
    %_24 = bitcast i8* %_23 to i8**
    %_25 = load i8*, i8** %_24
    %_26 = bitcast i8* %_25 to i32 (i8*, i32)*
    %_28 = load i32*, i32** %c
    %_29 = getelementptr i32, i32* %_28, i32 -1
    %_30 = load i32, i32* %_29
    %_31 = icmp ult i32 1, %_30
    br i1 %_31, label %label12, label %label13

label12:
    %_32 = getelementptr i32, i32* %_28, i32 1
    %_33 = load i32, i32* %_32
    br label %label14

label13:
    call void @throw_oob()
    br label %label14

label14:
    %_27 = call i32 %_26(i8* %_20, i32 %_33)
    store i32 %_27, i32* %d
    %_34 = load i32, i32* %d
    call void (i32) @print_int(i32 %_34)
    %_35 = load i8*, i8** %a
    %_36 = bitcast i8* %_35 to i8**
    %_37 = load i8*, i8** %_36
    %_38 = getelementptr i8, i8* %_37, i32 8
    %_39 = bitcast i8* %_38 to i8**
    %_40 = load i8*, i8** %_39
    %_41 = bitcast i8* %_40 to i32 (i8*, i32)*
    %_43 = load i8*, i8** %a
    %_44 = bitcast i8* %_43 to i8**
    %_45 = load i8*, i8** %_44
    %_46 = getelementptr i8, i8* %_45, i32 0
    %_47 = bitcast i8* %_46 to i8**
    %_48 = load i8*, i8** %_47
    %_49 = bitcast i8* %_48 to i32* (i8*)*
    %_50 = call i32* %_49(i8* %_43)
    %_51 = getelementptr i32, i32* %_50, i32 -1
    %_52 = load i32, i32* %_51
    %_53 = icmp ult i32 2, %_52
    br i1 %_53, label %label15, label %label16

label15:
    %_54 = getelementptr i32, i32* %_50, i32 2
    %_55 = load i32, i32* %_54
    br label %label17

label16:
    call void @throw_oob()
    br label %label17

label17:
    %_42 = call i32 %_41(i8* %_35, i32 %_55)
    store i32 %_42, i32* %d
    %_56 = load i32, i32* %d
    call void (i32) @print_int(i32 %_56)
    %_57 = call i8* @calloc(i32 1, i32 21)
    %_58 = bitcast i8* %_57 to i8**
    %_59 = getelementptr [3 x i8*], [3 x i8*]* @.B_vtable, i32 0, i32 0
    %_60 = bitcast i8** %_59 to i8*
    store i8* %_60, i8** %_58
    store i8* %_57, i8** %b
    %_61 = load i8*, i8** %b
    %_62 = bitcast i8* %_61 to i8**
    %_63 = load i8*, i8** %_62
    %_64 = getelementptr i8, i8* %_63, i32 0
    %_65 = bitcast i8* %_64 to i8**
    %_66 = load i8*, i8** %_65
    %_67 = bitcast i8* %_66 to i32 (i8*)*
    %_68 = call i32 %_67(i8* %_61)
    call void (i32) @print_int(i32 %_68)
    %_69 = load i8*, i8** %b
    %_70 = bitcast i8* %_69 to i8**
    %_71 = load i8*, i8** %_70
    %_72 = getelementptr i8, i8* %_71, i32 8
    %_73 = bitcast i8* %_72 to i8**
    %_74 = load i8*, i8** %_73
    %_75 = bitcast i8* %_74 to i32 (i8*)*
    %_76 = call i32 %_75(i8* %_69)
    call void (i32) @print_int(i32 %_76)
    %_77 = load i8*, i8** %b
    %_78 = bitcast i8* %_77 to i8**
    %_79 = load i8*, i8** %_78
    %_80 = getelementptr i8, i8* %_79, i32 16
    %_81 = bitcast i8* %_80 to i8**
    %_82 = load i8*, i8** %_81
    %_83 = bitcast i8* %_82 to i8 (i8*)*
    %_84 = call i8 %_83(i8* %_77)
    %_85 = trunc i8 %_84 to i1
    br i1 %_85, label %label18, label %label19

label18:
    store i32 1, i32* %d
    br label %label20

label19:
    store i32 0, i32* %d
    br label %label20

label20:
    %_86 = load i32, i32* %d
    call void (i32) @print_int(i32 %_86)
    %_87 = load i32*, i32** %c
    %_88 = getelementptr i32, i32* %_87, i32 -1
    %_89 = load i32, i32* %_88
    %_90 = icmp ult i32 2, %_89
    br i1 %_90, label %label21, label %label22

label21:
    %_91 = getelementptr i32, i32* %_87, i32 2
    %_92 = load i32*, i32** %c
    %_93 = getelementptr i32, i32* %_92, i32 -1
    %_94 = load i32, i32* %_93
    %_95 = icmp ult i32 1, %_94
    br i1 %_95, label %label24, label %label25

label24:
    %_96 = getelementptr i32, i32* %_92, i32 1
    %_97 = load i32, i32* %_96
    br label %label26

label25:
    call void @throw_oob()
    br label %label26

label26:
    store i32 %_97, i32* %_91
    br label %label23

label22:
    call void @throw_oob()
    br label %label23

label23:


    ret i32 0
}

define i32* @A.foo(i8* %this) {
    %b = alloca i32*
    %_0 = call i8* @calloc(i32 0, i32 4)
    %_1 = bitcast i8* %_0 to i32*
    store i32* %_1, i32** %b
    %_2 = icmp slt i32 200, 0
    br i1 %_2, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_3 = add i32 200, 1
    %_4 = call i8* @calloc(i32 %_3, i32 4)
    %_5 = bitcast i8* %_4 to i32*
    store i32 200, i32* %_5
    %_6 = getelementptr i32, i32* %_5, i32 1
    br label %label2

label2:
    store i32* %_6, i32** %b
    %_7 = load i32*, i32** %b
    %_8 = getelementptr i32, i32* %_7, i32 -1
    %_9 = load i32, i32* %_8
    %_10 = icmp ult i32 2, %_9
    br i1 %_10, label %label3, label %label4

label3:
    %_11 = getelementptr i32, i32* %_7, i32 2
    store i32 1, i32* %_11
    br label %label5

label4:
    call void @throw_oob()
    br label %label5

label5:
    %_12 = load i32*, i32** %b

    ret i32* %_12
}

define i32 @A.bar(i8* %this, i32 %.a) {
    %a = alloca i32
    store i32 %.a, i32* %a
    %res = alloca i32
    store i32 0, i32* %res
    %_0 = trunc i8 1 to i1
    br i1 %_0, label %label0, label %label1

label0:
    store i32 1, i32* %res
    br label %label2

label1:
    store i32 2, i32* %res
    br label %label2

label2:
    %_1 = load i32, i32* %res

    ret i32 %_1
}

define i32* @A.another(i8* %this) {
    %_0 = bitcast i8* %this to i8**
    %_1 = load i8*, i8** %_0
    %_2 = getelementptr i8, i8* %_1, i32 0
    %_3 = bitcast i8* %_2 to i8**
    %_4 = load i8*, i8** %_3
    %_5 = bitcast i8* %_4 to i32* (i8*)*
    %_6 = call i32* %_5(i8* %this)

    ret i32* %_6
}

define i32 @B.fill_arr(i8* %this) {
    %arr = alloca i32*
    %_0 = call i8* @calloc(i32 0, i32 4)
    %_1 = bitcast i8* %_0 to i32*
    store i32* %_1, i32** %arr
    %i = alloca i32
    store i32 0, i32* %i
    %len = alloca i32
    store i32 0, i32* %len
    store i32 100, i32* %len
    %_2 = load i32, i32* %len
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
    store i32* %_7, i32** %arr
    store i32 0, i32* %i
    br label %label4

label4:
    %_8 = load i32, i32* %i
    %_9 = load i32, i32* %len
    %_10 = icmp slt i32 %_8, %_9
    %_11 = zext i1 %_10 to i8
    %_12 = trunc i8 %_11 to i1
    br i1 %_12, label %label3, label %label5

label3:
    %_13 = load i32*, i32** %arr
    %_14 = load i32, i32* %i
    %_15 = getelementptr i32, i32* %_13, i32 -1
    %_16 = load i32, i32* %_15
    %_17 = icmp ult i32 %_14, %_16
    br i1 %_17, label %label6, label %label7

label6:
    %_18 = getelementptr i32, i32* %_13, i32 %_14
    store i32 1, i32* %_18
    br label %label8

label7:
    call void @throw_oob()
    br label %label8

label8:
    %_19 = load i32, i32* %i
    %_20 = add i32 %_19, 1
    store i32 %_20, i32* %i
    br label %label4

label5:
    %_21 = getelementptr i8, i8* %this, i32 12
    %_22 = bitcast i8* %_21 to i32**
    %_23 = load i32*, i32** %arr
    store i32* %_23, i32** %_22

    ret i32 0
}

define i32 @B.get_a(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %_1

    ret i32 %_2
}

define i8 @B.get_c(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 20
    %_1 = bitcast i8* %_0 to i8*
    %_2 = load i8, i8* %_1

    ret i8 %_2
}
