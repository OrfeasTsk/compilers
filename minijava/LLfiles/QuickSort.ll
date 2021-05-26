@.QuickSort_vtable = global [0 x i8*] []
@.QS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*,i32)* @QS.Start to i8*), i8* bitcast (i32 (i8*,i32,i32)* @QS.Sort to i8*), i8* bitcast (i32 (i8*)* @QS.Print to i8*), i8* bitcast (i32 (i8*,i32)* @QS.Init to i8*)]


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
    %_2 = getelementptr [4 x i8*], [4 x i8*]* @.QS_vtable, i32 0, i32 0
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

define i32 @QS.Start(i8* %this, i32 %.sz) {
    %sz = alloca i32
    store i32 %.sz, i32* %sz
    %aux01 = alloca i32
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
    call void (i32) @print_int(i32 9999)    %_15 = getelementptr i8, i8* %this, i32 16
    %_16 = bitcast i8* %_15 to i32*
    %_17 = load i32, i32* %_16
    %_18 = sub i32 %_17, 1
    store i32 %_18, i32* %aux01
    %_19 = bitcast i8* %this to i8**
    %_20 = load i8*, i8** %_19
    %_21 = getelementptr i8, i8* %_20, i32 8
    %_22 = bitcast i8* %_21 to i8**
    %_23 = load i8*, i8** %_22
    %_24 = bitcast i8* %_23 to i32 (i8*, i32, i32)*
    %_26 = load i32, i32* %aux01
    %_25 = call i32 %_24(i8* %this, i32 0, i32 %_26)
    store i32 %_25, i32* %aux01
    %_27 = bitcast i8* %this to i8**
    %_28 = load i8*, i8** %_27
    %_29 = getelementptr i8, i8* %_28, i32 16
    %_30 = bitcast i8* %_29 to i8**
    %_31 = load i8*, i8** %_30
    %_32 = bitcast i8* %_31 to i32 (i8*)*
    %_33 = call i32 %_32(i8* %this)
    store i32 %_33, i32* %aux01

    ret i32 0
}

