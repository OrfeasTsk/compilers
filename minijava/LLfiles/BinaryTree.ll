@.BinaryTree_vtable = global [0 x i8*] []
@.BT_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @BT.Start to i8*)]
@.Tree_vtable = global [20 x i8*] [i8* bitcast (i8 (i8*,i32)* @Tree.Init to i8*), i8* bitcast (i8 (i8*,i8*)* @Tree.SetRight to i8*), i8* bitcast (i8 (i8*,i8*)* @Tree.SetLeft to i8*), i8* bitcast (i8* (i8*)* @Tree.GetRight to i8*), i8* bitcast (i8* (i8*)* @Tree.GetLeft to i8*), i8* bitcast (i32 (i8*)* @Tree.GetKey to i8*), i8* bitcast (i8 (i8*,i32)* @Tree.SetKey to i8*), i8* bitcast (i8 (i8*)* @Tree.GetHas_Right to i8*), i8* bitcast (i8 (i8*)* @Tree.GetHas_Left to i8*), i8* bitcast (i8 (i8*,i8)* @Tree.SetHas_Left to i8*), i8* bitcast (i8 (i8*,i8)* @Tree.SetHas_Right to i8*), i8* bitcast (i8 (i8*,i32,i32)* @Tree.Compare to i8*), i8* bitcast (i8 (i8*,i32)* @Tree.Insert to i8*), i8* bitcast (i8 (i8*,i32)* @Tree.Delete to i8*), i8* bitcast (i8 (i8*,i8*,i8*)* @Tree.Remove to i8*), i8* bitcast (i8 (i8*,i8*,i8*)* @Tree.RemoveRight to i8*), i8* bitcast (i8 (i8*,i8*,i8*)* @Tree.RemoveLeft to i8*), i8* bitcast (i32 (i8*,i32)* @Tree.Search to i8*), i8* bitcast (i8 (i8*)* @Tree.Print to i8*), i8* bitcast (i8 (i8*,i8*)* @Tree.RecPrint to i8*)]


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
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.BT_vtable, i32 0, i32 0
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

