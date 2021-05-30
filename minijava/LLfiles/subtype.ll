@.Main_vtable = global [0 x i8*] []
@.Receiver_vtable = global [8 x i8*] [i8* bitcast (i8 (i8*,i8*)* @Receiver.A to i8*), i8* bitcast (i8 (i8*,i8*)* @Receiver.B to i8*), i8* bitcast (i8 (i8*,i8*)* @Receiver.C to i8*), i8* bitcast (i8 (i8*,i8*)* @Receiver.D to i8*), i8* bitcast (i8* (i8*)* @Receiver.alloc_B_for_A to i8*), i8* bitcast (i8* (i8*)* @Receiver.alloc_C_for_A to i8*), i8* bitcast (i8* (i8*)* @Receiver.alloc_D_for_A to i8*), i8* bitcast (i8* (i8*)* @Receiver.alloc_D_for_B to i8*)]
@.A_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*)* @A.foo to i8*), i8* bitcast (i32 (i8*)* @A.bar to i8*), i8* bitcast (i32 (i8*)* @A.test to i8*)]
@.B_vtable = global [5 x i8*] [i8* bitcast (i32 (i8*)* @A.foo to i8*), i8* bitcast (i32 (i8*)* @B.bar to i8*), i8* bitcast (i32 (i8*)* @A.test to i8*), i8* bitcast (i32 (i8*)* @B.not_overriden to i8*), i8* bitcast (i32 (i8*)* @B.another to i8*)]
@.C_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*)* @A.foo to i8*), i8* bitcast (i32 (i8*)* @C.bar to i8*), i8* bitcast (i32 (i8*)* @A.test to i8*)]
@.D_vtable = global [6 x i8*] [i8* bitcast (i32 (i8*)* @A.foo to i8*), i8* bitcast (i32 (i8*)* @D.bar to i8*), i8* bitcast (i32 (i8*)* @A.test to i8*), i8* bitcast (i32 (i8*)* @B.not_overriden to i8*), i8* bitcast (i32 (i8*)* @D.another to i8*), i8* bitcast (i32 (i8*)* @D.stef to i8*)]


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
    %dummy = alloca i8
    store i8 0, i8* %dummy
    %a = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 8)
    store i8* %_0, i8** %a
    %b = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 8)
    store i8* %_1, i8** %b
    %c = alloca i8*
    %_2 = call i8* @calloc(i32 0, i32 8)
    store i8* %_2, i8** %c
    %d = alloca i8*
    %_3 = call i8* @calloc(i32 0, i32 8)
    store i8* %_3, i8** %d
    %separator = alloca i32
    store i32 0, i32* %separator
    %cls_separator = alloca i32
    store i32 0, i32* %cls_separator
    store i32 1111111111, i32* %separator
    store i32 333333333, i32* %cls_separator
    %_4 = call i8* @calloc(i32 1, i32 8)
    %_5 = bitcast i8* %_4 to i8**
    %_6 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
    %_7 = bitcast i8** %_6 to i8*
    store i8* %_7, i8** %_5
    %_8 = bitcast i8* %_4 to i8**
    %_9 = load i8*, i8** %_8
    %_10 = getelementptr i8, i8* %_9, i32 0
    %_11 = bitcast i8* %_10 to i8**
    %_12 = load i8*, i8** %_11
    %_13 = bitcast i8* %_12 to i8 (i8*, i8*)*
    %_15 = call i8* @calloc(i32 1, i32 8)
    %_16 = bitcast i8* %_15 to i8**
    %_17 = getelementptr [3 x i8*], [3 x i8*]* @.A_vtable, i32 0, i32 0
    %_18 = bitcast i8** %_17 to i8*
    store i8* %_18, i8** %_16
    %_14 = call i8 %_13(i8* %_4, i8* %_15)
    store i8 %_14, i8* %dummy
    %_19 = load i32, i32* %separator
    call void (i32) @print_int(i32 %_19)
    %_20 = call i8* @calloc(i32 1, i32 8)
    %_21 = bitcast i8* %_20 to i8**
    %_22 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
    %_23 = bitcast i8** %_22 to i8*
    store i8* %_23, i8** %_21
    %_24 = bitcast i8* %_20 to i8**
    %_25 = load i8*, i8** %_24
    %_26 = getelementptr i8, i8* %_25, i32 0
    %_27 = bitcast i8* %_26 to i8**
    %_28 = load i8*, i8** %_27
    %_29 = bitcast i8* %_28 to i8 (i8*, i8*)*
    %_31 = call i8* @calloc(i32 1, i32 8)
    %_32 = bitcast i8* %_31 to i8**
    %_33 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
    %_34 = bitcast i8** %_33 to i8*
    store i8* %_34, i8** %_32
    %_35 = bitcast i8* %_31 to i8**
    %_36 = load i8*, i8** %_35
    %_37 = getelementptr i8, i8* %_36, i32 32
    %_38 = bitcast i8* %_37 to i8**
    %_39 = load i8*, i8** %_38
    %_40 = bitcast i8* %_39 to i8* (i8*)*
    %_41 = call i8* %_40(i8* %_31)
    %_30 = call i8 %_29(i8* %_20, i8* %_41)
    store i8 %_30, i8* %dummy
    %_42 = load i32, i32* %separator
    call void (i32) @print_int(i32 %_42)
    %_43 = call i8* @calloc(i32 1, i32 8)
    %_44 = bitcast i8* %_43 to i8**
    %_45 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
    %_46 = bitcast i8** %_45 to i8*
    store i8* %_46, i8** %_44
    %_47 = bitcast i8* %_43 to i8**
    %_48 = load i8*, i8** %_47
    %_49 = getelementptr i8, i8* %_48, i32 0
    %_50 = bitcast i8* %_49 to i8**
    %_51 = load i8*, i8** %_50
    %_52 = bitcast i8* %_51 to i8 (i8*, i8*)*
    %_54 = call i8* @calloc(i32 1, i32 8)
    %_55 = bitcast i8* %_54 to i8**
    %_56 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
    %_57 = bitcast i8** %_56 to i8*
    store i8* %_57, i8** %_55
    %_58 = bitcast i8* %_54 to i8**
    %_59 = load i8*, i8** %_58
    %_60 = getelementptr i8, i8* %_59, i32 40
    %_61 = bitcast i8* %_60 to i8**
    %_62 = load i8*, i8** %_61
    %_63 = bitcast i8* %_62 to i8* (i8*)*
    %_64 = call i8* %_63(i8* %_54)
    %_53 = call i8 %_52(i8* %_43, i8* %_64)
    store i8 %_53, i8* %dummy
    %_65 = load i32, i32* %separator
    call void (i32) @print_int(i32 %_65)
    %_66 = call i8* @calloc(i32 1, i32 8)
    %_67 = bitcast i8* %_66 to i8**
    %_68 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
    %_69 = bitcast i8** %_68 to i8*
    store i8* %_69, i8** %_67
    %_70 = bitcast i8* %_66 to i8**
    %_71 = load i8*, i8** %_70
    %_72 = getelementptr i8, i8* %_71, i32 0
    %_73 = bitcast i8* %_72 to i8**
    %_74 = load i8*, i8** %_73
    %_75 = bitcast i8* %_74 to i8 (i8*, i8*)*
    %_77 = call i8* @calloc(i32 1, i32 8)
    %_78 = bitcast i8* %_77 to i8**
    %_79 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
    %_80 = bitcast i8** %_79 to i8*
    store i8* %_80, i8** %_78
    %_81 = bitcast i8* %_77 to i8**
    %_82 = load i8*, i8** %_81
    %_83 = getelementptr i8, i8* %_82, i32 48
    %_84 = bitcast i8* %_83 to i8**
    %_85 = load i8*, i8** %_84
    %_86 = bitcast i8* %_85 to i8* (i8*)*
    %_87 = call i8* %_86(i8* %_77)
    %_76 = call i8 %_75(i8* %_66, i8* %_87)
    store i8 %_76, i8* %dummy
    %_88 = load i32, i32* %cls_separator
    call void (i32) @print_int(i32 %_88)
    %_89 = call i8* @calloc(i32 1, i32 8)
    %_90 = bitcast i8* %_89 to i8**
    %_91 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
    %_92 = bitcast i8** %_91 to i8*
    store i8* %_92, i8** %_90
    %_93 = bitcast i8* %_89 to i8**
    %_94 = load i8*, i8** %_93
    %_95 = getelementptr i8, i8* %_94, i32 8
    %_96 = bitcast i8* %_95 to i8**
    %_97 = load i8*, i8** %_96
    %_98 = bitcast i8* %_97 to i8 (i8*, i8*)*
    %_100 = call i8* @calloc(i32 1, i32 8)
    %_101 = bitcast i8* %_100 to i8**
    %_102 = getelementptr [5 x i8*], [5 x i8*]* @.B_vtable, i32 0, i32 0
    %_103 = bitcast i8** %_102 to i8*
    store i8* %_103, i8** %_101
    %_99 = call i8 %_98(i8* %_89, i8* %_100)
    store i8 %_99, i8* %dummy
    %_104 = load i32, i32* %separator
    call void (i32) @print_int(i32 %_104)
    %_105 = call i8* @calloc(i32 1, i32 8)
    %_106 = bitcast i8* %_105 to i8**
    %_107 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
    %_108 = bitcast i8** %_107 to i8*
    store i8* %_108, i8** %_106
    %_109 = bitcast i8* %_105 to i8**
    %_110 = load i8*, i8** %_109
    %_111 = getelementptr i8, i8* %_110, i32 8
    %_112 = bitcast i8* %_111 to i8**
    %_113 = load i8*, i8** %_112
    %_114 = bitcast i8* %_113 to i8 (i8*, i8*)*
    %_116 = call i8* @calloc(i32 1, i32 8)
    %_117 = bitcast i8* %_116 to i8**
    %_118 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
    %_119 = bitcast i8** %_118 to i8*
    store i8* %_119, i8** %_117
    %_120 = bitcast i8* %_116 to i8**
    %_121 = load i8*, i8** %_120
    %_122 = getelementptr i8, i8* %_121, i32 56
    %_123 = bitcast i8* %_122 to i8**
    %_124 = load i8*, i8** %_123
    %_125 = bitcast i8* %_124 to i8* (i8*)*
    %_126 = call i8* %_125(i8* %_116)
    %_115 = call i8 %_114(i8* %_105, i8* %_126)
    store i8 %_115, i8* %dummy
    %_127 = load i32, i32* %cls_separator
    call void (i32) @print_int(i32 %_127)
    %_128 = call i8* @calloc(i32 1, i32 8)
    %_129 = bitcast i8* %_128 to i8**
    %_130 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
    %_131 = bitcast i8** %_130 to i8*
    store i8* %_131, i8** %_129
    %_132 = bitcast i8* %_128 to i8**
    %_133 = load i8*, i8** %_132
    %_134 = getelementptr i8, i8* %_133, i32 16
    %_135 = bitcast i8* %_134 to i8**
    %_136 = load i8*, i8** %_135
    %_137 = bitcast i8* %_136 to i8 (i8*, i8*)*
    %_139 = call i8* @calloc(i32 1, i32 8)
    %_140 = bitcast i8* %_139 to i8**
    %_141 = getelementptr [3 x i8*], [3 x i8*]* @.C_vtable, i32 0, i32 0
    %_142 = bitcast i8** %_141 to i8*
    store i8* %_142, i8** %_140
    %_138 = call i8 %_137(i8* %_128, i8* %_139)
    store i8 %_138, i8* %dummy
    %_143 = load i32, i32* %cls_separator
    call void (i32) @print_int(i32 %_143)
    %_144 = call i8* @calloc(i32 1, i32 8)
    %_145 = bitcast i8* %_144 to i8**
    %_146 = getelementptr [8 x i8*], [8 x i8*]* @.Receiver_vtable, i32 0, i32 0
    %_147 = bitcast i8** %_146 to i8*
    store i8* %_147, i8** %_145
    %_148 = bitcast i8* %_144 to i8**
    %_149 = load i8*, i8** %_148
    %_150 = getelementptr i8, i8* %_149, i32 24
    %_151 = bitcast i8* %_150 to i8**
    %_152 = load i8*, i8** %_151
    %_153 = bitcast i8* %_152 to i8 (i8*, i8*)*
    %_155 = call i8* @calloc(i32 1, i32 8)
    %_156 = bitcast i8* %_155 to i8**
    %_157 = getelementptr [6 x i8*], [6 x i8*]* @.D_vtable, i32 0, i32 0
    %_158 = bitcast i8** %_157 to i8*
    store i8* %_158, i8** %_156
    %_154 = call i8 %_153(i8* %_144, i8* %_155)
    store i8 %_154, i8* %dummy


    ret i32 0
}

