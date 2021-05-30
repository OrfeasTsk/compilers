@.Main_vtable = global [0 x i8*] []
@.A_vtable = global [3 x i8*] [i8* bitcast (i32* (i8*)* @A.foo to i8*), i8* bitcast (i32 (i8*,i32)* @A.bar to i8*), i8* bitcast (i32* (i8*)* @A.another to i8*)]


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
    %c = alloca i32*
    %_0 = call i8* @calloc(i32 0, i32 4)
    %_1 = bitcast i8* %_0 to i32*
    store i32* %_1, i32** %c
    %d = alloca i32
    store i32 0, i32* %d
    %a = alloca i8*
    %_2 = call i8* @calloc(i32 0, i32 8)
    store i8* %_2, i8** %a
    %_3 = call i8* @calloc(i32 1, i32 8)
    %_4 = bitcast i8* %_3 to i8**
    %_5 = getelementptr [3 x i8*], [3 x i8*]* @.A_vtable, i32 0, i32 0
    %_6 = bitcast i8** %_5 to i8*
    store i8* %_6, i8** %_4
    store i8* %_3, i8** %a
    %_7 = icmp slt i32 2, 0
    br i1 %_7, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_8 = add i32 2, 1
    %_9 = call i8* @calloc(i32 %_8, i32 4)
    %_10 = bitcast i8* %_9 to i32*
    store i32 2, i32* %_10
    %_11 = getelementptr i32, i32* %_10, i32 1
    br label %label2

label2:
    store i32* %_11, i32** %c
    %_12 = load i32*, i32** %c
    %_13 = getelementptr i32, i32* %_12, i32 -1
    %_14 = load i32, i32* %_13
    %_15 = icmp ult i32 1, %_14
    br i1 %_15, label %label3, label %label4

label3:
    %_16 = getelementptr i32, i32* %_12, i32 1
    store i32 1, i32* %_16
    br label %label5

label4:
    call void @throw_oob()
    br label %label5

label5:
    %_17 = load i32*, i32** %c
    %_18 = getelementptr i32, i32* %_17, i32 -1
    %_19 = load i32, i32* %_18
    %_20 = icmp ult i32 1, %_19
    br i1 %_20, label %label9, label %label10

label9:
    %_21 = getelementptr i32, i32* %_17, i32 1
    %_22 = load i32, i32* %_21
    br label %label11

label10:
    call void @throw_oob()
    br label %label11

label11:
    %_23 = icmp slt i32 %_22, 2
    %_24 = zext i1 %_23 to i8
    %_25 = trunc i8 %_24 to i1
    br i1 %_25, label %label6, label %label7

label6:
    call void (i32) @print_int(i32 1)
    br label %label8

label7:
    %_26 = load i8*, i8** %a
    %_27 = bitcast i8* %_26 to i8**
    %_28 = load i8*, i8** %_27
    %_29 = getelementptr i8, i8* %_28, i32 0
    %_30 = bitcast i8* %_29 to i8**
    %_31 = load i8*, i8** %_30
    %_32 = bitcast i8* %_31 to i32* (i8*)*
    %_33 = call i32* %_32(i8* %_26)
    %_34 = getelementptr i32, i32* %_33, i32 -1
    %_35 = load i32, i32* %_34
    %_36 = icmp ult i32 2, %_35
    br i1 %_36, label %label15, label %label16

label15:
    %_37 = getelementptr i32, i32* %_33, i32 2
    %_38 = load i32, i32* %_37
    br label %label17

label16:
    call void @throw_oob()
    br label %label17

label17:
    %_39 = icmp slt i32 %_38, 0
    %_40 = zext i1 %_39 to i8
    %_41 = trunc i8 %_40 to i1
    br i1 %_41, label %label12, label %label13

label12:
    call void (i32) @print_int(i32 10)
    br label %label14

label13:
    call void (i32) @print_int(i32 20)
    br label %label14

label14:
    br label %label8

label8:
    %_42 = load i32*, i32** %c
    %_43 = getelementptr i32, i32* %_42, i32 -1
    %_44 = load i32, i32* %_43
    %_45 = icmp ult i32 1, %_44
    br i1 %_45, label %label18, label %label19