define i32 @BT.Start(i8* %this) {
    %root = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 38)
    store i8* %_0, i8** %root
    %ntb = alloca i8
    store i8 0, i8* %ntb
    %nti = alloca i32
    store i32 0, i32* %nti
    %_1 = call i8* @calloc(i32 1, i32 38)
    %_2 = bitcast i8* %_1 to i8**
    %_3 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
    %_4 = bitcast i8** %_3 to i8*
    store i8* %_4, i8** %_2
    store i8* %_1, i8** %root
    %_5 = load i8*, i8** %root
    %_6 = bitcast i8* %_5 to i8**
    %_7 = load i8*, i8** %_6
    %_8 = getelementptr i8, i8* %_7, i32 0
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    %_11 = bitcast i8* %_10 to i8 (i8*, i32)*
    %_12 = call i8 %_11(i8* %_5, i32 16)
    store i8 %_12, i8* %ntb
    %_13 = load i8*, i8** %root
    %_14 = bitcast i8* %_13 to i8**
    %_15 = load i8*, i8** %_14
    %_16 = getelementptr i8, i8* %_15, i32 144
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = bitcast i8* %_18 to i8 (i8*)*
    %_20 = call i8 %_19(i8* %_13)
    store i8 %_20, i8* %ntb
    call void (i32) @print_int(i32 100000000)
    %_21 = load i8*, i8** %root
    %_22 = bitcast i8* %_21 to i8**
    %_23 = load i8*, i8** %_22
    %_24 = getelementptr i8, i8* %_23, i32 96
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = bitcast i8* %_26 to i8 (i8*, i32)*
    %_28 = call i8 %_27(i8* %_21, i32 8)
    store i8 %_28, i8* %ntb
    %_29 = load i8*, i8** %root
    %_30 = bitcast i8* %_29 to i8**
    %_31 = load i8*, i8** %_30
    %_32 = getelementptr i8, i8* %_31, i32 144
    %_33 = bitcast i8* %_32 to i8**
    %_34 = load i8*, i8** %_33
    %_35 = bitcast i8* %_34 to i8 (i8*)*
    %_36 = call i8 %_35(i8* %_29)
    store i8 %_36, i8* %ntb
    %_37 = load i8*, i8** %root
    %_38 = bitcast i8* %_37 to i8**
    %_39 = load i8*, i8** %_38
    %_40 = getelementptr i8, i8* %_39, i32 96
    %_41 = bitcast i8* %_40 to i8**
    %_42 = load i8*, i8** %_41
    %_43 = bitcast i8* %_42 to i8 (i8*, i32)*
    %_44 = call i8 %_43(i8* %_37, i32 24)
    store i8 %_44, i8* %ntb
    %_45 = load i8*, i8** %root
    %_46 = bitcast i8* %_45 to i8**
    %_47 = load i8*, i8** %_46
    %_48 = getelementptr i8, i8* %_47, i32 96
    %_49 = bitcast i8* %_48 to i8**
    %_50 = load i8*, i8** %_49
    %_51 = bitcast i8* %_50 to i8 (i8*, i32)*
    %_52 = call i8 %_51(i8* %_45, i32 4)
    store i8 %_52, i8* %ntb
    %_53 = load i8*, i8** %root
    %_54 = bitcast i8* %_53 to i8**
    %_55 = load i8*, i8** %_54
    %_56 = getelementptr i8, i8* %_55, i32 96
    %_57 = bitcast i8* %_56 to i8**
    %_58 = load i8*, i8** %_57
    %_59 = bitcast i8* %_58 to i8 (i8*, i32)*
    %_60 = call i8 %_59(i8* %_53, i32 12)
    store i8 %_60, i8* %ntb
    %_61 = load i8*, i8** %root
    %_62 = bitcast i8* %_61 to i8**
    %_63 = load i8*, i8** %_62
    %_64 = getelementptr i8, i8* %_63, i32 96
    %_65 = bitcast i8* %_64 to i8**
    %_66 = load i8*, i8** %_65
    %_67 = bitcast i8* %_66 to i8 (i8*, i32)*
    %_68 = call i8 %_67(i8* %_61, i32 20)
    store i8 %_68, i8* %ntb
    %_69 = load i8*, i8** %root
    %_70 = bitcast i8* %_69 to i8**
    %_71 = load i8*, i8** %_70
    %_72 = getelementptr i8, i8* %_71, i32 96
    %_73 = bitcast i8* %_72 to i8**
    %_74 = load i8*, i8** %_73
    %_75 = bitcast i8* %_74 to i8 (i8*, i32)*
    %_76 = call i8 %_75(i8* %_69, i32 28)
    store i8 %_76, i8* %ntb
    %_77 = load i8*, i8** %root
    %_78 = bitcast i8* %_77 to i8**
    %_79 = load i8*, i8** %_78
    %_80 = getelementptr i8, i8* %_79, i32 96
    %_81 = bitcast i8* %_80 to i8**
    %_82 = load i8*, i8** %_81
    %_83 = bitcast i8* %_82 to i8 (i8*, i32)*
    %_84 = call i8 %_83(i8* %_77, i32 14)
    store i8 %_84, i8* %ntb
    %_85 = load i8*, i8** %root
    %_86 = bitcast i8* %_85 to i8**
    %_87 = load i8*, i8** %_86
    %_88 = getelementptr i8, i8* %_87, i32 144
    %_89 = bitcast i8* %_88 to i8**
    %_90 = load i8*, i8** %_89
    %_91 = bitcast i8* %_90 to i8 (i8*)*
    %_92 = call i8 %_91(i8* %_85)
    store i8 %_92, i8* %ntb
    %_93 = load i8*, i8** %root
    %_94 = bitcast i8* %_93 to i8**
    %_95 = load i8*, i8** %_94
    %_96 = getelementptr i8, i8* %_95, i32 136
    %_97 = bitcast i8* %_96 to i8**
    %_98 = load i8*, i8** %_97
    %_99 = bitcast i8* %_98 to i32 (i8*, i32)*
    %_100 = call i32 %_99(i8* %_93, i32 24)
    call void (i32) @print_int(i32 %_100)
    %_101 = load i8*, i8** %root
    %_102 = bitcast i8* %_101 to i8**
    %_103 = load i8*, i8** %_102
    %_104 = getelementptr i8, i8* %_103, i32 136
    %_105 = bitcast i8* %_104 to i8**
    %_106 = load i8*, i8** %_105
    %_107 = bitcast i8* %_106 to i32 (i8*, i32)*
    %_108 = call i32 %_107(i8* %_101, i32 12)
    call void (i32) @print_int(i32 %_108)
    %_109 = load i8*, i8** %root
    %_110 = bitcast i8* %_109 to i8**
    %_111 = load i8*, i8** %_110
    %_112 = getelementptr i8, i8* %_111, i32 136
    %_113 = bitcast i8* %_112 to i8**
    %_114 = load i8*, i8** %_113
    %_115 = bitcast i8* %_114 to i32 (i8*, i32)*
    %_116 = call i32 %_115(i8* %_109, i32 16)
    call void (i32) @print_int(i32 %_116)
    %_117 = load i8*, i8** %root
    %_118 = bitcast i8* %_117 to i8**
    %_119 = load i8*, i8** %_118
    %_120 = getelementptr i8, i8* %_119, i32 136
    %_121 = bitcast i8* %_120 to i8**
    %_122 = load i8*, i8** %_121
    %_123 = bitcast i8* %_122 to i32 (i8*, i32)*
    %_124 = call i32 %_123(i8* %_117, i32 50)
    call void (i32) @print_int(i32 %_124)
    %_125 = load i8*, i8** %root
    %_126 = bitcast i8* %_125 to i8**
    %_127 = load i8*, i8** %_126
    %_128 = getelementptr i8, i8* %_127, i32 136
    %_129 = bitcast i8* %_128 to i8**
    %_130 = load i8*, i8** %_129
    %_131 = bitcast i8* %_130 to i32 (i8*, i32)*
    %_132 = call i32 %_131(i8* %_125, i32 12)
    call void (i32) @print_int(i32 %_132)
    %_133 = load i8*, i8** %root
    %_134 = bitcast i8* %_133 to i8**
    %_135 = load i8*, i8** %_134
    %_136 = getelementptr i8, i8* %_135, i32 104
    %_137 = bitcast i8* %_136 to i8**
    %_138 = load i8*, i8** %_137
    %_139 = bitcast i8* %_138 to i8 (i8*, i32)*
    %_140 = call i8 %_139(i8* %_133, i32 12)
    store i8 %_140, i8* %ntb
    %_141 = load i8*, i8** %root
    %_142 = bitcast i8* %_141 to i8**
    %_143 = load i8*, i8** %_142
    %_144 = getelementptr i8, i8* %_143, i32 144
    %_145 = bitcast i8* %_144 to i8**
    %_146 = load i8*, i8** %_145
    %_147 = bitcast i8* %_146 to i8 (i8*)*
    %_148 = call i8 %_147(i8* %_141)
    store i8 %_148, i8* %ntb
    %_149 = load i8*, i8** %root
    %_150 = bitcast i8* %_149 to i8**
    %_151 = load i8*, i8** %_150
    %_152 = getelementptr i8, i8* %_151, i32 136
    %_153 = bitcast i8* %_152 to i8**
    %_154 = load i8*, i8** %_153
    %_155 = bitcast i8* %_154 to i32 (i8*, i32)*
    %_156 = call i32 %_155(i8* %_149, i32 12)
    call void (i32) @print_int(i32 %_156)

    ret i32 0
}

define i8 @Tree.Init(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key
    %_0 = getelementptr i8, i8* %this, i32 24
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %v_key
    store i32 %_2, i32* %_1
    %_3 = getelementptr i8, i8* %this, i32 28
    %_4 = bitcast i8* %_3 to i8*
    store i8 0, i8* %_4
    %_5 = getelementptr i8, i8* %this, i32 29
    %_6 = bitcast i8* %_5 to i8*
    store i8 0, i8* %_6

    ret i8 1
}

define i8 @Tree.SetRight(i8* %this, i8* %.rn) {
    %rn = alloca i8*
    store i8* %.rn, i8** %rn
    %_0 = getelementptr i8, i8* %this, i32 16
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %rn
    store i8* %_2, i8** %_1

    ret i8 1
}