define i8 @Receiver.A(i8* %this, i8* %.a) {
    %a = alloca i8*
    store i8* %.a, i8** %a
    %_0 = load i8*, i8** %a
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 0
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i32 (i8*)*
    %_7 = call i32 %_6(i8* %_0)
    call void (i32) @print_int(i32 %_7)
    %_8 = load i8*, i8** %a
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    %_11 = getelementptr i8, i8* %_10, i32 8
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = bitcast i8* %_13 to i32 (i8*)*
    %_15 = call i32 %_14(i8* %_8)
    call void (i32) @print_int(i32 %_15)
    %_16 = load i8*, i8** %a
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = getelementptr i8, i8* %_18, i32 16
    %_20 = bitcast i8* %_19 to i8**
    %_21 = load i8*, i8** %_20
    %_22 = bitcast i8* %_21 to i32 (i8*)*
    %_23 = call i32 %_22(i8* %_16)
    call void (i32) @print_int(i32 %_23)

    ret i8 1
}

define i8 @Receiver.B(i8* %this, i8* %.b) {
    %b = alloca i8*
    store i8* %.b, i8** %b
    %_0 = load i8*, i8** %b
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 0
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i32 (i8*)*
    %_7 = call i32 %_6(i8* %_0)
    call void (i32) @print_int(i32 %_7)
    %_8 = load i8*, i8** %b
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    %_11 = getelementptr i8, i8* %_10, i32 8
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = bitcast i8* %_13 to i32 (i8*)*
    %_15 = call i32 %_14(i8* %_8)
    call void (i32) @print_int(i32 %_15)
    %_16 = load i8*, i8** %b
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = getelementptr i8, i8* %_18, i32 16
    %_20 = bitcast i8* %_19 to i8**
    %_21 = load i8*, i8** %_20
    %_22 = bitcast i8* %_21 to i32 (i8*)*
    %_23 = call i32 %_22(i8* %_16)
    call void (i32) @print_int(i32 %_23)
    %_24 = load i8*, i8** %b
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = getelementptr i8, i8* %_26, i32 24
    %_28 = bitcast i8* %_27 to i8**
    %_29 = load i8*, i8** %_28
    %_30 = bitcast i8* %_29 to i32 (i8*)*
    %_31 = call i32 %_30(i8* %_24)
    call void (i32) @print_int(i32 %_31)
    %_32 = load i8*, i8** %b
    %_33 = bitcast i8* %_32 to i8**
    %_34 = load i8*, i8** %_33
    %_35 = getelementptr i8, i8* %_34, i32 32
    %_36 = bitcast i8* %_35 to i8**
    %_37 = load i8*, i8** %_36
    %_38 = bitcast i8* %_37 to i32 (i8*)*
    %_39 = call i32 %_38(i8* %_32)
    call void (i32) @print_int(i32 %_39)

    ret i8 1
}

