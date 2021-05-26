@.TreeVisitor_vtable = global [0 x i8*] []
@.TV_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @TV.Start to i8*)]
@.Tree_vtable = global [21 x i8*] [i8* bitcast (i1 (i8*,i32)* @Tree.Init to i8*), i8* bitcast (i1 (i8*,i8*)* @Tree.SetRight to i8*), i8* bitcast (i1 (i8*,i8*)* @Tree.SetLeft to i8*), i8* bitcast (i8* (i8*)* @Tree.GetRight to i8*), i8* bitcast (i8* (i8*)* @Tree.GetLeft to i8*), i8* bitcast (i32 (i8*)* @Tree.GetKey to i8*), i8* bitcast (i1 (i8*,i32)* @Tree.SetKey to i8*), i8* bitcast (i1 (i8*)* @Tree.GetHas_Right to i8*), i8* bitcast (i1 (i8*)* @Tree.GetHas_Left to i8*), i8* bitcast (i1 (i8*,i1)* @Tree.SetHas_Left to i8*), i8* bitcast (i1 (i8*,i1)* @Tree.SetHas_Right to i8*), i8* bitcast (i1 (i8*,i32,i32)* @Tree.Compare to i8*), i8* bitcast (i1 (i8*,i32)* @Tree.Insert to i8*), i8* bitcast (i1 (i8*,i32)* @Tree.Delete to i8*), i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.Remove to i8*), i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.RemoveRight to i8*), i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.RemoveLeft to i8*), i8* bitcast (i32 (i8*,i32)* @Tree.Search to i8*), i8* bitcast (i1 (i8*)* @Tree.Print to i8*), i8* bitcast (i1 (i8*,i8*)* @Tree.RecPrint to i8*), i8* bitcast (i32 (i8*,i8*)* @Tree.accept to i8*)]
@.Visitor_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*,i8*)* @Visitor.visit to i8*)]
@.MyVisitor_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*,i8*)* @MyVisitor.visit to i8*)]


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
    %_0 = call i8* @calloc(i32 1, i32 8)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.TV_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1
    %_4 = bitcast i8* %_0 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = getelementptr i8, i8* %_5, i32 0
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %_7
    %_9 = bitcast i8* %_8 to i32 (i8*)*
    %_10 = call i32 %_9(i8* %_0)
    call void (i32) @print_int(i32 %_10)

    ret i32 0
}