define i8 @Tree.SetLeft(i8* %this, i8* %.ln) {
    %ln = alloca i8*
    store i8* %.ln, i8** %ln
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %ln
    store i8* %_2, i8** %_1

    ret i8 1
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

define i8 @Tree.SetKey(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key
    %_0 = getelementptr i8, i8* %this, i32 24
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %v_key
    store i32 %_2, i32* %_1

    ret i8 1
}

define i8 @Tree.GetHas_Right(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 29
    %_1 = bitcast i8* %_0 to i8*
    %_2 = load i8, i8* %_1

    ret i8 %_2
}

define i8 @Tree.GetHas_Left(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 28
    %_1 = bitcast i8* %_0 to i8*
    %_2 = load i8, i8* %_1

    ret i8 %_2
}

define i8 @Tree.SetHas_Left(i8* %this, i8 %.val) {
    %val = alloca i8
    store i8 %.val, i8* %val
    %_0 = getelementptr i8, i8* %this, i32 28
    %_1 = bitcast i8* %_0 to i8*
    %_2 = load i8, i8* %val
    store i8 %_2, i8* %_1

    ret i8 1
}

define i8 @Tree.SetHas_Right(i8* %this, i8 %.val) {
    %val = alloca i8
    store i8 %.val, i8* %val
    %_0 = getelementptr i8, i8* %this, i32 29
    %_1 = bitcast i8* %_0 to i8*
    %_2 = load i8, i8* %val
    store i8 %_2, i8* %_1

    ret i8 1
}

define i8 @Tree.Compare(i8* %this, i32 %.num1, i32 %.num2) {
    %num1 = alloca i32
    store i32 %.num1, i32* %num1
    %num2 = alloca i32
    store i32 %.num2, i32* %num2
    %ntb = alloca i8
    store i8 0, i8* %ntb
    %nti = alloca i32
    store i32 0, i32* %nti
    store i8 0, i8* %ntb
    %_0 = load i32, i32* %num2
    %_1 = add i32 %_0, 1
    store i32 %_1, i32* %nti
    %_2 = load i32, i32* %num1
    %_3 = load i32, i32* %num2
    %_4 = icmp slt i32 %_2, %_3
    %_5 = zext i1 %_4 to i8
    %_6 = trunc i8 %_5 to i1
    br i1 %_6, label %label0, label %label1

label0:
    store i8 0, i8* %ntb
    br label %label2

label1:
    %_7 = load i32, i32* %num1
    %_8 = load i32, i32* %nti
    %_9 = icmp slt i32 %_7, %_8
    %_10 = zext i1 %_9 to i8
    %_11 = xor i8 %_10, 1
    %_12 = trunc i8 %_11 to i1
    br i1 %_12, label %label3, label %label4

label3:
    store i8 0, i8* %ntb
    br label %label5

label4:
    store i8 1, i8* %ntb
    br label %label5

label5:
    br label %label2

label2:
    %_13 = load i8, i8* %ntb

    ret i8 %_13
}

define i8 @Tree.Insert(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key
    %new_node = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 38)
    store i8* %_0, i8** %new_node
    %ntb = alloca i8
    store i8 0, i8* %ntb
    %cont = alloca i8
    store i8 0, i8* %cont
    %key_aux = alloca i32
    store i32 0, i32* %key_aux
    %current_node = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 38)
    store i8* %_1, i8** %current_node
    %_2 = call i8* @calloc(i32 1, i32 38)
    %_3 = bitcast i8* %_2 to i8**
    %_4 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
    %_5 = bitcast i8** %_4 to i8*
    store i8* %_5, i8** %_3
    store i8* %_2, i8** %new_node
    %_6 = load i8*, i8** %new_node
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %_7
    %_9 = getelementptr i8, i8* %_8, i32 0
    %_10 = bitcast i8* %_9 to i8**
    %_11 = load i8*, i8** %_10
    %_12 = bitcast i8* %_11 to i8 (i8*, i32)*
    %_14 = load i32, i32* %v_key
    %_13 = call i8 %_12(i8* %_6, i32 %_14)
    store i8 %_13, i8* %ntb
    store i8* %this, i8** %current_node
    store i8 1, i8* %cont
    br label %label1

label1:
    %_15 = load i8, i8* %cont
    %_16 = trunc i8 %_15 to i1
    br i1 %_16, label %label0, label %label2

label0:
    %_17 = load i8*, i8** %current_node
    %_18 = bitcast i8* %_17 to i8**
    %_19 = load i8*, i8** %_18
    %_20 = getelementptr i8, i8* %_19, i32 40
    %_21 = bitcast i8* %_20 to i8**
    %_22 = load i8*, i8** %_21
    %_23 = bitcast i8* %_22 to i32 (i8*)*
    %_24 = call i32 %_23(i8* %_17)
    store i32 %_24, i32* %key_aux
    %_25 = load i32, i32* %v_key
    %_26 = load i32, i32* %key_aux
    %_27 = icmp slt i32 %_25, %_26
    %_28 = zext i1 %_27 to i8
    %_29 = trunc i8 %_28 to i1
    br i1 %_29, label %label3, label %label4

label3:
    %_30 = load i8*, i8** %current_node
    %_31 = bitcast i8* %_30 to i8**
    %_32 = load i8*, i8** %_31
    %_33 = getelementptr i8, i8* %_32, i32 64
    %_34 = bitcast i8* %_33 to i8**
    %_35 = load i8*, i8** %_34
    %_36 = bitcast i8* %_35 to i8 (i8*)*
    %_37 = call i8 %_36(i8* %_30)
    %_38 = trunc i8 %_37 to i1
    br i1 %_38, label %label6, label %label7

label6:
    %_39 = load i8*, i8** %current_node
    %_40 = bitcast i8* %_39 to i8**
    %_41 = load i8*, i8** %_40
    %_42 = getelementptr i8, i8* %_41, i32 32
    %_43 = bitcast i8* %_42 to i8**
    %_44 = load i8*, i8** %_43
    %_45 = bitcast i8* %_44 to i8* (i8*)*
    %_46 = call i8* %_45(i8* %_39)
    store i8* %_46, i8** %current_node
    br label %label8

label7:
    store i8 0, i8* %cont
    %_47 = load i8*, i8** %current_node
    %_48 = bitcast i8* %_47 to i8**
    %_49 = load i8*, i8** %_48
    %_50 = getelementptr i8, i8* %_49, i32 72
    %_51 = bitcast i8* %_50 to i8**
    %_52 = load i8*, i8** %_51
    %_53 = bitcast i8* %_52 to i8 (i8*, i8)*
    %_54 = call i8 %_53(i8* %_47, i8 1)
    store i8 %_54, i8* %ntb
    %_55 = load i8*, i8** %current_node
    %_56 = bitcast i8* %_55 to i8**
    %_57 = load i8*, i8** %_56
    %_58 = getelementptr i8, i8* %_57, i32 16
    %_59 = bitcast i8* %_58 to i8**
    %_60 = load i8*, i8** %_59
    %_61 = bitcast i8* %_60 to i8 (i8*, i8*)*
    %_63 = load i8*, i8** %new_node
    %_62 = call i8 %_61(i8* %_55, i8* %_63)
    store i8 %_62, i8* %ntb
    br label %label8