define i8 @Receiver.C(i8* %this, i8* %.c) {
    %c = alloca i8*
    store i8* %.c, i8** %c
    %_0 = load i8*, i8** %c
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 0
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i32 (i8*)*
    %_7 = call i32 %_6(i8* %_0)
    call void (i32) @print_int(i32 %_7)
    %_8 = load i8*, i8** %c
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    %_11 = getelementptr i8, i8* %_10, i32 8
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = bitcast i8* %_13 to i32 (i8*)*
    %_15 = call i32 %_14(i8* %_8)
    call void (i32) @print_int(i32 %_15)
    %_16 = load i8*, i8** %c
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = getelementptr i8, i8* %_18, i32 16
    %_20 = bitcast i8* %_19 to i8**
    %_21 = load i8*, i8** %_20
    %_22 = bitcast i8* %_21 to i32 (i8*)*
    %_23 = call i32 %_22(i8* %_16)
    call void (i32) @print_int(i32 %_23)

    ret i8 1
}

define i8 @Receiver.D(i8* %this, i8* %.d) {
    %d = alloca i8*
    store i8* %.d, i8** %d
    %_0 = load i8*, i8** %d
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 0
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i32 (i8*)*
    %_7 = call i32 %_6(i8* %_0)
    call void (i32) @print_int(i32 %_7)
    %_8 = load i8*, i8** %d
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    %_11 = getelementptr i8, i8* %_10, i32 8
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = bitcast i8* %_13 to i32 (i8*)*
    %_15 = call i32 %_14(i8* %_8)
    call void (i32) @print_int(i32 %_15)
    %_16 = load i8*, i8** %d
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = getelementptr i8, i8* %_18, i32 16
    %_20 = bitcast i8* %_19 to i8**
    %_21 = load i8*, i8** %_20
    %_22 = bitcast i8* %_21 to i32 (i8*)*
    %_23 = call i32 %_22(i8* %_16)
    call void (i32) @print_int(i32 %_23)
    %_24 = load i8*, i8** %d
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = getelementptr i8, i8* %_26, i32 24
    %_28 = bitcast i8* %_27 to i8**
    %_29 = load i8*, i8** %_28
    %_30 = bitcast i8* %_29 to i32 (i8*)*
    %_31 = call i32 %_30(i8* %_24)
    call void (i32) @print_int(i32 %_31)
    %_32 = load i8*, i8** %d
    %_33 = bitcast i8* %_32 to i8**
    %_34 = load i8*, i8** %_33
    %_35 = getelementptr i8, i8* %_34, i32 32
    %_36 = bitcast i8* %_35 to i8**
    %_37 = load i8*, i8** %_36
    %_38 = bitcast i8* %_37 to i32 (i8*)*
    %_39 = call i32 %_38(i8* %_32)
    call void (i32) @print_int(i32 %_39)
    %_40 = load i8*, i8** %d
    %_41 = bitcast i8* %_40 to i8**
    %_42 = load i8*, i8** %_41
    %_43 = getelementptr i8, i8* %_42, i32 40
    %_44 = bitcast i8* %_43 to i8**
    %_45 = load i8*, i8** %_44
    %_46 = bitcast i8* %_45 to i32 (i8*)*
    %_47 = call i32 %_46(i8* %_40)
    call void (i32) @print_int(i32 %_47)

    ret i8 1
}