define i32 @TV.Start(i8* %this) {
    %root = alloca i8*
    %ntb = alloca i1
    %nti = alloca i32
    %v = alloca i8*
    %_0 = call i8* @calloc(i32 1, i32 38)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [21 x i8*], [21 x i8*]* @.Tree_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1
    store i8* %_0, i8** %root
    %_4 = load i8*, i8** %root
    %_5 = bitcast i8* %_4 to i8**
    %_6 = load i8*, i8** %_5
    %_7 = getelementptr i8, i8* %_6, i32 0
    %_8 = bitcast i8* %_7 to i8**
    %_9 = load i8*, i8** %_8
    %_10 = bitcast i8* %_9 to i1 (i8*, i32)*
    %_11 = call i1 %_10(i8* %_4, i32 16)
    store i1 %_11, i1* %ntb
    %_12 = load i8*, i8** %root
    %_13 = bitcast i8* %_12 to i8**
    %_14 = load i8*, i8** %_13
    %_15 = getelementptr i8, i8* %_14, i32 144
    %_16 = bitcast i8* %_15 to i8**
    %_17 = load i8*, i8** %_16
    %_18 = bitcast i8* %_17 to i1 (i8*)*
    %_19 = call i1 %_18(i8* %_12)
    store i1 %_19, i1* %ntb
    call void (i32) @print_int(i32 100000000)    %_20 = load i8*, i8** %root
    %_21 = bitcast i8* %_20 to i8**
    %_22 = load i8*, i8** %_21
    %_23 = getelementptr i8, i8* %_22, i32 96
    %_24 = bitcast i8* %_23 to i8**
    %_25 = load i8*, i8** %_24
    %_26 = bitcast i8* %_25 to i1 (i8*, i32)*
    %_27 = call i1 %_26(i8* %_20, i32 8)
    store i1 %_27, i1* %ntb
    %_28 = load i8*, i8** %root
    %_29 = bitcast i8* %_28 to i8**
    %_30 = load i8*, i8** %_29
    %_31 = getelementptr i8, i8* %_30, i32 96
    %_32 = bitcast i8* %_31 to i8**
    %_33 = load i8*, i8** %_32
    %_34 = bitcast i8* %_33 to i1 (i8*, i32)*
    %_35 = call i1 %_34(i8* %_28, i32 24)
    store i1 %_35, i1* %ntb
    %_36 = load i8*, i8** %root
    %_37 = bitcast i8* %_36 to i8**
    %_38 = load i8*, i8** %_37
    %_39 = getelementptr i8, i8* %_38, i32 96
    %_40 = bitcast i8* %_39 to i8**
    %_41 = load i8*, i8** %_40
    %_42 = bitcast i8* %_41 to i1 (i8*, i32)*
    %_43 = call i1 %_42(i8* %_36, i32 4)
    store i1 %_43, i1* %ntb
    %_44 = load i8*, i8** %root
    %_45 = bitcast i8* %_44 to i8**
    %_46 = load i8*, i8** %_45
    %_47 = getelementptr i8, i8* %_46, i32 96
    %_48 = bitcast i8* %_47 to i8**
    %_49 = load i8*, i8** %_48
    %_50 = bitcast i8* %_49 to i1 (i8*, i32)*
    %_51 = call i1 %_50(i8* %_44, i32 12)
    store i1 %_51, i1* %ntb
    %_52 = load i8*, i8** %root
    %_53 = bitcast i8* %_52 to i8**
    %_54 = load i8*, i8** %_53
    %_55 = getelementptr i8, i8* %_54, i32 96
    %_56 = bitcast i8* %_55 to i8**
    %_57 = load i8*, i8** %_56
    %_58 = bitcast i8* %_57 to i1 (i8*, i32)*
    %_59 = call i1 %_58(i8* %_52, i32 20)
    store i1 %_59, i1* %ntb
    %_60 = load i8*, i8** %root
    %_61 = bitcast i8* %_60 to i8**
    %_62 = load i8*, i8** %_61
    %_63 = getelementptr i8, i8* %_62, i32 96
    %_64 = bitcast i8* %_63 to i8**
    %_65 = load i8*, i8** %_64
    %_66 = bitcast i8* %_65 to i1 (i8*, i32)*
    %_67 = call i1 %_66(i8* %_60, i32 28)
    store i1 %_67, i1* %ntb
    %_68 = load i8*, i8** %root
    %_69 = bitcast i8* %_68 to i8**
    %_70 = load i8*, i8** %_69
    %_71 = getelementptr i8, i8* %_70, i32 96
    %_72 = bitcast i8* %_71 to i8**
    %_73 = load i8*, i8** %_72
    %_74 = bitcast i8* %_73 to i1 (i8*, i32)*
    %_75 = call i1 %_74(i8* %_68, i32 14)
    store i1 %_75, i1* %ntb
    %_76 = load i8*, i8** %root
    %_77 = bitcast i8* %_76 to i8**
    %_78 = load i8*, i8** %_77
    %_79 = getelementptr i8, i8* %_78, i32 144
    %_80 = bitcast i8* %_79 to i8**
    %_81 = load i8*, i8** %_80
    %_82 = bitcast i8* %_81 to i1 (i8*)*
    %_83 = call i1 %_82(i8* %_76)
    store i1 %_83, i1* %ntb
    call void (i32) @print_int(i32 100000000)    %_84 = call i8* @calloc(i32 1, i32 24)
    %_85 = bitcast i8* %_84 to i8**
    %_86 = getelementptr [1 x i8*], [1 x i8*]* @.MyVisitor_vtable, i32 0, i32 0
    %_87 = bitcast i8** %_86 to i8*
    store i8* %_87, i8** %_85
    store i8* %_84, i8** %v
    call void (i32) @print_int(i32 50000000)    %_88 = load i8*, i8** %root
    %_89 = bitcast i8* %_88 to i8**
    %_90 = load i8*, i8** %_89
    %_91 = getelementptr i8, i8* %_90, i32 160
    %_92 = bitcast i8* %_91 to i8**
    %_93 = load i8*, i8** %_92
    %_94 = bitcast i8* %_93 to i32 (i8*, i8*)*
    %_96 = load i8*, i8** %v
    %_95 = call i32 %_94(i8* %_88, i8* %_96)
    store i32 %_95, i32* %nti
    call void (i32) @print_int(i32 100000000)    %_97 = load i8*, i8** %root
    %_98 = bitcast i8* %_97 to i8**
    %_99 = load i8*, i8** %_98
    %_100 = getelementptr i8, i8* %_99, i32 136
    %_101 = bitcast i8* %_100 to i8**
    %_102 = load i8*, i8** %_101
    %_103 = bitcast i8* %_102 to i32 (i8*, i32)*
    %_104 = call i32 %_103(i8* %_97, i32 24)
    call void (i32) @print_int(i32 %_104)    %_105 = load i8*, i8** %root
    %_106 = bitcast i8* %_105 to i8**
    %_107 = load i8*, i8** %_106
    %_108 = getelementptr i8, i8* %_107, i32 136
    %_109 = bitcast i8* %_108 to i8**
    %_110 = load i8*, i8** %_109
    %_111 = bitcast i8* %_110 to i32 (i8*, i32)*
    %_112 = call i32 %_111(i8* %_105, i32 12)
    call void (i32) @print_int(i32 %_112)    %_113 = load i8*, i8** %root
    %_114 = bitcast i8* %_113 to i8**
    %_115 = load i8*, i8** %_114
    %_116 = getelementptr i8, i8* %_115, i32 136
    %_117 = bitcast i8* %_116 to i8**
    %_118 = load i8*, i8** %_117
    %_119 = bitcast i8* %_118 to i32 (i8*, i32)*
    %_120 = call i32 %_119(i8* %_113, i32 16)
    call void (i32) @print_int(i32 %_120)    %_121 = load i8*, i8** %root
    %_122 = bitcast i8* %_121 to i8**
    %_123 = load i8*, i8** %_122
    %_124 = getelementptr i8, i8* %_123, i32 136
    %_125 = bitcast i8* %_124 to i8**
    %_126 = load i8*, i8** %_125
    %_127 = bitcast i8* %_126 to i32 (i8*, i32)*
    %_128 = call i32 %_127(i8* %_121, i32 50)
    call void (i32) @print_int(i32 %_128)    %_129 = load i8*, i8** %root
    %_130 = bitcast i8* %_129 to i8**
    %_131 = load i8*, i8** %_130
    %_132 = getelementptr i8, i8* %_131, i32 136
    %_133 = bitcast i8* %_132 to i8**
    %_134 = load i8*, i8** %_133
    %_135 = bitcast i8* %_134 to i32 (i8*, i32)*
    %_136 = call i32 %_135(i8* %_129, i32 12)
    call void (i32) @print_int(i32 %_136)    %_137 = load i8*, i8** %root
    %_138 = bitcast i8* %_137 to i8**
    %_139 = load i8*, i8** %_138
    %_140 = getelementptr i8, i8* %_139, i32 104
    %_141 = bitcast i8* %_140 to i8**
    %_142 = load i8*, i8** %_141
    %_143 = bitcast i8* %_142 to i1 (i8*, i32)*
    %_144 = call i1 %_143(i8* %_137, i32 12)
    store i1 %_144, i1* %ntb
    %_145 = load i8*, i8** %root
    %_146 = bitcast i8* %_145 to i8**
    %_147 = load i8*, i8** %_146
    %_148 = getelementptr i8, i8* %_147, i32 144
    %_149 = bitcast i8* %_148 to i8**
    %_150 = load i8*, i8** %_149
    %_151 = bitcast i8* %_150 to i1 (i8*)*
    %_152 = call i1 %_151(i8* %_145)
    store i1 %_152, i1* %ntb
    %_153 = load i8*, i8** %root
    %_154 = bitcast i8* %_153 to i8**
    %_155 = load i8*, i8** %_154
    %_156 = getelementptr i8, i8* %_155, i32 136
    %_157 = bitcast i8* %_156 to i8**
    %_158 = load i8*, i8** %_157
    %_159 = bitcast i8* %_158 to i32 (i8*, i32)*
    %_160 = call i32 %_159(i8* %_153, i32 12)
    call void (i32) @print_int(i32 %_160)
    ret i32 0
}

define i1 @Tree.Init(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key
    %_0 = getelementptr i8, i8* %this, i32 24
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %v_key
    store i32 %_2, i32* %_1
    %_3 = getelementptr i8, i8* %this, i32 28
    %_4 = bitcast i8* %_3 to i1*
    store i1 0, i1* %_4
    %_5 = getelementptr i8, i8* %this, i32 29
    %_6 = bitcast i8* %_5 to i1*
    store i1 0, i1* %_6

    ret i1 1
}

define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
    %rn = alloca i8*
    store i8* %.rn, i8** %rn
    %_0 = getelementptr i8, i8* %this, i32 16
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %rn
    store i8* %_2, i8** %_1

    ret i1 1
}

define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
    %ln = alloca i8*
    store i8* %.ln, i8** %ln
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %ln
    store i8* %_2, i8** %_1

    ret i1 1
}

define i8* @Tree.GetRight(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 16
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1

    ret i8* %_2
}

define i8* @Tree.GetLeft(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1

    ret i8* %_2
}

define i32 @Tree.GetKey(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 24
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %_1

    ret i32 %_2
}

define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key
    %_0 = getelementptr i8, i8* %this, i32 24
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %v_key
    store i32 %_2, i32* %_1

    ret i1 1
}

define i1 @Tree.GetHas_Right(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 29
    %_1 = bitcast i8* %_0 to i1*
    %_2 = load i1, i1* %_1

    ret i1 %_2
}

define i1 @Tree.GetHas_Left(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 28
    %_1 = bitcast i8* %_0 to i1*
    %_2 = load i1, i1* %_1

    ret i1 %_2
}