label8:
    br label %label5

label4:
    %_64 = load i8*, i8** %current_node
    %_65 = bitcast i8* %_64 to i8**
    %_66 = load i8*, i8** %_65
    %_67 = getelementptr i8, i8* %_66, i32 56
    %_68 = bitcast i8* %_67 to i8**
    %_69 = load i8*, i8** %_68
    %_70 = bitcast i8* %_69 to i8 (i8*)*
    %_71 = call i8 %_70(i8* %_64)
    %_72 = trunc i8 %_71 to i1
    br i1 %_72, label %label9, label %label10

label9:
    %_73 = load i8*, i8** %current_node
    %_74 = bitcast i8* %_73 to i8**
    %_75 = load i8*, i8** %_74
    %_76 = getelementptr i8, i8* %_75, i32 24
    %_77 = bitcast i8* %_76 to i8**
    %_78 = load i8*, i8** %_77
    %_79 = bitcast i8* %_78 to i8* (i8*)*
    %_80 = call i8* %_79(i8* %_73)
    store i8* %_80, i8** %current_node
    br label %label11

label10:
    store i8 0, i8* %cont
    %_81 = load i8*, i8** %current_node
    %_82 = bitcast i8* %_81 to i8**
    %_83 = load i8*, i8** %_82
    %_84 = getelementptr i8, i8* %_83, i32 80
    %_85 = bitcast i8* %_84 to i8**
    %_86 = load i8*, i8** %_85
    %_87 = bitcast i8* %_86 to i8 (i8*, i8)*
    %_88 = call i8 %_87(i8* %_81, i8 1)
    store i8 %_88, i8* %ntb
    %_89 = load i8*, i8** %current_node
    %_90 = bitcast i8* %_89 to i8**
    %_91 = load i8*, i8** %_90
    %_92 = getelementptr i8, i8* %_91, i32 8
    %_93 = bitcast i8* %_92 to i8**
    %_94 = load i8*, i8** %_93
    %_95 = bitcast i8* %_94 to i8 (i8*, i8*)*
    %_97 = load i8*, i8** %new_node
    %_96 = call i8 %_95(i8* %_89, i8* %_97)
    store i8 %_96, i8* %ntb
    br label %label11

label11:
    br label %label5

label5:
    br label %label1

label2:

    ret i8 1
}

define i8 @Tree.Delete(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key
    %current_node = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 38)
    store i8* %_0, i8** %current_node
    %parent_node = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 38)
    store i8* %_1, i8** %parent_node
    %cont = alloca i8
    store i8 0, i8* %cont
    %found = alloca i8
    store i8 0, i8* %found
    %is_root = alloca i8
    store i8 0, i8* %is_root
    %key_aux = alloca i32
    store i32 0, i32* %key_aux
    %ntb = alloca i8
    store i8 0, i8* %ntb
    store i8* %this, i8** %current_node
    store i8* %this, i8** %parent_node
    store i8 1, i8* %cont
    store i8 0, i8* %found
    store i8 1, i8* %is_root
    br label %label1

label1:
    %_2 = load i8, i8* %cont
    %_3 = trunc i8 %_2 to i1
    br i1 %_3, label %label0, label %label2

label0:
    %_4 = load i8*, i8** %current_node
    %_5 = bitcast i8* %_4 to i8**
    %_6 = load i8*, i8** %_5
    %_7 = getelementptr i8, i8* %_6, i32 40
    %_8 = bitcast i8* %_7 to i8**
    %_9 = load i8*, i8** %_8
    %_10 = bitcast i8* %_9 to i32 (i8*)*
    %_11 = call i32 %_10(i8* %_4)
    store i32 %_11, i32* %key_aux
    %_12 = load i32, i32* %v_key
    %_13 = load i32, i32* %key_aux
    %_14 = icmp slt i32 %_12, %_13
    %_15 = zext i1 %_14 to i8
    %_16 = trunc i8 %_15 to i1
    br i1 %_16, label %label3, label %label4

label3:
    %_17 = load i8*, i8** %current_node
    %_18 = bitcast i8* %_17 to i8**
    %_19 = load i8*, i8** %_18
    %_20 = getelementptr i8, i8* %_19, i32 64
    %_21 = bitcast i8* %_20 to i8**
    %_22 = load i8*, i8** %_21
    %_23 = bitcast i8* %_22 to i8 (i8*)*
    %_24 = call i8 %_23(i8* %_17)
    %_25 = trunc i8 %_24 to i1
    br i1 %_25, label %label6, label %label7

label6:
    %_26 = load i8*, i8** %current_node
    store i8* %_26, i8** %parent_node
    %_27 = load i8*, i8** %current_node
    %_28 = bitcast i8* %_27 to i8**
    %_29 = load i8*, i8** %_28
    %_30 = getelementptr i8, i8* %_29, i32 32
    %_31 = bitcast i8* %_30 to i8**
    %_32 = load i8*, i8** %_31
    %_33 = bitcast i8* %_32 to i8* (i8*)*
    %_34 = call i8* %_33(i8* %_27)
    store i8* %_34, i8** %current_node
    br label %label8

label7:
    store i8 0, i8* %cont
    br label %label8

label8:
    br label %label5

label4:
    %_35 = load i32, i32* %key_aux
    %_36 = load i32, i32* %v_key
    %_37 = icmp slt i32 %_35, %_36
    %_38 = zext i1 %_37 to i8
    %_39 = trunc i8 %_38 to i1
    br i1 %_39, label %label9, label %label10

label9:
    %_40 = load i8*, i8** %current_node
    %_41 = bitcast i8* %_40 to i8**
    %_42 = load i8*, i8** %_41
    %_43 = getelementptr i8, i8* %_42, i32 56
    %_44 = bitcast i8* %_43 to i8**
    %_45 = load i8*, i8** %_44
    %_46 = bitcast i8* %_45 to i8 (i8*)*
    %_47 = call i8 %_46(i8* %_40)
    %_48 = trunc i8 %_47 to i1
    br i1 %_48, label %label12, label %label13