label18:
    %_46 = getelementptr i32, i32* %_42, i32 1
    %_47 = load i32*, i32** %c
    %_48 = getelementptr i32, i32* %_47, i32 -1
    %_49 = load i32, i32* %_48
    %_50 = icmp ult i32 2, %_49
    br i1 %_50, label %label21, label %label22

label21:
    %_51 = getelementptr i32, i32* %_47, i32 2
    %_52 = load i32, i32* %_51
    br label %label23

label22:
    call void @throw_oob()
    br label %label23

label23:
    store i32 %_52, i32* %_46
    br label %label20

label19:
    call void @throw_oob()
    br label %label20

label20:
    %_53 = load i8*, i8** %a
    %_54 = bitcast i8* %_53 to i8**
    %_55 = load i8*, i8** %_54
    %_56 = getelementptr i8, i8* %_55, i32 8
    %_57 = bitcast i8* %_56 to i8**
    %_58 = load i8*, i8** %_57
    %_59 = bitcast i8* %_58 to i32 (i8*, i32)*
    %_61 = load i32*, i32** %c
    %_62 = getelementptr i32, i32* %_61, i32 -1
    %_63 = load i32, i32* %_62
    %_64 = icmp ult i32 1, %_63
    br i1 %_64, label %label24, label %label25

label24:
    %_65 = getelementptr i32, i32* %_61, i32 1
    %_66 = load i32, i32* %_65
    br label %label26

label25:
    call void @throw_oob()
    br label %label26

label26:
    %_60 = call i32 %_59(i8* %_53, i32 %_66)
    store i32 %_60, i32* %d
    %_67 = load i8*, i8** %a
    %_68 = bitcast i8* %_67 to i8**
    %_69 = load i8*, i8** %_68
    %_70 = getelementptr i8, i8* %_69, i32 8
    %_71 = bitcast i8* %_70 to i8**
    %_72 = load i8*, i8** %_71
    %_73 = bitcast i8* %_72 to i32 (i8*, i32)*
    %_75 = load i8*, i8** %a
    %_76 = bitcast i8* %_75 to i8**
    %_77 = load i8*, i8** %_76
    %_78 = getelementptr i8, i8* %_77, i32 0
    %_79 = bitcast i8* %_78 to i8**
    %_80 = load i8*, i8** %_79
    %_81 = bitcast i8* %_80 to i32* (i8*)*
    %_82 = call i32* %_81(i8* %_75)
    %_83 = getelementptr i32, i32* %_82, i32 -1
    %_84 = load i32, i32* %_83
    %_85 = icmp ult i32 2, %_84
    br i1 %_85, label %label27, label %label28

label27:
    %_86 = getelementptr i32, i32* %_82, i32 2
    %_87 = load i32, i32* %_86
    br label %label29

label28:
    call void @throw_oob()
    br label %label29

label29:
    %_74 = call i32 %_73(i8* %_67, i32 %_87)
    store i32 %_74, i32* %d


    ret i32 0
}

define i32* @A.foo(i8* %this) {
    %_0 = icmp slt i32 200, 0
    br i1 %_0, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_1 = add i32 200, 1
    %_2 = call i8* @calloc(i32 %_1, i32 4)
    %_3 = bitcast i8* %_2 to i32*
    store i32 200, i32* %_3
    %_4 = getelementptr i32, i32* %_3, i32 1
    br label %label2

label2:

    ret i32* %_4
}

define i32 @A.bar(i8* %this, i32 %.a) {
    %a = alloca i32
    store i32 %.a, i32* %a
    %res = alloca i32
    store i32 0, i32* %res
    %_0 = load i32, i32* %a
    %_1 = icmp slt i32 %_0, 2
    %_2 = zext i1 %_1 to i8
    %_3 = trunc i8 %_2 to i1
    br i1 %_3, label %label3, label %label4

label3:
    %_4 = load i32, i32* %a
    %_5 = icmp slt i32 0, %_4
    %_6 = zext i1 %_5 to i8
    br label %label5

label5:
    br label %label6

label4:
    br label %label6

label6:
    %_7 = phi i8 [%_6, %label5], [%_2, %label4]
    %_8 = trunc i8 %_7 to i1
    br i1 %_8, label %label0, label %label1

label0:
    store i32 1, i32* %res
    br label %label2

label1:
    store i32 2, i32* %res
    br label %label2

label2:
    %_9 = load i32, i32* %res

    ret i32 %_9
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