define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
    %val = alloca i1
    store i1 %.val, i1* %val
    %_0 = getelementptr i8, i8* %this, i32 28
    %_1 = bitcast i8* %_0 to i1*
    %_2 = load i1, i1* %val
    store i1 %_2, i1* %_1

    ret i1 1
}

define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
    %val = alloca i1
    store i1 %.val, i1* %val
    %_0 = getelementptr i8, i8* %this, i32 29
    %_1 = bitcast i8* %_0 to i1*
    %_2 = load i1, i1* %val
    store i1 %_2, i1* %_1

    ret i1 1
}

define i1 @Tree.Compare(i8* %this, i32 %.num1, i32 %.num2) {
    %num1 = alloca i32
    store i32 %.num1, i32* %num1
    %num2 = alloca i32
    store i32 %.num2, i32* %num2
    %ntb = alloca i1
    %nti = alloca i32
    store i1 0, i1* %ntb
    %_0 = load i32, i32* %num2
    %_1 = add i32 %_0, 1
    store i32 %_1, i32* %nti
    %_2 = load i32, i32* %num1
    %_3 = load i32, i32* %num2
    %_4 = icmp slt i32 %_2, %_3
    br i1 %_4, label %label0, label %label1

label0:
    store i1 0, i1* %ntb
    br label %label2

label1:
    %_5 = load i32, i32* %num1
    %_6 = load i32, i32* %nti
    %_7 = icmp slt i32 %_5, %_6
    %_8 = xor i1 %_7, 1
    br i1 %_8, label %label3, label %label4

label3:
    store i1 0, i1* %ntb
    br label %label5

label4:
    store i1 1, i1* %ntb
    br label %label5

label5:
    br label %label2

label2:
    %_9 = load i1, i1* %ntb

    ret i1 %_9
}

define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key
    %new_node = alloca i8*
    %ntb = alloca i1
    %current_node = alloca i8*
    %cont = alloca i1
    %key_aux = alloca i32
    %_0 = call i8* @calloc(i32 1, i32 38)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [21 x i8*], [21 x i8*]* @.Tree_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1
    store i8* %_0, i8** %new_node
    %_4 = load i8*, i8** %new_node
    %_5 = bitcast i8* %_4 to i8**
    %_6 = load i8*, i8** %_5
    %_7 = getelementptr i8, i8* %_6, i32 0
    %_8 = bitcast i8* %_7 to i8**
    %_9 = load i8*, i8** %_8
    %_10 = bitcast i8* %_9 to i1 (i8*, i32)*
    %_12 = load i32, i32* %v_key
    %_11 = call i1 %_10(i8* %_4, i32 %_12)
    store i1 %_11, i1* %ntb
    store i8* %this, i8** %current_node
    store i1 1, i1* %cont
    br label %label1

label1:
    %_13 = load i1, i1* %cont
    br i1 %_13, label %label0, label %label2

label0:
    %_14 = load i8*, i8** %current_node
    %_15 = bitcast i8* %_14 to i8**
    %_16 = load i8*, i8** %_15
    %_17 = getelementptr i8, i8* %_16, i32 40
    %_18 = bitcast i8* %_17 to i8**
    %_19 = load i8*, i8** %_18
    %_20 = bitcast i8* %_19 to i32 (i8*)*
    %_21 = call i32 %_20(i8* %_14)
    store i32 %_21, i32* %key_aux
    %_22 = load i32, i32* %v_key
    %_23 = load i32, i32* %key_aux
    %_24 = icmp slt i32 %_22, %_23
    br i1 %_24, label %label3, label %label4

label3:
    %_25 = load i8*, i8** %current_node
    %_26 = bitcast i8* %_25 to i8**
    %_27 = load i8*, i8** %_26
    %_28 = getelementptr i8, i8* %_27, i32 64
    %_29 = bitcast i8* %_28 to i8**
    %_30 = load i8*, i8** %_29
    %_31 = bitcast i8* %_30 to i1 (i8*)*
    %_32 = call i1 %_31(i8* %_25)
    br i1 %_32, label %label6, label %label7

label6:
    %_33 = load i8*, i8** %current_node
    %_34 = bitcast i8* %_33 to i8**
    %_35 = load i8*, i8** %_34
    %_36 = getelementptr i8, i8* %_35, i32 32
    %_37 = bitcast i8* %_36 to i8**
    %_38 = load i8*, i8** %_37
    %_39 = bitcast i8* %_38 to i8* (i8*)*
    %_40 = call i8* %_39(i8* %_33)
    store i8* %_40, i8** %current_node
    br label %label8

label7:
    store i1 0, i1* %cont
    %_41 = load i8*, i8** %current_node
    %_42 = bitcast i8* %_41 to i8**
    %_43 = load i8*, i8** %_42
    %_44 = getelementptr i8, i8* %_43, i32 72
    %_45 = bitcast i8* %_44 to i8**
    %_46 = load i8*, i8** %_45
    %_47 = bitcast i8* %_46 to i1 (i8*, i1)*
    %_48 = call i1 %_47(i8* %_41, i1 1)
    store i1 %_48, i1* %ntb
    %_49 = load i8*, i8** %current_node
    %_50 = bitcast i8* %_49 to i8**
    %_51 = load i8*, i8** %_50
    %_52 = getelementptr i8, i8* %_51, i32 16
    %_53 = bitcast i8* %_52 to i8**
    %_54 = load i8*, i8** %_53
    %_55 = bitcast i8* %_54 to i1 (i8*, i8*)*
    %_57 = load i8*, i8** %new_node
    %_56 = call i1 %_55(i8* %_49, i8* %_57)
    store i1 %_56, i1* %ntb
    br label %label8

label8:
    br label %label5

label4:
    %_58 = load i8*, i8** %current_node
    %_59 = bitcast i8* %_58 to i8**
    %_60 = load i8*, i8** %_59
    %_61 = getelementptr i8, i8* %_60, i32 56
    %_62 = bitcast i8* %_61 to i8**
    %_63 = load i8*, i8** %_62
    %_64 = bitcast i8* %_63 to i1 (i8*)*
    %_65 = call i1 %_64(i8* %_58)
    br i1 %_65, label %label9, label %label10

label9:
    %_66 = load i8*, i8** %current_node
    %_67 = bitcast i8* %_66 to i8**
    %_68 = load i8*, i8** %_67
    %_69 = getelementptr i8, i8* %_68, i32 24
    %_70 = bitcast i8* %_69 to i8**
    %_71 = load i8*, i8** %_70
    %_72 = bitcast i8* %_71 to i8* (i8*)*
    %_73 = call i8* %_72(i8* %_66)
    store i8* %_73, i8** %current_node
    br label %label11