label12:
    %_49 = load i8*, i8** %current_node
    store i8* %_49, i8** %parent_node
    %_50 = load i8*, i8** %current_node
    %_51 = bitcast i8* %_50 to i8**
    %_52 = load i8*, i8** %_51
    %_53 = getelementptr i8, i8* %_52, i32 24
    %_54 = bitcast i8* %_53 to i8**
    %_55 = load i8*, i8** %_54
    %_56 = bitcast i8* %_55 to i8* (i8*)*
    %_57 = call i8* %_56(i8* %_50)
    store i8* %_57, i8** %current_node
    br label %label14

label13:
    store i8 0, i8* %cont
    br label %label14

label14:
    br label %label11

label10:
    %_58 = load i8, i8* %is_root
    %_59 = trunc i8 %_58 to i1
    br i1 %_59, label %label15, label %label16

label15:
    %_60 = load i8*, i8** %current_node
    %_61 = bitcast i8* %_60 to i8**
    %_62 = load i8*, i8** %_61
    %_63 = getelementptr i8, i8* %_62, i32 56
    %_64 = bitcast i8* %_63 to i8**
    %_65 = load i8*, i8** %_64
    %_66 = bitcast i8* %_65 to i8 (i8*)*
    %_67 = call i8 %_66(i8* %_60)
    %_68 = xor i8 %_67, 1
    %_69 = trunc i8 %_68 to i1
    br i1 %_69, label %label21, label %label22

label21:
    %_70 = load i8*, i8** %current_node
    %_71 = bitcast i8* %_70 to i8**
    %_72 = load i8*, i8** %_71
    %_73 = getelementptr i8, i8* %_72, i32 64
    %_74 = bitcast i8* %_73 to i8**
    %_75 = load i8*, i8** %_74
    %_76 = bitcast i8* %_75 to i8 (i8*)*
    %_77 = call i8 %_76(i8* %_70)
    %_78 = xor i8 %_77, 1
    br label %label23

label23:
    br label %label24

label22:
    br label %label24

label24:
    %_79 = phi i8 [%_78, %label23], [%_68, %label22]
    %_80 = trunc i8 %_79 to i1
    br i1 %_80, label %label18, label %label19

label18:
    store i8 1, i8* %ntb
    br label %label20

label19:
    %_81 = bitcast i8* %this to i8**
    %_82 = load i8*, i8** %_81
    %_83 = getelementptr i8, i8* %_82, i32 112
    %_84 = bitcast i8* %_83 to i8**
    %_85 = load i8*, i8** %_84
    %_86 = bitcast i8* %_85 to i8 (i8*, i8*, i8*)*
    %_88 = load i8*, i8** %parent_node
    %_89 = load i8*, i8** %current_node
    %_87 = call i8 %_86(i8* %this, i8* %_88, i8* %_89)
    store i8 %_87, i8* %ntb
    br label %label20

label20:
    br label %label17

label16:
    %_90 = bitcast i8* %this to i8**
    %_91 = load i8*, i8** %_90
    %_92 = getelementptr i8, i8* %_91, i32 112
    %_93 = bitcast i8* %_92 to i8**
    %_94 = load i8*, i8** %_93
    %_95 = bitcast i8* %_94 to i8 (i8*, i8*, i8*)*
    %_97 = load i8*, i8** %parent_node
    %_98 = load i8*, i8** %current_node
    %_96 = call i8 %_95(i8* %this, i8* %_97, i8* %_98)
    store i8 %_96, i8* %ntb
    br label %label17

label17:
    store i8 1, i8* %found
    store i8 0, i8* %cont
    br label %label11

label11:
    br label %label5

label5:
    store i8 0, i8* %is_root
    br label %label1

label2:
    %_99 = load i8, i8* %found

    ret i8 %_99
}

define i8 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
    %p_node = alloca i8*
    store i8* %.p_node, i8** %p_node
    %c_node = alloca i8*
    store i8* %.c_node, i8** %c_node
    %ntb = alloca i8
    store i8 0, i8* %ntb
    %auxkey1 = alloca i32
    store i32 0, i32* %auxkey1
    %auxkey2 = alloca i32
    store i32 0, i32* %auxkey2
    %_0 = load i8*, i8** %c_node
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 64
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i8 (i8*)*
    %_7 = call i8 %_6(i8* %_0)
    %_8 = trunc i8 %_7 to i1
    br i1 %_8, label %label0, label %label1

label0:
    %_9 = bitcast i8* %this to i8**
    %_10 = load i8*, i8** %_9
    %_11 = getelementptr i8, i8* %_10, i32 128
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = bitcast i8* %_13 to i8 (i8*, i8*, i8*)*
    %_16 = load i8*, i8** %p_node
    %_17 = load i8*, i8** %c_node
    %_15 = call i8 %_14(i8* %this, i8* %_16, i8* %_17)
    store i8 %_15, i8* %ntb
    br label %label2

label1:
    %_18 = load i8*, i8** %c_node
    %_19 = bitcast i8* %_18 to i8**
    %_20 = load i8*, i8** %_19
    %_21 = getelementptr i8, i8* %_20, i32 56
    %_22 = bitcast i8* %_21 to i8**
    %_23 = load i8*, i8** %_22
    %_24 = bitcast i8* %_23 to i8 (i8*)*
    %_25 = call i8 %_24(i8* %_18)
    %_26 = trunc i8 %_25 to i1
    br i1 %_26, label %label3, label %label4

label3:
    %_27 = bitcast i8* %this to i8**
    %_28 = load i8*, i8** %_27
    %_29 = getelementptr i8, i8* %_28, i32 120
    %_30 = bitcast i8* %_29 to i8**
    %_31 = load i8*, i8** %_30
    %_32 = bitcast i8* %_31 to i8 (i8*, i8*, i8*)*
    %_34 = load i8*, i8** %p_node
    %_35 = load i8*, i8** %c_node
    %_33 = call i8 %_32(i8* %this, i8* %_34, i8* %_35)
    store i8 %_33, i8* %ntb
    br label %label5