define i8* @Receiver.alloc_B_for_A(i8* %this) {
    %_0 = call i8* @calloc(i32 1, i32 8)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [5 x i8*], [5 x i8*]* @.B_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1

    ret i8* %_0
}

define i8* @Receiver.alloc_C_for_A(i8* %this) {
    %_0 = call i8* @calloc(i32 1, i32 8)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [3 x i8*], [3 x i8*]* @.C_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1

    ret i8* %_0
}

define i8* @Receiver.alloc_D_for_A(i8* %this) {
    %_0 = call i8* @calloc(i32 1, i32 8)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [6 x i8*], [6 x i8*]* @.D_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1

    ret i8* %_0
}

define i8* @Receiver.alloc_D_for_B(i8* %this) {
    %_0 = call i8* @calloc(i32 1, i32 8)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [6 x i8*], [6 x i8*]* @.D_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1

    ret i8* %_0
}

define i32 @A.foo(i8* %this) {

    ret i32 1
}

define i32 @A.bar(i8* %this) {

    ret i32 2
}

define i32 @A.test(i8* %this) {

    ret i32 3
}

define i32 @B.bar(i8* %this) {

    ret i32 12
}

define i32 @B.not_overriden(i8* %this) {

    ret i32 14
}

define i32 @B.another(i8* %this) {

    ret i32 15
}

define i32 @C.bar(i8* %this) {

    ret i32 22
}

define i32 @D.bar(i8* %this) {

    ret i32 32
}

define i32 @D.another(i8* %this) {

    ret i32 35
}

define i32 @D.stef(i8* %this) {

    ret i32 36
}