label10:
    store i1 0, i1* %cont
    %_74 = load i8*, i8** %current_node
    %_75 = bitcast i8* %_74 to i8**
    %_76 = load i8*, i8** %_75
    %_77 = getelementptr i8, i8* %_76, i32 80
    %_78 = bitcast i8* %_77 to i8**
    %_79 = load i8*, i8** %_78
    %_80 = bitcast i8* %_79 to i1 (i8*, i1)*
    %_81 = call i1 %_80(i8* %_74, i1 1)
    store i1 %_81, i1* %ntb
    %_82 = load i8*, i8** %current_node
    %_83 = bitcast i8* %_82 to i8**
    %_84 = load i8*, i8** %_83
    %_85 = getelementptr i8, i8* %_84, i32 8
    %_86 = bitcast i8* %_85 to i8**
    %_87 = load i8*, i8** %_86
    %_88 = bitcast i8* %_87 to i1 (i8*, i8*)*
    %_90 = load i8*, i8** %new_node
    %_89 = call i1 %_88(i8* %_82, i8* %_90)
    store i1 %_89, i1* %ntb
    br label %label11

label11:
    br label %label5

label5:
    br label %label1

label2:

    ret i1 1
}

define i1 @Tree.Delete(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key
    %current_node = alloca i8*
    %parent_node = alloca i8*
    %cont = alloca i1
    %found = alloca i1
    %ntb = alloca i1
    %is_root = alloca i1
    %key_aux = alloca i32
    store i8* %this, i8** %current_node
    store i8* %this, i8** %parent_node
    store i1 1, i1* %cont
    store i1 0, i1* %found
    store i1 1, i1* %is_root
    br label %label1

label1:
    %_0 = load i1, i1* %cont
    br i1 %_0, label %label0, label %label2

label0:
    %_1 = load i8*, i8** %current_node
    %_2 = bitcast i8* %_1 to i8**
    %_3 = load i8*, i8** %_2
    %_4 = getelementptr i8, i8* %_3, i32 40
    %_5 = bitcast i8* %_4 to i8**
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i32 (i8*)*
    %_8 = call i32 %_7(i8* %_1)
    store i32 %_8, i32* %key_aux
    %_9 = load i32, i32* %v_key
    %_10 = load i32, i32* %key_aux
    %_11 = icmp slt i32 %_9, %_10
    br i1 %_11, label %label3, label %label4

label3:
    %_12 = load i8*, i8** %current_node
    %_13 = bitcast i8* %_12 to i8**
    %_14 = load i8*, i8** %_13
    %_15 = getelementptr i8, i8* %_14, i32 64
    %_16 = bitcast i8* %_15 to i8**
    %_17 = load i8*, i8** %_16
    %_18 = bitcast i8* %_17 to i1 (i8*)*
    %_19 = call i1 %_18(i8* %_12)
    br i1 %_19, label %label6, label %label7

label6:
    %_20 = load i8*, i8** %current_node
    store i8* %_20, i8** %parent_node
    %_21 = load i8*, i8** %current_node
    %_22 = bitcast i8* %_21 to i8**
    %_23 = load i8*, i8** %_22
    %_24 = getelementptr i8, i8* %_23, i32 32
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = bitcast i8* %_26 to i8* (i8*)*
    %_28 = call i8* %_27(i8* %_21)
    store i8* %_28, i8** %current_node
    br label %label8

label7:
    store i1 0, i1* %cont
    br label %label8

label8:
    br label %label5

label4:
    %_29 = load i32, i32* %key_aux
    %_30 = load i32, i32* %v_key
    %_31 = icmp slt i32 %_29, %_30
    br i1 %_31, label %label9, label %label10

label9:
    %_32 = load i8*, i8** %current_node
    %_33 = bitcast i8* %_32 to i8**
    %_34 = load i8*, i8** %_33
    %_35 = getelementptr i8, i8* %_34, i32 56
    %_36 = bitcast i8* %_35 to i8**
    %_37 = load i8*, i8** %_36
    %_38 = bitcast i8* %_37 to i1 (i8*)*
    %_39 = call i1 %_38(i8* %_32)
    br i1 %_39, label %label12, label %label13

label12:
    %_40 = load i8*, i8** %current_node
    store i8* %_40, i8** %parent_node
    %_41 = load i8*, i8** %current_node
    %_42 = bitcast i8* %_41 to i8**
    %_43 = load i8*, i8** %_42
    %_44 = getelementptr i8, i8* %_43, i32 24
    %_45 = bitcast i8* %_44 to i8**
    %_46 = load i8*, i8** %_45
    %_47 = bitcast i8* %_46 to i8* (i8*)*
    %_48 = call i8* %_47(i8* %_41)
    store i8* %_48, i8** %current_node
    br label %label14

label13:
    store i1 0, i1* %cont
    br label %label14

label14:
    br label %label11

label10:
    %_49 = load i1, i1* %is_root
    br i1 %_49, label %label15, label %label16

label15:
    %_50 = load i8*, i8** %current_node
    %_51 = bitcast i8* %_50 to i8**
    %_52 = load i8*, i8** %_51
    %_53 = getelementptr i8, i8* %_52, i32 56
    %_54 = bitcast i8* %_53 to i8**
    %_55 = load i8*, i8** %_54
    %_56 = bitcast i8* %_55 to i1 (i8*)*
    %_57 = call i1 %_56(i8* %_50)
    %_58 = xor i1 %_57, 1
    br i1 %_58, label %label21, label %label22

label21:
    %_59 = load i8*, i8** %current_node
    %_60 = bitcast i8* %_59 to i8**
    %_61 = load i8*, i8** %_60
    %_62 = getelementptr i8, i8* %_61, i32 64
    %_63 = bitcast i8* %_62 to i8**
    %_64 = load i8*, i8** %_63
    %_65 = bitcast i8* %_64 to i1 (i8*)*
    %_66 = call i1 %_65(i8* %_59)
    %_67 = xor i1 %_66, 1
    br label %label23

label22:
    br label %label23

label23:
    %_68 = phi i1 [%_67, %label21], [%_58, %label22]
    br i1 %_68, label %label18, label %label19

label18:
    store i1 1, i1* %ntb
    br label %label20

label19:
    %_69 = bitcast i8* %this to i8**
    %_70 = load i8*, i8** %_69
    %_71 = getelementptr i8, i8* %_70, i32 112
    %_72 = bitcast i8* %_71 to i8**
    %_73 = load i8*, i8** %_72
    %_74 = bitcast i8* %_73 to i1 (i8*, i8*, i8*)*
    %_76 = load i8*, i8** %parent_node
    %_77 = load i8*, i8** %current_node
    %_75 = call i1 %_74(i8* %this, i8* %_76, i8* %_77)
    store i1 %_75, i1* %ntb
    br label %label20

label20:
    br label %label17

label16:
    %_78 = bitcast i8* %this to i8**
    %_79 = load i8*, i8** %_78
    %_80 = getelementptr i8, i8* %_79, i32 112
    %_81 = bitcast i8* %_80 to i8**
    %_82 = load i8*, i8** %_81
    %_83 = bitcast i8* %_82 to i1 (i8*, i8*, i8*)*
    %_85 = load i8*, i8** %parent_node
    %_86 = load i8*, i8** %current_node
    %_84 = call i1 %_83(i8* %this, i8* %_85, i8* %_86)
    store i1 %_84, i1* %ntb
    br label %label17

label17:
    store i1 1, i1* %found
    store i1 0, i1* %cont
    br label %label11

label11:
    br label %label5

label5:
    store i1 0, i1* %is_root
    br label %label1

label2:
    %_87 = load i1, i1* %found

    ret i1 %_87
}