label4:
    %_36 = load i8*, i8** %c_node
    %_37 = bitcast i8* %_36 to i8**
    %_38 = load i8*, i8** %_37
    %_39 = getelementptr i8, i8* %_38, i32 40
    %_40 = bitcast i8* %_39 to i8**
    %_41 = load i8*, i8** %_40
    %_42 = bitcast i8* %_41 to i32 (i8*)*
    %_43 = call i32 %_42(i8* %_36)
    store i32 %_43, i32* %auxkey1
    %_44 = load i8*, i8** %p_node
    %_45 = bitcast i8* %_44 to i8**
    %_46 = load i8*, i8** %_45
    %_47 = getelementptr i8, i8* %_46, i32 32
    %_48 = bitcast i8* %_47 to i8**
    %_49 = load i8*, i8** %_48
    %_50 = bitcast i8* %_49 to i8* (i8*)*
    %_51 = call i8* %_50(i8* %_44)
    %_52 = bitcast i8* %_51 to i8**
    %_53 = load i8*, i8** %_52
    %_54 = getelementptr i8, i8* %_53, i32 40
    %_55 = bitcast i8* %_54 to i8**
    %_56 = load i8*, i8** %_55
    %_57 = bitcast i8* %_56 to i32 (i8*)*
    %_58 = call i32 %_57(i8* %_51)
    store i32 %_58, i32* %auxkey2
    %_59 = bitcast i8* %this to i8**
    %_60 = load i8*, i8** %_59
    %_61 = getelementptr i8, i8* %_60, i32 88
    %_62 = bitcast i8* %_61 to i8**
    %_63 = load i8*, i8** %_62
    %_64 = bitcast i8* %_63 to i8 (i8*, i32, i32)*
    %_66 = load i32, i32* %auxkey1
    %_67 = load i32, i32* %auxkey2
    %_65 = call i8 %_64(i8* %this, i32 %_66, i32 %_67)
    %_68 = trunc i8 %_65 to i1
    br i1 %_68, label %label6, label %label7

label6:
    %_69 = load i8*, i8** %p_node
    %_70 = bitcast i8* %_69 to i8**
    %_71 = load i8*, i8** %_70
    %_72 = getelementptr i8, i8* %_71, i32 16
    %_73 = bitcast i8* %_72 to i8**
    %_74 = load i8*, i8** %_73
    %_75 = bitcast i8* %_74 to i8 (i8*, i8*)*
    %_77 = getelementptr i8, i8* %this, i32 30
    %_78 = bitcast i8* %_77 to i8**
    %_79 = load i8*, i8** %_78
    %_76 = call i8 %_75(i8* %_69, i8* %_79)
    store i8 %_76, i8* %ntb
    %_80 = load i8*, i8** %p_node
    %_81 = bitcast i8* %_80 to i8**
    %_82 = load i8*, i8** %_81
    %_83 = getelementptr i8, i8* %_82, i32 72
    %_84 = bitcast i8* %_83 to i8**
    %_85 = load i8*, i8** %_84
    %_86 = bitcast i8* %_85 to i8 (i8*, i8)*
    %_87 = call i8 %_86(i8* %_80, i8 0)
    store i8 %_87, i8* %ntb
    br label %label8

label7:
    %_88 = load i8*, i8** %p_node
    %_89 = bitcast i8* %_88 to i8**
    %_90 = load i8*, i8** %_89
    %_91 = getelementptr i8, i8* %_90, i32 8
    %_92 = bitcast i8* %_91 to i8**
    %_93 = load i8*, i8** %_92
    %_94 = bitcast i8* %_93 to i8 (i8*, i8*)*
    %_96 = getelementptr i8, i8* %this, i32 30
    %_97 = bitcast i8* %_96 to i8**
    %_98 = load i8*, i8** %_97
    %_95 = call i8 %_94(i8* %_88, i8* %_98)
    store i8 %_95, i8* %ntb
    %_99 = load i8*, i8** %p_node
    %_100 = bitcast i8* %_99 to i8**
    %_101 = load i8*, i8** %_100
    %_102 = getelementptr i8, i8* %_101, i32 80
    %_103 = bitcast i8* %_102 to i8**
    %_104 = load i8*, i8** %_103
    %_105 = bitcast i8* %_104 to i8 (i8*, i8)*
    %_106 = call i8 %_105(i8* %_99, i8 0)
    store i8 %_106, i8* %ntb
    br label %label8

label8:
    br label %label5

label5:
    br label %label2

label2:

    ret i8 1
}

define i8 @Tree.RemoveRight(i8* %this, i8* %.p_node, i8* %.c_node) {
    %p_node = alloca i8*
    store i8* %.p_node, i8** %p_node
    %c_node = alloca i8*
    store i8* %.c_node, i8** %c_node
    %ntb = alloca i8
    store i8 0, i8* %ntb
    br label %label1

label1:
    %_0 = load i8*, i8** %c_node
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 56
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i8 (i8*)*
    %_7 = call i8 %_6(i8* %_0)
    %_8 = trunc i8 %_7 to i1
    br i1 %_8, label %label0, label %label2

label0:
    %_9 = load i8*, i8** %c_node
    %_10 = bitcast i8* %_9 to i8**
    %_11 = load i8*, i8** %_10
    %_12 = getelementptr i8, i8* %_11, i32 48
    %_13 = bitcast i8* %_12 to i8**
    %_14 = load i8*, i8** %_13
    %_15 = bitcast i8* %_14 to i8 (i8*, i32)*
    %_17 = load i8*, i8** %c_node
    %_18 = bitcast i8* %_17 to i8**
    %_19 = load i8*, i8** %_18
    %_20 = getelementptr i8, i8* %_19, i32 24
    %_21 = bitcast i8* %_20 to i8**
    %_22 = load i8*, i8** %_21
    %_23 = bitcast i8* %_22 to i8* (i8*)*
    %_24 = call i8* %_23(i8* %_17)
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = getelementptr i8, i8* %_26, i32 40
    %_28 = bitcast i8* %_27 to i8**
    %_29 = load i8*, i8** %_28
    %_30 = bitcast i8* %_29 to i32 (i8*)*
    %_31 = call i32 %_30(i8* %_24)
    %_16 = call i8 %_15(i8* %_9, i32 %_31)
    store i8 %_16, i8* %ntb
    %_32 = load i8*, i8** %c_node
    store i8* %_32, i8** %p_node
    %_33 = load i8*, i8** %c_node
    %_34 = bitcast i8* %_33 to i8**
    %_35 = load i8*, i8** %_34
    %_36 = getelementptr i8, i8* %_35, i32 24
    %_37 = bitcast i8* %_36 to i8**
    %_38 = load i8*, i8** %_37
    %_39 = bitcast i8* %_38 to i8* (i8*)*
    %_40 = call i8* %_39(i8* %_33)
    store i8* %_40, i8** %c_node
    br label %label1

label2:
    %_41 = load i8*, i8** %p_node
    %_42 = bitcast i8* %_41 to i8**
    %_43 = load i8*, i8** %_42
    %_44 = getelementptr i8, i8* %_43, i32 8
    %_45 = bitcast i8* %_44 to i8**
    %_46 = load i8*, i8** %_45
    %_47 = bitcast i8* %_46 to i8 (i8*, i8*)*
    %_49 = getelementptr i8, i8* %this, i32 30
    %_50 = bitcast i8* %_49 to i8**
    %_51 = load i8*, i8** %_50
    %_48 = call i8 %_47(i8* %_41, i8* %_51)
    store i8 %_48, i8* %ntb
    %_52 = load i8*, i8** %p_node
    %_53 = bitcast i8* %_52 to i8**
    %_54 = load i8*, i8** %_53
    %_55 = getelementptr i8, i8* %_54, i32 80
    %_56 = bitcast i8* %_55 to i8**
    %_57 = load i8*, i8** %_56
    %_58 = bitcast i8* %_57 to i8 (i8*, i8)*
    %_59 = call i8 %_58(i8* %_52, i8 0)
    store i8 %_59, i8* %ntb

    ret i8 1
}