define i32 @QS.Sort(i8* %this, i32 %.left, i32 %.right) {
    %left = alloca i32
    store i32 %.left, i32* %left
    %right = alloca i32
    store i32 %.right, i32* %right
    %v = alloca i32
    %i = alloca i32
    %j = alloca i32
    %nt = alloca i32
    %t = alloca i32
    %cont01 = alloca i1
    %cont02 = alloca i1
    %aux03 = alloca i32
    store i32 0, i32* %t
    %_0 = load i32, i32* %left
    %_1 = load i32, i32* %right
    %_2 = icmp slt i32 %_0, %_1
    br i1 %_2, label %label0, label %label1

label0:
    %_3 = getelementptr i8, i8* %this, i32 8
    %_4 = bitcast i8* %_3 to i32**
    %_5 = load i32*, i32** %_4
    %_6 = load i32, i32* %right
    %_7 = getelementptr i32, i32* %_5, i32 -1
    %_8 = load i32, i32* %_7
    %_9 = icmp ult i32 %_6, %_8
    br i1 %_9, label %label3, label %label4

label3:
    %_10 = getelementptr i32, i32* %_5, i32 %_6
    %_11 = load i32, i32* %_10
    br label %label5

label4:
    call void @throw_oob()
    br label %label5

label5:
    store i32 %_11, i32* %v
    %_12 = load i32, i32* %left
    %_13 = sub i32 %_12, 1
    store i32 %_13, i32* %i
    %_14 = load i32, i32* %right
    store i32 %_14, i32* %j
    store i1 1, i1* %cont01
    br label %label7

label7:
    %_15 = load i1, i1* %cont01
    br i1 %_15, label %label6, label %label8

label6:
    store i1 1, i1* %cont02
    br label %label10

label10:
    %_16 = load i1, i1* %cont02
    br i1 %_16, label %label9, label %label11

label9:
    %_17 = load i32, i32* %i
    %_18 = add i32 %_17, 1
    store i32 %_18, i32* %i
    %_19 = getelementptr i8, i8* %this, i32 8
    %_20 = bitcast i8* %_19 to i32**
    %_21 = load i32*, i32** %_20
    %_22 = load i32, i32* %i
    %_23 = getelementptr i32, i32* %_21, i32 -1
    %_24 = load i32, i32* %_23
    %_25 = icmp ult i32 %_22, %_24
    br i1 %_25, label %label12, label %label13

label12:
    %_26 = getelementptr i32, i32* %_21, i32 %_22
    %_27 = load i32, i32* %_26
    br label %label14

label13:
    call void @throw_oob()
    br label %label14

label14:
    store i32 %_27, i32* %aux03
    %_28 = load i32, i32* %aux03
    %_29 = load i32, i32* %v
    %_30 = icmp slt i32 %_28, %_29
    %_31 = xor i1 %_30, 1
    br i1 %_31, label %label15, label %label16

label15:
    store i1 0, i1* %cont02
    br label %label17

label16:
    store i1 1, i1* %cont02
    br label %label17

label17:
    br label %label10

label11:
    store i1 1, i1* %cont02
    br label %label19

label19:
    %_32 = load i1, i1* %cont02
    br i1 %_32, label %label18, label %label20

label18:
    %_33 = load i32, i32* %j
    %_34 = sub i32 %_33, 1
    store i32 %_34, i32* %j
    %_35 = getelementptr i8, i8* %this, i32 8
    %_36 = bitcast i8* %_35 to i32**
    %_37 = load i32*, i32** %_36
    %_38 = load i32, i32* %j
    %_39 = getelementptr i32, i32* %_37, i32 -1
    %_40 = load i32, i32* %_39
    %_41 = icmp ult i32 %_38, %_40
    br i1 %_41, label %label21, label %label22

label21:
    %_42 = getelementptr i32, i32* %_37, i32 %_38
    %_43 = load i32, i32* %_42
    br label %label23

label22:
    call void @throw_oob()
    br label %label23

label23:
    store i32 %_43, i32* %aux03
    %_44 = load i32, i32* %v
    %_45 = load i32, i32* %aux03
    %_46 = icmp slt i32 %_44, %_45
    %_47 = xor i1 %_46, 1
    br i1 %_47, label %label24, label %label25

label24:
    store i1 0, i1* %cont02
    br label %label26

label25:
    store i1 1, i1* %cont02
    br label %label26

label26:
    br label %label19

label20:
    %_48 = getelementptr i8, i8* %this, i32 8
    %_49 = bitcast i8* %_48 to i32**
    %_50 = load i32*, i32** %_49
    %_51 = load i32, i32* %i
    %_52 = getelementptr i32, i32* %_50, i32 -1
    %_53 = load i32, i32* %_52
    %_54 = icmp ult i32 %_51, %_53
    br i1 %_54, label %label27, label %label28

label27:
    %_55 = getelementptr i32, i32* %_50, i32 %_51
    %_56 = load i32, i32* %_55
    br label %label29

label28:
    call void @throw_oob()
    br label %label29

label29:
    store i32 %_56, i32* %t
    %_57 = getelementptr i8, i8* %this, i32 8
    %_58 = bitcast i8* %_57 to i32**
    %_59 = load i32*, i32** %_58
    %_60 = load i32, i32* %i
    %_61 = getelementptr i32, i32* %_59, i32 -1
    %_62 = load i32, i32* %_61
    %_63 = icmp ult i32 %_60, %_62
    br i1 %_63, label %label30, label %label31

label30:
    %_64 = getelementptr i32, i32* %_59, i32 %_60
    %_65 = getelementptr i8, i8* %this, i32 8
    %_66 = bitcast i8* %_65 to i32**
    %_67 = load i32*, i32** %_66
    %_68 = load i32, i32* %j
    %_69 = getelementptr i32, i32* %_67, i32 -1
    %_70 = load i32, i32* %_69
    %_71 = icmp ult i32 %_68, %_70
    br i1 %_71, label %label33, label %label34

label33:
    %_72 = getelementptr i32, i32* %_67, i32 %_68
    %_73 = load i32, i32* %_72
    br label %label35

label34:
    call void @throw_oob()
    br label %label35

label35:
    store i32 %_73, i32* %_64
    br label %label32

label31:
    call void @throw_oob()
    br label %label32

label32:
    %_74 = getelementptr i8, i8* %this, i32 8
    %_75 = bitcast i8* %_74 to i32**
    %_76 = load i32*, i32** %_75
    %_77 = load i32, i32* %j
    %_78 = getelementptr i32, i32* %_76, i32 -1
    %_79 = load i32, i32* %_78
    %_80 = icmp ult i32 %_77, %_79
    br i1 %_80, label %label36, label %label37

label36:
    %_81 = getelementptr i32, i32* %_76, i32 %_77
    %_82 = load i32, i32* %t
    store i32 %_82, i32* %_81
    br label %label38

label37:
    call void @throw_oob()
    br label %label38

label38:
    %_83 = load i32, i32* %j
    %_84 = load i32, i32* %i
    %_85 = add i32 %_84, 1
    %_86 = icmp slt i32 %_83, %_85
    br i1 %_86, label %label39, label %label40

label39:
    store i1 0, i1* %cont01
    br label %label41

label40:
    store i1 1, i1* %cont01
    br label %label41

label41:
    br label %label7

label8:
    %_87 = getelementptr i8, i8* %this, i32 8
    %_88 = bitcast i8* %_87 to i32**
    %_89 = load i32*, i32** %_88
    %_90 = load i32, i32* %j
    %_91 = getelementptr i32, i32* %_89, i32 -1
    %_92 = load i32, i32* %_91
    %_93 = icmp ult i32 %_90, %_92
    br i1 %_93, label %label42, label %label43

label42:
    %_94 = getelementptr i32, i32* %_89, i32 %_90
    %_95 = getelementptr i8, i8* %this, i32 8
    %_96 = bitcast i8* %_95 to i32**
    %_97 = load i32*, i32** %_96
    %_98 = load i32, i32* %i
    %_99 = getelementptr i32, i32* %_97, i32 -1
    %_100 = load i32, i32* %_99
    %_101 = icmp ult i32 %_98, %_100
    br i1 %_101, label %label45, label %label46

label45:
    %_102 = getelementptr i32, i32* %_97, i32 %_98
    %_103 = load i32, i32* %_102
    br label %label47

label46:
    call void @throw_oob()
    br label %label47

label47:
    store i32 %_103, i32* %_94
    br label %label44

label43:
    call void @throw_oob()
    br label %label44

label44:
    %_104 = getelementptr i8, i8* %this, i32 8
    %_105 = bitcast i8* %_104 to i32**
    %_106 = load i32*, i32** %_105
    %_107 = load i32, i32* %i
    %_108 = getelementptr i32, i32* %_106, i32 -1
    %_109 = load i32, i32* %_108
    %_110 = icmp ult i32 %_107, %_109
    br i1 %_110, label %label48, label %label49

label48:
    %_111 = getelementptr i32, i32* %_106, i32 %_107
    %_112 = getelementptr i8, i8* %this, i32 8
    %_113 = bitcast i8* %_112 to i32**
    %_114 = load i32*, i32** %_113
    %_115 = load i32, i32* %right
    %_116 = getelementptr i32, i32* %_114, i32 -1
    %_117 = load i32, i32* %_116
    %_118 = icmp ult i32 %_115, %_117
    br i1 %_118, label %label51, label %label52

label51:
    %_119 = getelementptr i32, i32* %_114, i32 %_115
    %_120 = load i32, i32* %_119
    br label %label53

label52:
    call void @throw_oob()
    br label %label53

label53:
    store i32 %_120, i32* %_111
    br label %label50

label49:
    call void @throw_oob()
    br label %label50

label50:
    %_121 = getelementptr i8, i8* %this, i32 8
    %_122 = bitcast i8* %_121 to i32**
    %_123 = load i32*, i32** %_122
    %_124 = load i32, i32* %right
    %_125 = getelementptr i32, i32* %_123, i32 -1
    %_126 = load i32, i32* %_125
    %_127 = icmp ult i32 %_124, %_126
    br i1 %_127, label %label54, label %label55

label54:
    %_128 = getelementptr i32, i32* %_123, i32 %_124
    %_129 = load i32, i32* %t
    store i32 %_129, i32* %_128
    br label %label56

label55:
    call void @throw_oob()
    br label %label56

label56:
    %_130 = bitcast i8* %this to i8**
    %_131 = load i8*, i8** %_130
    %_132 = getelementptr i8, i8* %_131, i32 8
    %_133 = bitcast i8* %_132 to i8**
    %_134 = load i8*, i8** %_133
    %_135 = bitcast i8* %_134 to i32 (i8*, i32, i32)*
    %_137 = load i32, i32* %left
    %_138 = load i32, i32* %i
    %_139 = sub i32 %_138, 1
    %_136 = call i32 %_135(i8* %this, i32 %_137, i32 %_139)
    store i32 %_136, i32* %nt
    %_140 = bitcast i8* %this to i8**
    %_141 = load i8*, i8** %_140
    %_142 = getelementptr i8, i8* %_141, i32 8
    %_143 = bitcast i8* %_142 to i8**
    %_144 = load i8*, i8** %_143
    %_145 = bitcast i8* %_144 to i32 (i8*, i32, i32)*
    %_147 = load i32, i32* %i
    %_148 = add i32 %_147, 1
    %_149 = load i32, i32* %right
    %_146 = call i32 %_145(i8* %this, i32 %_148, i32 %_149)
    store i32 %_146, i32* %nt
    br label %label2

label1:
    store i32 0, i32* %nt
    br label %label2

label2:

    ret i32 0
}

define i32 @QS.Print(i8* %this) {
    %j = alloca i32
    store i32 0, i32* %j
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

define i32 @QS.Init(i8* %this, i32 %.sz) {
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
    %_8 = call i8* @calloc(i32 4, i32 %_7)
    %_9 = bitcast i8* %_8 to i32*
    store i32 %_7, i32* %_9
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