define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
    %p_node = alloca i8*
    store i8* %.p_node, i8** %p_node
    %c_node = alloca i8*
    store i8* %.c_node, i8** %c_node
    %ntb = alloca i1
    %auxkey1 = alloca i32
    %auxkey2 = alloca i32
    %_0 = load i8*, i8** %c_node
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 64
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i1 (i8*)*
    %_7 = call i1 %_6(i8* %_0)
    br i1 %_7, label %label0, label %label1

label0:
    %_8 = bitcast i8* %this to i8**
    %_9 = load i8*, i8** %_8
    %_10 = getelementptr i8, i8* %_9, i32 128
    %_11 = bitcast i8* %_10 to i8**
    %_12 = load i8*, i8** %_11
    %_13 = bitcast i8* %_12 to i1 (i8*, i8*, i8*)*
    %_15 = load i8*, i8** %p_node
    %_16 = load i8*, i8** %c_node
    %_14 = call i1 %_13(i8* %this, i8* %_15, i8* %_16)
    store i1 %_14, i1* %ntb
    br label %label2

label1:
    %_17 = load i8*, i8** %c_node
    %_18 = bitcast i8* %_17 to i8**
    %_19 = load i8*, i8** %_18
    %_20 = getelementptr i8, i8* %_19, i32 56
    %_21 = bitcast i8* %_20 to i8**
    %_22 = load i8*, i8** %_21
    %_23 = bitcast i8* %_22 to i1 (i8*)*
    %_24 = call i1 %_23(i8* %_17)
    br i1 %_24, label %label3, label %label4

label3:
    %_25 = bitcast i8* %this to i8**
    %_26 = load i8*, i8** %_25
    %_27 = getelementptr i8, i8* %_26, i32 120
    %_28 = bitcast i8* %_27 to i8**
    %_29 = load i8*, i8** %_28
    %_30 = bitcast i8* %_29 to i1 (i8*, i8*, i8*)*
    %_32 = load i8*, i8** %p_node
    %_33 = load i8*, i8** %c_node
    %_31 = call i1 %_30(i8* %this, i8* %_32, i8* %_33)
    store i1 %_31, i1* %ntb
    br label %label5

label4:
    %_34 = load i8*, i8** %c_node
    %_35 = bitcast i8* %_34 to i8**
    %_36 = load i8*, i8** %_35
    %_37 = getelementptr i8, i8* %_36, i32 40
    %_38 = bitcast i8* %_37 to i8**
    %_39 = load i8*, i8** %_38
    %_40 = bitcast i8* %_39 to i32 (i8*)*
    %_41 = call i32 %_40(i8* %_34)
    store i32 %_41, i32* %auxkey1
    %_42 = load i8*, i8** %p_node
    %_43 = bitcast i8* %_42 to i8**
    %_44 = load i8*, i8** %_43
    %_45 = getelementptr i8, i8* %_44, i32 32
    %_46 = bitcast i8* %_45 to i8**
    %_47 = load i8*, i8** %_46
    %_48 = bitcast i8* %_47 to i8* (i8*)*
    %_49 = call i8* %_48(i8* %_42)
    %_50 = bitcast i8* %_49 to i8**
    %_51 = load i8*, i8** %_50
    %_52 = getelementptr i8, i8* %_51, i32 40
    %_53 = bitcast i8* %_52 to i8**
    %_54 = load i8*, i8** %_53
    %_55 = bitcast i8* %_54 to i32 (i8*)*
    %_56 = call i32 %_55(i8* %_49)
    store i32 %_56, i32* %auxkey2
    %_57 = bitcast i8* %this to i8**
    %_58 = load i8*, i8** %_57
    %_59 = getelementptr i8, i8* %_58, i32 88
    %_60 = bitcast i8* %_59 to i8**
    %_61 = load i8*, i8** %_60
    %_62 = bitcast i8* %_61 to i1 (i8*, i32, i32)*
    %_64 = load i32, i32* %auxkey1
    %_65 = load i32, i32* %auxkey2
    %_63 = call i1 %_62(i8* %this, i32 %_64, i32 %_65)
    br i1 %_63, label %label6, label %label7

label6:
    %_66 = load i8*, i8** %p_node
    %_67 = bitcast i8* %_66 to i8**
    %_68 = load i8*, i8** %_67
    %_69 = getelementptr i8, i8* %_68, i32 16
    %_70 = bitcast i8* %_69 to i8**
    %_71 = load i8*, i8** %_70
    %_72 = bitcast i8* %_71 to i1 (i8*, i8*)*
    %_74 = getelementptr i8, i8* %this, i32 30
    %_75 = bitcast i8* %_74 to i8**
    %_76 = load i8*, i8** %_75
    %_73 = call i1 %_72(i8* %_66, i8* %_76)
    store i1 %_73, i1* %ntb
    %_77 = load i8*, i8** %p_node
    %_78 = bitcast i8* %_77 to i8**
    %_79 = load i8*, i8** %_78
    %_80 = getelementptr i8, i8* %_79, i32 72
    %_81 = bitcast i8* %_80 to i8**
    %_82 = load i8*, i8** %_81
    %_83 = bitcast i8* %_82 to i1 (i8*, i1)*
    %_84 = call i1 %_83(i8* %_77, i1 0)
    store i1 %_84, i1* %ntb
    br label %label8

label7:
    %_85 = load i8*, i8** %p_node
    %_86 = bitcast i8* %_85 to i8**
    %_87 = load i8*, i8** %_86
    %_88 = getelementptr i8, i8* %_87, i32 8
    %_89 = bitcast i8* %_88 to i8**
    %_90 = load i8*, i8** %_89
    %_91 = bitcast i8* %_90 to i1 (i8*, i8*)*
    %_93 = getelementptr i8, i8* %this, i32 30
    %_94 = bitcast i8* %_93 to i8**
    %_95 = load i8*, i8** %_94
    %_92 = call i1 %_91(i8* %_85, i8* %_95)
    store i1 %_92, i1* %ntb
    %_96 = load i8*, i8** %p_node
    %_97 = bitcast i8* %_96 to i8**
    %_98 = load i8*, i8** %_97
    %_99 = getelementptr i8, i8* %_98, i32 80
    %_100 = bitcast i8* %_99 to i8**
    %_101 = load i8*, i8** %_100
    %_102 = bitcast i8* %_101 to i1 (i8*, i1)*
    %_103 = call i1 %_102(i8* %_96, i1 0)
    store i1 %_103, i1* %ntb
    br label %label8

label8:
    br label %label5

label5:
    br label %label2

label2:

    ret i1 1
}