define i8 @Tree.RemoveLeft(i8* %this, i8* %.p_node, i8* %.c_node) {
    %p_node = alloca i8*
    store i8* %.p_node, i8** %p_node
    %c_node = alloca i8*
    store i8* %.c_node, i8** %c_node
    %ntb = alloca i8
    store i8 0, i8* %ntb
    br label %label1

label1:
    %_0 = load i8*, i8** %c_node
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 64
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i8 (i8*)*
    %_7 = call i8 %_6(i8* %_0)
    %_8 = trunc i8 %_7 to i1
    br i1 %_8, label %label0, label %label2

label0:
    %_9 = load i8*, i8** %c_node
    %_10 = bitcast i8* %_9 to i8**
    %_11 = load i8*, i8** %_10
    %_12 = getelementptr i8, i8* %_11, i32 48
    %_13 = bitcast i8* %_12 to i8**
    %_14 = load i8*, i8** %_13
    %_15 = bitcast i8* %_14 to i8 (i8*, i32)*
    %_17 = load i8*, i8** %c_node
    %_18 = bitcast i8* %_17 to i8**
    %_19 = load i8*, i8** %_18
    %_20 = getelementptr i8, i8* %_19, i32 32
    %_21 = bitcast i8* %_20 to i8**
    %_22 = load i8*, i8** %_21
    %_23 = bitcast i8* %_22 to i8* (i8*)*
    %_24 = call i8* %_23(i8* %_17)
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = getelementptr i8, i8* %_26, i32 40
    %_28 = bitcast i8* %_27 to i8**
    %_29 = load i8*, i8** %_28
    %_30 = bitcast i8* %_29 to i32 (i8*)*
    %_31 = call i32 %_30(i8* %_24)
    %_16 = call i8 %_15(i8* %_9, i32 %_31)
    store i8 %_16, i8* %ntb
    %_32 = load i8*, i8** %c_node
    store i8* %_32, i8** %p_node
    %_33 = load i8*, i8** %c_node
    %_34 = bitcast i8* %_33 to i8**
    %_35 = load i8*, i8** %_34
    %_36 = getelementptr i8, i8* %_35, i32 32
    %_37 = bitcast i8* %_36 to i8**
    %_38 = load i8*, i8** %_37
    %_39 = bitcast i8* %_38 to i8* (i8*)*
    %_40 = call i8* %_39(i8* %_33)
    store i8* %_40, i8** %c_node
    br label %label1

label2:
    %_41 = load i8*, i8** %p_node
    %_42 = bitcast i8* %_41 to i8**
    %_43 = load i8*, i8** %_42
    %_44 = getelementptr i8, i8* %_43, i32 16
    %_45 = bitcast i8* %_44 to i8**
    %_46 = load i8*, i8** %_45
    %_47 = bitcast i8* %_46 to i8 (i8*, i8*)*
    %_49 = getelementptr i8, i8* %this, i32 30
    %_50 = bitcast i8* %_49 to i8**
    %_51 = load i8*, i8** %_50
    %_48 = call i8 %_47(i8* %_41, i8* %_51)
    store i8 %_48, i8* %ntb
    %_52 = load i8*, i8** %p_node
    %_53 = bitcast i8* %_52 to i8**
    %_54 = load i8*, i8** %_53
    %_55 = getelementptr i8, i8* %_54, i32 72
    %_56 = bitcast i8* %_55 to i8**
    %_57 = load i8*, i8** %_56
    %_58 = bitcast i8* %_57 to i8 (i8*, i8)*
    %_59 = call i8 %_58(i8* %_52, i8 0)
    store i8 %_59, i8* %ntb

    ret i8 1
}

define i32 @Tree.Search(i8* %this, i32 %.v_key) {
    %v_key = alloca i32
    store i32 %.v_key, i32* %v_key
    %cont = alloca i8
    store i8 0, i8* %cont
    %ifound = alloca i32
    store i32 0, i32* %ifound
    %current_node = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 38)
    store i8* %_0, i8** %current_node
    %key_aux = alloca i32
    store i32 0, i32* %key_aux
    store i8* %this, i8** %current_node
    store i8 1, i8* %cont
    store i32 0, i32* %ifound
    br label %label1

label1:
    %_1 = load i8, i8* %cont
    %_2 = trunc i8 %_1 to i1
    br i1 %_2, label %label0, label %label2

label0:
    %_3 = load i8*, i8** %current_node
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = getelementptr i8, i8* %_5, i32 40
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %_7
    %_9 = bitcast i8* %_8 to i32 (i8*)*
    %_10 = call i32 %_9(i8* %_3)
    store i32 %_10, i32* %key_aux
    %_11 = load i32, i32* %v_key
    %_12 = load i32, i32* %key_aux
    %_13 = icmp slt i32 %_11, %_12
    %_14 = zext i1 %_13 to i8
    %_15 = trunc i8 %_14 to i1
    br i1 %_15, label %label3, label %label4