define i1 @Tree.RemoveRight(i8* %this, i8* %.p_node, i8* %.c_node) {
    %p_node = alloca i8*
    store i8* %.p_node, i8** %p_node
    %c_node = alloca i8*
    store i8* %.c_node, i8** %c_node
    %ntb = alloca i1
    br label %label1

label1:
    %_0 = load i8*, i8** %c_node
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 56
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i1 (i8*)*
    %_7 = call i1 %_6(i8* %_0)
    br i1 %_7, label %label0, label %label2

label0:
    %_8 = load i8*, i8** %c_node
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    %_11 = getelementptr i8, i8* %_10, i32 48
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = bitcast i8* %_13 to i1 (i8*, i32)*
    %_16 = load i8*, i8** %c_node
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = getelementptr i8, i8* %_18, i32 24
    %_20 = bitcast i8* %_19 to i8**
    %_21 = load i8*, i8** %_20
    %_22 = bitcast i8* %_21 to i8* (i8*)*
    %_23 = call i8* %_22(i8* %_16)
    %_24 = bitcast i8* %_23 to i8**
    %_25 = load i8*, i8** %_24
    %_26 = getelementptr i8, i8* %_25, i32 40
    %_27 = bitcast i8* %_26 to i8**
    %_28 = load i8*, i8** %_27
    %_29 = bitcast i8* %_28 to i32 (i8*)*
    %_30 = call i32 %_29(i8* %_23)
    %_15 = call i1 %_14(i8* %_8, i32 %_30)
    store i1 %_15, i1* %ntb
    %_31 = load i8*, i8** %c_node
    store i8* %_31, i8** %p_node
    %_32 = load i8*, i8** %c_node
    %_33 = bitcast i8* %_32 to i8**
    %_34 = load i8*, i8** %_33
    %_35 = getelementptr i8, i8* %_34, i32 24
    %_36 = bitcast i8* %_35 to i8**
    %_37 = load i8*, i8** %_36
    %_38 = bitcast i8* %_37 to i8* (i8*)*
    %_39 = call i8* %_38(i8* %_32)
    store i8* %_39, i8** %c_node
    br label %label1

label2:
    %_40 = load i8*, i8** %p_node
    %_41 = bitcast i8* %_40 to i8**
    %_42 = load i8*, i8** %_41
    %_43 = getelementptr i8, i8* %_42, i32 8
    %_44 = bitcast i8* %_43 to i8**
    %_45 = load i8*, i8** %_44
    %_46 = bitcast i8* %_45 to i1 (i8*, i8*)*
    %_48 = getelementptr i8, i8* %this, i32 30
    %_49 = bitcast i8* %_48 to i8**
    %_50 = load i8*, i8** %_49
    %_47 = call i1 %_46(i8* %_40, i8* %_50)
    store i1 %_47, i1* %ntb
    %_51 = load i8*, i8** %p_node
    %_52 = bitcast i8* %_51 to i8**
    %_53 = load i8*, i8** %_52
    %_54 = getelementptr i8, i8* %_53, i32 80
    %_55 = bitcast i8* %_54 to i8**
    %_56 = load i8*, i8** %_55
    %_57 = bitcast i8* %_56 to i1 (i8*, i1)*
    %_58 = call i1 %_57(i8* %_51, i1 0)
    store i1 %_58, i1* %ntb

    ret i1 1
}

define i1 @Tree.RemoveLeft(i8* %this, i8* %.p_node, i8* %.c_node) {
    %p_node = alloca i8*
    store i8* %.p_node, i8** %p_node
    %c_node = alloca i8*
    store i8* %.c_node, i8** %c_node
    %ntb = alloca i1
    br label %label1

label1:
    %_0 = load i8*, i8** %c_node
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 64
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i1 (i8*)*
    %_7 = call i1 %_6(i8* %_0)
    br i1 %_7, label %label0, label %label2

label0:
    %_8 = load i8*, i8** %c_node
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    %_11 = getelementptr i8, i8* %_10, i32 48
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = bitcast i8* %_13 to i1 (i8*, i32)*
    %_16 = load i8*, i8** %c_node
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = getelementptr i8, i8* %_18, i32 32
    %_20 = bitcast i8* %_19 to i8**
    %_21 = load i8*, i8** %_20
    %_22 = bitcast i8* %_21 to i8* (i8*)*
    %_23 = call i8* %_22(i8* %_16)
    %_24 = bitcast i8* %_23 to i8**
    %_25 = load i8*, i8** %_24
    %_26 = getelementptr i8, i8* %_25, i32 40
    %_27 = bitcast i8* %_26 to i8**
    %_28 = load i8*, i8** %_27
    %_29 = bitcast i8* %_28 to i32 (i8*)*
    %_30 = call i32 %_29(i8* %_23)
    %_15 = call i1 %_14(i8* %_8, i32 %_30)
    store i1 %_15, i1* %ntb
    %_31 = load i8*, i8** %c_node
    store i8* %_31, i8** %p_node
    %_32 = load i8*, i8** %c_node
    %_33 = bitcast i8* %_32 to i8**
    %_34 = load i8*, i8** %_33
    %_35 = getelementptr i8, i8* %_34, i32 32
    %_36 = bitcast i8* %_35 to i8**
    %_37 = load i8*, i8** %_36
    %_38 = bitcast i8* %_37 to i8* (i8*)*
    %_39 = call i8* %_38(i8* %_32)
    store i8* %_39, i8** %c_node
    br label %label1

label2:
    %_40 = load i8*, i8** %p_node
    %_41 = bitcast i8* %_40 to i8**
    %_42 = load i8*, i8** %_41
    %_43 = getelementptr i8, i8* %_42, i32 16
    %_44 = bitcast i8* %_43 to i8**
    %_45 = load i8*, i8** %_44
    %_46 = bitcast i8* %_45 to i1 (i8*, i8*)*
    %_48 = getelementptr i8, i8* %this, i32 30
    %_49 = bitcast i8* %_48 to i8**
    %_50 = load i8*, i8** %_49
    %_47 = call i1 %_46(i8* %_40, i8* %_50)
    store i1 %_47, i1* %ntb
    %_51 = load i8*, i8** %p_node
    %_52 = bitcast i8* %_51 to i8**
    %_53 = load i8*, i8** %_52
    %_54 = getelementptr i8, i8* %_53, i32 72
    %_55 = bitcast i8* %_54 to i8**
    %_56 = load i8*, i8** %_55
    %_57 = bitcast i8* %_56 to i1 (i8*, i1)*
    %_58 = call i1 %_57(i8* %_51, i1 0)
    store i1 %_58, i1* %ntb

    ret i1 1
}

define i32 @Tree.Search(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key
    %current_node = alloca i8*
    %ifound = alloca i32
    %cont = alloca i1
    %key_aux = alloca i32
    store i8* %this, i8** %current_node
    store i1 1, i1* %cont
    store i32 0, i32* %ifound
    br label %label1

label1:
    %_0 = load i1, i1* %cont
    br i1 %_0, label %label0, label %label2

label0:
    %_1 = load i8*, i8** %current_node
    %_2 = bitcast i8* %_1 to i8**
    %_3 = load i8*, i8** %_2
    %_4 = getelementptr i8, i8* %_3, i32 40
    %_5 = bitcast i8* %_4 to i8**
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i32 (i8*)*
    %_8 = call i32 %_7(i8* %_1)
    store i32 %_8, i32* %key_aux
    %_9 = load i32, i32* %v_key
    %_10 = load i32, i32* %key_aux
    %_11 = icmp slt i32 %_9, %_10
    br i1 %_11, label %label3, label %label4

label3:
    %_12 = load i8*, i8** %current_node
    %_13 = bitcast i8* %_12 to i8**
    %_14 = load i8*, i8** %_13
    %_15 = getelementptr i8, i8* %_14, i32 64
    %_16 = bitcast i8* %_15 to i8**
    %_17 = load i8*, i8** %_16
    %_18 = bitcast i8* %_17 to i1 (i8*)*
    %_19 = call i1 %_18(i8* %_12)
    br i1 %_19, label %label6, label %label7

label6:
    %_20 = load i8*, i8** %current_node
    %_21 = bitcast i8* %_20 to i8**
    %_22 = load i8*, i8** %_21
    %_23 = getelementptr i8, i8* %_22, i32 32
    %_24 = bitcast i8* %_23 to i8**
    %_25 = load i8*, i8** %_24
    %_26 = bitcast i8* %_25 to i8* (i8*)*
    %_27 = call i8* %_26(i8* %_20)
    store i8* %_27, i8** %current_node
    br label %label8

label7:
    store i1 0, i1* %cont
    br label %label8

label8:
    br label %label5

label4:
    %_28 = load i32, i32* %key_aux
    %_29 = load i32, i32* %v_key
    %_30 = icmp slt i32 %_28, %_29
    br i1 %_30, label %label9, label %label10

label9:
    %_31 = load i8*, i8** %current_node
    %_32 = bitcast i8* %_31 to i8**
    %_33 = load i8*, i8** %_32
    %_34 = getelementptr i8, i8* %_33, i32 56
    %_35 = bitcast i8* %_34 to i8**
    %_36 = load i8*, i8** %_35
    %_37 = bitcast i8* %_36 to i1 (i8*)*
    %_38 = call i1 %_37(i8* %_31)
    br i1 %_38, label %label12, label %label13

label12:
    %_39 = load i8*, i8** %current_node
    %_40 = bitcast i8* %_39 to i8**
    %_41 = load i8*, i8** %_40
    %_42 = getelementptr i8, i8* %_41, i32 24
    %_43 = bitcast i8* %_42 to i8**
    %_44 = load i8*, i8** %_43
    %_45 = bitcast i8* %_44 to i8* (i8*)*
    %_46 = call i8* %_45(i8* %_39)
    store i8* %_46, i8** %current_node
    br label %label14

label13:
    store i1 0, i1* %cont
    br label %label14

label14:
    br label %label11

label10:
    store i32 1, i32* %ifound
    store i1 0, i1* %cont
    br label %label11

label11:
    br label %label5

label5:
    br label %label1

label2:
    %_47 = load i32, i32* %ifound

    ret i32 %_47
}

define i1 @Tree.Print(i8* %this) {
    %ntb = alloca i1
    %current_node = alloca i8*
    store i8* %this, i8** %current_node
    %_0 = bitcast i8* %this to i8**
    %_1 = load i8*, i8** %_0
    %_2 = getelementptr i8, i8* %_1, i32 152
    %_3 = bitcast i8* %_2 to i8**
    %_4 = load i8*, i8** %_3
    %_5 = bitcast i8* %_4 to i1 (i8*, i8*)*
    %_7 = load i8*, i8** %current_node
    %_6 = call i1 %_5(i8* %this, i8* %_7)
    store i1 %_6, i1* %ntb

    ret i1 1
}

define i1 @Tree.RecPrint(i8* %this, i8* %.node) {
    %node = alloca i8*
    store i8* %.node, i8** %node
    %ntb = alloca i1
    %_0 = load i8*, i8** %node
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 64
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i1 (i8*)*
    %_7 = call i1 %_6(i8* %_0)
    br i1 %_7, label %label0, label %label1

label0:
    %_8 = bitcast i8* %this to i8**
    %_9 = load i8*, i8** %_8
    %_10 = getelementptr i8, i8* %_9, i32 152
    %_11 = bitcast i8* %_10 to i8**
    %_12 = load i8*, i8** %_11
    %_13 = bitcast i8* %_12 to i1 (i8*, i8*)*
    %_15 = load i8*, i8** %node
    %_16 = bitcast i8* %_15 to i8**
    %_17 = load i8*, i8** %_16
    %_18 = getelementptr i8, i8* %_17, i32 32
    %_19 = bitcast i8* %_18 to i8**
    %_20 = load i8*, i8** %_19
    %_21 = bitcast i8* %_20 to i8* (i8*)*
    %_22 = call i8* %_21(i8* %_15)
    %_14 = call i1 %_13(i8* %this, i8* %_22)
    store i1 %_14, i1* %ntb
    br label %label2

label1:
    store i1 1, i1* %ntb
    br label %label2

label2:
    %_23 = load i8*, i8** %node
    %_24 = bitcast i8* %_23 to i8**
    %_25 = load i8*, i8** %_24
    %_26 = getelementptr i8, i8* %_25, i32 40
    %_27 = bitcast i8* %_26 to i8**
    %_28 = load i8*, i8** %_27
    %_29 = bitcast i8* %_28 to i32 (i8*)*
    %_30 = call i32 %_29(i8* %_23)
    call void (i32) @print_int(i32 %_30)    %_31 = load i8*, i8** %node
    %_32 = bitcast i8* %_31 to i8**
    %_33 = load i8*, i8** %_32
    %_34 = getelementptr i8, i8* %_33, i32 56
    %_35 = bitcast i8* %_34 to i8**
    %_36 = load i8*, i8** %_35
    %_37 = bitcast i8* %_36 to i1 (i8*)*
    %_38 = call i1 %_37(i8* %_31)
    br i1 %_38, label %label3, label %label4

label3:
    %_39 = bitcast i8* %this to i8**
    %_40 = load i8*, i8** %_39
    %_41 = getelementptr i8, i8* %_40, i32 152
    %_42 = bitcast i8* %_41 to i8**
    %_43 = load i8*, i8** %_42
    %_44 = bitcast i8* %_43 to i1 (i8*, i8*)*
    %_46 = load i8*, i8** %node
    %_47 = bitcast i8* %_46 to i8**
    %_48 = load i8*, i8** %_47
    %_49 = getelementptr i8, i8* %_48, i32 24
    %_50 = bitcast i8* %_49 to i8**
    %_51 = load i8*, i8** %_50
    %_52 = bitcast i8* %_51 to i8* (i8*)*
    %_53 = call i8* %_52(i8* %_46)
    %_45 = call i1 %_44(i8* %this, i8* %_53)
    store i1 %_45, i1* %ntb
    br label %label5

label4:
    store i1 1, i1* %ntb
    br label %label5

label5:

    ret i1 1
}

define i32 @Tree.accept(i8* %this, i8* %.v) {
    %v = alloca i8*
    store i8* %.v, i8** %v
    %nti = alloca i32
    call void (i32) @print_int(i32 333)    %_0 = load i8*, i8** %v
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 0
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i32 (i8*, i8*)*
    %_7 = call i32 %_6(i8* %_0, i8* %this)
    store i32 %_7, i32* %nti

    ret i32 0
}