label3:
    %_16 = load i8*, i8** %current_node
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = getelementptr i8, i8* %_18, i32 64
    %_20 = bitcast i8* %_19 to i8**
    %_21 = load i8*, i8** %_20
    %_22 = bitcast i8* %_21 to i8 (i8*)*
    %_23 = call i8 %_22(i8* %_16)
    %_24 = trunc i8 %_23 to i1
    br i1 %_24, label %label6, label %label7

label6:
    %_25 = load i8*, i8** %current_node
    %_26 = bitcast i8* %_25 to i8**
    %_27 = load i8*, i8** %_26
    %_28 = getelementptr i8, i8* %_27, i32 32
    %_29 = bitcast i8* %_28 to i8**
    %_30 = load i8*, i8** %_29
    %_31 = bitcast i8* %_30 to i8* (i8*)*
    %_32 = call i8* %_31(i8* %_25)
    store i8* %_32, i8** %current_node
    br label %label8

label7:
    store i8 0, i8* %cont
    br label %label8

label8:
    br label %label5

label4:
    %_33 = load i32, i32* %key_aux
    %_34 = load i32, i32* %v_key
    %_35 = icmp slt i32 %_33, %_34
    %_36 = zext i1 %_35 to i8
    %_37 = trunc i8 %_36 to i1
    br i1 %_37, label %label9, label %label10

label9:
    %_38 = load i8*, i8** %current_node
    %_39 = bitcast i8* %_38 to i8**
    %_40 = load i8*, i8** %_39
    %_41 = getelementptr i8, i8* %_40, i32 56
    %_42 = bitcast i8* %_41 to i8**
    %_43 = load i8*, i8** %_42
    %_44 = bitcast i8* %_43 to i8 (i8*)*
    %_45 = call i8 %_44(i8* %_38)
    %_46 = trunc i8 %_45 to i1
    br i1 %_46, label %label12, label %label13

label12:
    %_47 = load i8*, i8** %current_node
    %_48 = bitcast i8* %_47 to i8**
    %_49 = load i8*, i8** %_48
    %_50 = getelementptr i8, i8* %_49, i32 24
    %_51 = bitcast i8* %_50 to i8**
    %_52 = load i8*, i8** %_51
    %_53 = bitcast i8* %_52 to i8* (i8*)*
    %_54 = call i8* %_53(i8* %_47)
    store i8* %_54, i8** %current_node
    br label %label14

label13:
    store i8 0, i8* %cont
    br label %label14

label14:
    br label %label11

label10:
    store i32 1, i32* %ifound
    store i8 0, i8* %cont
    br label %label11

label11:
    br label %label5

label5:
    br label %label1

label2:
    %_55 = load i32, i32* %ifound

    ret i32 %_55
}

define i8 @Tree.Print(i8* %this) {
    %current_node = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 38)
    store i8* %_0, i8** %current_node
    %ntb = alloca i8
    store i8 0, i8* %ntb
    store i8* %this, i8** %current_node
    %_1 = bitcast i8* %this to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 152
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i8 (i8*, i8*)*
    %_8 = load i8*, i8** %current_node
    %_7 = call i8 %_6(i8* %this, i8* %_8)
    store i8 %_7, i8* %ntb

    ret i8 1
}

define i8 @Tree.RecPrint(i8* %this, i8* %.node) {
    %node = alloca i8*
    store i8* %.node, i8** %node
    %ntb = alloca i8
    store i8 0, i8* %ntb
    %_0 = load i8*, i8** %node
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 64
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i8 (i8*)*
    %_7 = call i8 %_6(i8* %_0)
    %_8 = trunc i8 %_7 to i1
    br i1 %_8, label %label0, label %label1

label0:
    %_9 = bitcast i8* %this to i8**
    %_10 = load i8*, i8** %_9
    %_11 = getelementptr i8, i8* %_10, i32 152
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = bitcast i8* %_13 to i8 (i8*, i8*)*
    %_16 = load i8*, i8** %node
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = getelementptr i8, i8* %_18, i32 32
    %_20 = bitcast i8* %_19 to i8**
    %_21 = load i8*, i8** %_20
    %_22 = bitcast i8* %_21 to i8* (i8*)*
    %_23 = call i8* %_22(i8* %_16)
    %_15 = call i8 %_14(i8* %this, i8* %_23)
    store i8 %_15, i8* %ntb
    br label %label2

label1:
    store i8 1, i8* %ntb
    br label %label2

label2:
    %_24 = load i8*, i8** %node
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = getelementptr i8, i8* %_26, i32 40
    %_28 = bitcast i8* %_27 to i8**
    %_29 = load i8*, i8** %_28
    %_30 = bitcast i8* %_29 to i32 (i8*)*
    %_31 = call i32 %_30(i8* %_24)
    call void (i32) @print_int(i32 %_31)
    %_32 = load i8*, i8** %node
    %_33 = bitcast i8* %_32 to i8**
    %_34 = load i8*, i8** %_33
    %_35 = getelementptr i8, i8* %_34, i32 56
    %_36 = bitcast i8* %_35 to i8**
    %_37 = load i8*, i8** %_36
    %_38 = bitcast i8* %_37 to i8 (i8*)*
    %_39 = call i8 %_38(i8* %_32)
    %_40 = trunc i8 %_39 to i1
    br i1 %_40, label %label3, label %label4

label3:
    %_41 = bitcast i8* %this to i8**
    %_42 = load i8*, i8** %_41
    %_43 = getelementptr i8, i8* %_42, i32 152
    %_44 = bitcast i8* %_43 to i8**
    %_45 = load i8*, i8** %_44
    %_46 = bitcast i8* %_45 to i8 (i8*, i8*)*
    %_48 = load i8*, i8** %node
    %_49 = bitcast i8* %_48 to i8**
    %_50 = load i8*, i8** %_49
    %_51 = getelementptr i8, i8* %_50, i32 24
    %_52 = bitcast i8* %_51 to i8**
    %_53 = load i8*, i8** %_52
    %_54 = bitcast i8* %_53 to i8* (i8*)*
    %_55 = call i8* %_54(i8* %_48)
    %_47 = call i8 %_46(i8* %this, i8* %_55)
    store i8 %_47, i8* %ntb
    br label %label5

label4:
    store i8 1, i8* %ntb
    br label %label5

label5:

    ret i8 1
}