define i32 @Visitor.visit(i8* %this, i8* %.n) {
    %n = alloca i8*
    store i8* %.n, i8** %n
    %nti = alloca i32
    %_0 = load i8*, i8** %n
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 56
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i1 (i8*)*
    %_7 = call i1 %_6(i8* %_0)
    br i1 %_7, label %label0, label %label1

label0:
    %_8 = getelementptr i8, i8* %this, i32 16
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %n
    %_11 = bitcast i8* %_10 to i8**
    %_12 = load i8*, i8** %_11
    %_13 = getelementptr i8, i8* %_12, i32 24
    %_14 = bitcast i8* %_13 to i8**
    %_15 = load i8*, i8** %_14
    %_16 = bitcast i8* %_15 to i8* (i8*)*
    %_17 = call i8* %_16(i8* %_10)
    store i8* %_17, i8** %_9
    %_18 = getelementptr i8, i8* %this, i32 16
    %_19 = bitcast i8* %_18 to i8**
    %_20 = load i8*, i8** %_19
    %_21 = bitcast i8* %_20 to i8**
    %_22 = load i8*, i8** %_21
    %_23 = getelementptr i8, i8* %_22, i32 160
    %_24 = bitcast i8* %_23 to i8**
    %_25 = load i8*, i8** %_24
    %_26 = bitcast i8* %_25 to i32 (i8*, i8*)*
    %_27 = call i32 %_26(i8* %_20, i8* %this)
    store i32 %_27, i32* %nti
    br label %label2

label1:
    store i32 0, i32* %nti
    br label %label2

label2:
    %_28 = load i8*, i8** %n
    %_29 = bitcast i8* %_28 to i8**
    %_30 = load i8*, i8** %_29
    %_31 = getelementptr i8, i8* %_30, i32 64
    %_32 = bitcast i8* %_31 to i8**
    %_33 = load i8*, i8** %_32
    %_34 = bitcast i8* %_33 to i1 (i8*)*
    %_35 = call i1 %_34(i8* %_28)
    br i1 %_35, label %label3, label %label4

label3:
    %_36 = getelementptr i8, i8* %this, i32 8
    %_37 = bitcast i8* %_36 to i8**
    %_38 = load i8*, i8** %n
    %_39 = bitcast i8* %_38 to i8**
    %_40 = load i8*, i8** %_39
    %_41 = getelementptr i8, i8* %_40, i32 32
    %_42 = bitcast i8* %_41 to i8**
    %_43 = load i8*, i8** %_42
    %_44 = bitcast i8* %_43 to i8* (i8*)*
    %_45 = call i8* %_44(i8* %_38)
    store i8* %_45, i8** %_37
    %_46 = getelementptr i8, i8* %this, i32 8
    %_47 = bitcast i8* %_46 to i8**
    %_48 = load i8*, i8** %_47
    %_49 = bitcast i8* %_48 to i8**
    %_50 = load i8*, i8** %_49
    %_51 = getelementptr i8, i8* %_50, i32 160
    %_52 = bitcast i8* %_51 to i8**
    %_53 = load i8*, i8** %_52
    %_54 = bitcast i8* %_53 to i32 (i8*, i8*)*
    %_55 = call i32 %_54(i8* %_48, i8* %this)
    store i32 %_55, i32* %nti
    br label %label5

label4:
    store i32 0, i32* %nti
    br label %label5

label5:

    ret i32 0
}

define i32 @MyVisitor.visit(i8* %this, i8* %.n) {
    %n = alloca i8*
    store i8* %.n, i8** %n
    %nti = alloca i32
    %_0 = load i8*, i8** %n
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 56
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i1 (i8*)*
    %_7 = call i1 %_6(i8* %_0)
    br i1 %_7, label %label0, label %label1

label0:
    %_8 = getelementptr i8, i8* %this, i32 16
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %n
    %_11 = bitcast i8* %_10 to i8**
    %_12 = load i8*, i8** %_11
    %_13 = getelementptr i8, i8* %_12, i32 24
    %_14 = bitcast i8* %_13 to i8**
    %_15 = load i8*, i8** %_14
    %_16 = bitcast i8* %_15 to i8* (i8*)*
    %_17 = call i8* %_16(i8* %_10)
    store i8* %_17, i8** %_9
    %_18 = getelementptr i8, i8* %this, i32 16
    %_19 = bitcast i8* %_18 to i8**
    %_20 = load i8*, i8** %_19
    %_21 = bitcast i8* %_20 to i8**
    %_22 = load i8*, i8** %_21
    %_23 = getelementptr i8, i8* %_22, i32 160
    %_24 = bitcast i8* %_23 to i8**
    %_25 = load i8*, i8** %_24
    %_26 = bitcast i8* %_25 to i32 (i8*, i8*)*
    %_27 = call i32 %_26(i8* %_20, i8* %this)
    store i32 %_27, i32* %nti
    br label %label2

label1:
    store i32 0, i32* %nti
    br label %label2

label2:
    %_28 = load i8*, i8** %n
    %_29 = bitcast i8* %_28 to i8**
    %_30 = load i8*, i8** %_29
    %_31 = getelementptr i8, i8* %_30, i32 40
    %_32 = bitcast i8* %_31 to i8**
    %_33 = load i8*, i8** %_32
    %_34 = bitcast i8* %_33 to i32 (i8*)*
    %_35 = call i32 %_34(i8* %_28)
    call void (i32) @print_int(i32 %_35)    %_36 = load i8*, i8** %n
    %_37 = bitcast i8* %_36 to i8**
    %_38 = load i8*, i8** %_37
    %_39 = getelementptr i8, i8* %_38, i32 64
    %_40 = bitcast i8* %_39 to i8**
    %_41 = load i8*, i8** %_40
    %_42 = bitcast i8* %_41 to i1 (i8*)*
    %_43 = call i1 %_42(i8* %_36)
    br i1 %_43, label %label3, label %label4

label3:
    %_44 = getelementptr i8, i8* %this, i32 8
    %_45 = bitcast i8* %_44 to i8**
    %_46 = load i8*, i8** %n
    %_47 = bitcast i8* %_46 to i8**
    %_48 = load i8*, i8** %_47
    %_49 = getelementptr i8, i8* %_48, i32 32
    %_50 = bitcast i8* %_49 to i8**
    %_51 = load i8*, i8** %_50
    %_52 = bitcast i8* %_51 to i8* (i8*)*
    %_53 = call i8* %_52(i8* %_46)
    store i8* %_53, i8** %_45
    %_54 = getelementptr i8, i8* %this, i32 8
    %_55 = bitcast i8* %_54 to i8**
    %_56 = load i8*, i8** %_55
    %_57 = bitcast i8* %_56 to i8**
    %_58 = load i8*, i8** %_57
    %_59 = getelementptr i8, i8* %_58, i32 160
    %_60 = bitcast i8* %_59 to i8**
    %_61 = load i8*, i8** %_60
    %_62 = bitcast i8* %_61 to i32 (i8*, i8*)*
    %_63 = call i32 %_62(i8* %_56, i8* %this)
    store i32 %_63, i32* %nti
    br label %label5

label4:
    store i32 0, i32* %nti
    br label %label5

label5:

    ret i32 0
}
