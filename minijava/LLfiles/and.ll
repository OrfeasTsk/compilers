@.Alsdfjasdjfl_vtable = global [0 x i8*] []
@.A_vtable = global [3 x i8*] [i8* bitcast (i8 (i8*,i8,i8,i8)* @A.foo to i8*), i8* bitcast (i8 (i8*,i8,i8)* @A.bar to i8*), i8* bitcast (i8 (i8*,i8)* @A.print to i8*)]
@.B_vtable = global [2 x i8*] [i8* bitcast (i8 (i8*,i32)* @B.foo to i8*), i8* bitcast (i8 (i8*,i32,i32,i8,i8)* @B.t to i8*)]


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
    %_1 = call i8* @calloc(i32 1, i32 8)
    %_2 = bitcast i8* %_1 to i8**
    %_3 = getelementptr [3 x i8*], [3 x i8*]* @.A_vtable, i32 0, i32 0
    %_4 = bitcast i8** %_3 to i8*
    store i8* %_4, i8** %_2
    store i8* %_1, i8** %a
    %_5 = load i8*, i8** %a
    %_6 = bitcast i8* %_5 to i8**
    %_7 = load i8*, i8** %_6
    %_8 = getelementptr i8, i8* %_7, i32 16
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    %_11 = bitcast i8* %_10 to i8 (i8*, i8)*
    %_13 = load i8*, i8** %a
    %_14 = bitcast i8* %_13 to i8**
    %_15 = load i8*, i8** %_14
    %_16 = getelementptr i8, i8* %_15, i32 0
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = bitcast i8* %_18 to i8 (i8*, i8, i8, i8)*
    %_20 = call i8 %_19(i8* %_13, i8 0, i8 0, i8 0)
    %_12 = call i8 %_11(i8* %_5, i8 %_20)
    store i8 %_12, i8* %dummy
    %_21 = load i8*, i8** %a
    %_22 = bitcast i8* %_21 to i8**
    %_23 = load i8*, i8** %_22
    %_24 = getelementptr i8, i8* %_23, i32 16
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = bitcast i8* %_26 to i8 (i8*, i8)*
    %_29 = load i8*, i8** %a
    %_30 = bitcast i8* %_29 to i8**
    %_31 = load i8*, i8** %_30
    %_32 = getelementptr i8, i8* %_31, i32 0
    %_33 = bitcast i8* %_32 to i8**
    %_34 = load i8*, i8** %_33
    %_35 = bitcast i8* %_34 to i8 (i8*, i8, i8, i8)*
    %_36 = call i8 %_35(i8* %_29, i8 0, i8 0, i8 1)
    %_28 = call i8 %_27(i8* %_21, i8 %_36)
    store i8 %_28, i8* %dummy
    %_37 = load i8*, i8** %a
    %_38 = bitcast i8* %_37 to i8**
    %_39 = load i8*, i8** %_38
    %_40 = getelementptr i8, i8* %_39, i32 16
    %_41 = bitcast i8* %_40 to i8**
    %_42 = load i8*, i8** %_41
    %_43 = bitcast i8* %_42 to i8 (i8*, i8)*
    %_45 = load i8*, i8** %a
    %_46 = bitcast i8* %_45 to i8**
    %_47 = load i8*, i8** %_46
    %_48 = getelementptr i8, i8* %_47, i32 0
    %_49 = bitcast i8* %_48 to i8**
    %_50 = load i8*, i8** %_49
    %_51 = bitcast i8* %_50 to i8 (i8*, i8, i8, i8)*
    %_52 = call i8 %_51(i8* %_45, i8 0, i8 1, i8 0)
    %_44 = call i8 %_43(i8* %_37, i8 %_52)
    store i8 %_44, i8* %dummy
    %_53 = load i8*, i8** %a
    %_54 = bitcast i8* %_53 to i8**
    %_55 = load i8*, i8** %_54
    %_56 = getelementptr i8, i8* %_55, i32 16
    %_57 = bitcast i8* %_56 to i8**
    %_58 = load i8*, i8** %_57
    %_59 = bitcast i8* %_58 to i8 (i8*, i8)*
    %_61 = load i8*, i8** %a
    %_62 = bitcast i8* %_61 to i8**
    %_63 = load i8*, i8** %_62
    %_64 = getelementptr i8, i8* %_63, i32 0
    %_65 = bitcast i8* %_64 to i8**
    %_66 = load i8*, i8** %_65
    %_67 = bitcast i8* %_66 to i8 (i8*, i8, i8, i8)*
    %_68 = call i8 %_67(i8* %_61, i8 0, i8 1, i8 1)
    %_60 = call i8 %_59(i8* %_53, i8 %_68)
    store i8 %_60, i8* %dummy
    %_69 = load i8*, i8** %a
    %_70 = bitcast i8* %_69 to i8**
    %_71 = load i8*, i8** %_70
    %_72 = getelementptr i8, i8* %_71, i32 16
    %_73 = bitcast i8* %_72 to i8**
    %_74 = load i8*, i8** %_73
    %_75 = bitcast i8* %_74 to i8 (i8*, i8)*
    %_77 = load i8*, i8** %a
    %_78 = bitcast i8* %_77 to i8**
    %_79 = load i8*, i8** %_78
    %_80 = getelementptr i8, i8* %_79, i32 0
    %_81 = bitcast i8* %_80 to i8**
    %_82 = load i8*, i8** %_81
    %_83 = bitcast i8* %_82 to i8 (i8*, i8, i8, i8)*
    %_84 = call i8 %_83(i8* %_77, i8 1, i8 0, i8 0)
    %_76 = call i8 %_75(i8* %_69, i8 %_84)
    store i8 %_76, i8* %dummy
    %_85 = load i8*, i8** %a
    %_86 = bitcast i8* %_85 to i8**
    %_87 = load i8*, i8** %_86
    %_88 = getelementptr i8, i8* %_87, i32 16
    %_89 = bitcast i8* %_88 to i8**
    %_90 = load i8*, i8** %_89
    %_91 = bitcast i8* %_90 to i8 (i8*, i8)*
    %_93 = load i8*, i8** %a
    %_94 = bitcast i8* %_93 to i8**
    %_95 = load i8*, i8** %_94
    %_96 = getelementptr i8, i8* %_95, i32 0
    %_97 = bitcast i8* %_96 to i8**
    %_98 = load i8*, i8** %_97
    %_99 = bitcast i8* %_98 to i8 (i8*, i8, i8, i8)*
    %_100 = call i8 %_99(i8* %_93, i8 1, i8 0, i8 1)
    %_92 = call i8 %_91(i8* %_85, i8 %_100)
    store i8 %_92, i8* %dummy
    %_101 = load i8*, i8** %a
    %_102 = bitcast i8* %_101 to i8**
    %_103 = load i8*, i8** %_102
    %_104 = getelementptr i8, i8* %_103, i32 16
    %_105 = bitcast i8* %_104 to i8**
    %_106 = load i8*, i8** %_105
    %_107 = bitcast i8* %_106 to i8 (i8*, i8)*
    %_109 = load i8*, i8** %a
    %_110 = bitcast i8* %_109 to i8**
    %_111 = load i8*, i8** %_110
    %_112 = getelementptr i8, i8* %_111, i32 0
    %_113 = bitcast i8* %_112 to i8**
    %_114 = load i8*, i8** %_113
    %_115 = bitcast i8* %_114 to i8 (i8*, i8, i8, i8)*
    %_116 = call i8 %_115(i8* %_109, i8 1, i8 1, i8 0)
    %_108 = call i8 %_107(i8* %_101, i8 %_116)
    store i8 %_108, i8* %dummy
    %_117 = load i8*, i8** %a
    %_118 = bitcast i8* %_117 to i8**
    %_119 = load i8*, i8** %_118
    %_120 = getelementptr i8, i8* %_119, i32 16
    %_121 = bitcast i8* %_120 to i8**
    %_122 = load i8*, i8** %_121
    %_123 = bitcast i8* %_122 to i8 (i8*, i8)*
    %_125 = load i8*, i8** %a
    %_126 = bitcast i8* %_125 to i8**
    %_127 = load i8*, i8** %_126
    %_128 = getelementptr i8, i8* %_127, i32 0
    %_129 = bitcast i8* %_128 to i8**
    %_130 = load i8*, i8** %_129
    %_131 = bitcast i8* %_130 to i8 (i8*, i8, i8, i8)*
    %_132 = call i8 %_131(i8* %_125, i8 1, i8 1, i8 1)
    %_124 = call i8 %_123(i8* %_117, i8 %_132)
    store i8 %_124, i8* %dummy
    %_133 = load i8*, i8** %a
    %_134 = bitcast i8* %_133 to i8**
    %_135 = load i8*, i8** %_134
    %_136 = getelementptr i8, i8* %_135, i32 16
    %_137 = bitcast i8* %_136 to i8**
    %_138 = load i8*, i8** %_137
    %_139 = bitcast i8* %_138 to i8 (i8*, i8)*
    %_141 = load i8*, i8** %a
    %_142 = bitcast i8* %_141 to i8**
    %_143 = load i8*, i8** %_142
    %_144 = getelementptr i8, i8* %_143, i32 8
    %_145 = bitcast i8* %_144 to i8**
    %_146 = load i8*, i8** %_145
    %_147 = bitcast i8* %_146 to i8 (i8*, i8, i8)*
    %_148 = call i8 %_147(i8* %_141, i8 1, i8 1)
    %_140 = call i8 %_139(i8* %_133, i8 %_148)
    store i8 %_140, i8* %dummy
    %_149 = load i8*, i8** %a
    %_150 = bitcast i8* %_149 to i8**
    %_151 = load i8*, i8** %_150
    %_152 = getelementptr i8, i8* %_151, i32 16
    %_153 = bitcast i8* %_152 to i8**
    %_154 = load i8*, i8** %_153
    %_155 = bitcast i8* %_154 to i8 (i8*, i8)*
    %_157 = load i8*, i8** %a
    %_158 = bitcast i8* %_157 to i8**
    %_159 = load i8*, i8** %_158
    %_160 = getelementptr i8, i8* %_159, i32 8
    %_161 = bitcast i8* %_160 to i8**
    %_162 = load i8*, i8** %_161
    %_163 = bitcast i8* %_162 to i8 (i8*, i8, i8)*
    %_164 = call i8 %_163(i8* %_157, i8 0, i8 1)
    %_156 = call i8 %_155(i8* %_149, i8 %_164)
    store i8 %_156, i8* %dummy
    %_165 = load i8*, i8** %a
    %_166 = bitcast i8* %_165 to i8**
    %_167 = load i8*, i8** %_166
    %_168 = getelementptr i8, i8* %_167, i32 16
    %_169 = bitcast i8* %_168 to i8**
    %_170 = load i8*, i8** %_169
    %_171 = bitcast i8* %_170 to i8 (i8*, i8)*
    %_173 = call i8* @calloc(i32 1, i32 8)
    %_174 = bitcast i8* %_173 to i8**
    %_175 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
    %_176 = bitcast i8** %_175 to i8*
    store i8* %_176, i8** %_174
    %_177 = bitcast i8* %_173 to i8**
    %_178 = load i8*, i8** %_177
    %_179 = getelementptr i8, i8* %_178, i32 0
    %_180 = bitcast i8* %_179 to i8**
    %_181 = load i8*, i8** %_180
    %_182 = bitcast i8* %_181 to i8 (i8*, i32)*
    %_183 = call i8 %_182(i8* %_173, i32 1)
    %_172 = call i8 %_171(i8* %_165, i8 %_183)
    store i8 %_172, i8* %dummy
    %_184 = load i8*, i8** %a
    %_185 = bitcast i8* %_184 to i8**
    %_186 = load i8*, i8** %_185
    %_187 = getelementptr i8, i8* %_186, i32 16
    %_188 = bitcast i8* %_187 to i8**
    %_189 = load i8*, i8** %_188
    %_190 = bitcast i8* %_189 to i8 (i8*, i8)*
    %_192 = call i8* @calloc(i32 1, i32 8)
    %_193 = bitcast i8* %_192 to i8**
    %_194 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
    %_195 = bitcast i8** %_194 to i8*
    store i8* %_195, i8** %_193
    %_196 = bitcast i8* %_192 to i8**
    %_197 = load i8*, i8** %_196
    %_198 = getelementptr i8, i8* %_197, i32 0
    %_199 = bitcast i8* %_198 to i8**
    %_200 = load i8*, i8** %_199
    %_201 = bitcast i8* %_200 to i8 (i8*, i32)*
    %_202 = call i8 %_201(i8* %_192, i32 2)
    %_191 = call i8 %_190(i8* %_184, i8 %_202)
    store i8 %_191, i8* %dummy
    %_203 = load i8*, i8** %a
    %_204 = bitcast i8* %_203 to i8**
    %_205 = load i8*, i8** %_204
    %_206 = getelementptr i8, i8* %_205, i32 16
    %_207 = bitcast i8* %_206 to i8**
    %_208 = load i8*, i8** %_207
    %_209 = bitcast i8* %_208 to i8 (i8*, i8)*
    %_211 = call i8* @calloc(i32 1, i32 8)
    %_212 = bitcast i8* %_211 to i8**
    %_213 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
    %_214 = bitcast i8** %_213 to i8*
    store i8* %_214, i8** %_212
    %_215 = bitcast i8* %_211 to i8**
    %_216 = load i8*, i8** %_215
    %_217 = getelementptr i8, i8* %_216, i32 8
    %_218 = bitcast i8* %_217 to i8**
    %_219 = load i8*, i8** %_218
    %_220 = bitcast i8* %_219 to i8 (i8*, i32, i32, i8, i8)*
    %_221 = call i8 %_220(i8* %_211, i32 2, i32 2, i8 1, i8 1)
    %_210 = call i8 %_209(i8* %_203, i8 %_221)
    store i8 %_210, i8* %dummy


    ret i32 0
}

define i8 @A.foo(i8* %this, i8 %.a, i8 %.b, i8 %.c) {
    %a = alloca i8
    store i8 %.a, i8* %a
    %b = alloca i8
    store i8 %.b, i8* %b
    %c = alloca i8
    store i8 %.c, i8* %c
    %_0 = load i8, i8* %a
    %_1 = trunc i8 %_0 to i1
    br i1 %_1, label %label4, label %label5

label4:
    %_2 = load i8, i8* %b
    br label %label6

label6:
    br label %label7

label5:
    br label %label7

label7:
    %_3 = phi i8 [%_2, %label6], [%_0, %label5]
    %_4 = trunc i8 %_3 to i1
    br i1 %_4, label %label0, label %label1

label0:
    %_5 = load i8, i8* %c
    br label %label2

label2:
    br label %label3

label1:
    br label %label3

label3:
    %_6 = phi i8 [%_5, %label2], [%_3, %label1]

    ret i8 %_6
}

define i8 @A.bar(i8* %this, i8 %.a, i8 %.b) {
    %a = alloca i8
    store i8 %.a, i8* %a
    %b = alloca i8
    store i8 %.b, i8* %b
    %_0 = load i8, i8* %a
    %_1 = trunc i8 %_0 to i1
    br i1 %_1, label %label4, label %label5

label4:
    %_2 = bitcast i8* %this to i8**
    %_3 = load i8*, i8** %_2
    %_4 = getelementptr i8, i8* %_3, i32 0
    %_5 = bitcast i8* %_4 to i8**
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i8 (i8*, i8, i8, i8)*
    %_9 = load i8, i8* %a
    %_10 = load i8, i8* %b
    %_8 = call i8 %_7(i8* %this, i8 %_9, i8 %_10, i8 1)
    br label %label6

label6:
    br label %label7

label5:
    br label %label7

label7:
    %_11 = phi i8 [%_8, %label6], [%_0, %label5]
    %_12 = trunc i8 %_11 to i1
    br i1 %_12, label %label0, label %label1

label0:
    %_13 = load i8, i8* %b
    br label %label2

label2:
    br label %label3

label1:
    br label %label3

label3:
    %_14 = phi i8 [%_13, %label2], [%_11, %label1]

    ret i8 %_14
}

define i8 @A.print(i8* %this, i8 %.res) {
    %res = alloca i8
    store i8 %.res, i8* %res
    %_0 = load i8, i8* %res
    %_1 = trunc i8 %_0 to i1
    br i1 %_1, label %label0, label %label1

label0:
    call void (i32) @print_int(i32 1)
    br label %label2

label1:
    call void (i32) @print_int(i32 0)
    br label %label2

label2:

    ret i8 1
}

define i8 @B.foo(i8* %this, i32 %.a) {
    %a = alloca i32
    store i32 %.a, i32* %a
    %_0 = load i32, i32* %a
    %_1 = add i32 %_0, 2
    %_2 = icmp slt i32 3, %_1
    %_3 = zext i1 %_2 to i8
    %_4 = xor i8 %_3, 1
    %_5 = trunc i8 %_4 to i1
    br i1 %_5, label %label0, label %label1

label0:
    %_6 = xor i8 0, 1
    br label %label2

label2:
    br label %label3

label1:
    br label %label3

label3:
    %_7 = phi i8 [%_6, %label2], [%_4, %label1]

    ret i8 %_7
}

define i8 @B.t(i8* %this, i32 %.a, i32 %.b, i8 %.c, i8 %.d) {
    %a = alloca i32
    store i32 %.a, i32* %a
    %b = alloca i32
    store i32 %.b, i32* %b
    %c = alloca i8
    store i8 %.c, i8* %c
    %d = alloca i8
    store i8 %.d, i8* %d
    %_0 = load i32, i32* %a
    %_1 = load i32, i32* %b
    %_2 = icmp slt i32 %_0, %_1
    %_3 = zext i1 %_2 to i8
    %_4 = xor i8 %_3, 1
    %_5 = trunc i8 %_4 to i1
    br i1 %_5, label %label0, label %label1

label0:
    %_6 = load i8, i8* %c
    %_7 = trunc i8 %_6 to i1
    br i1 %_7, label %label4, label %label5

label4:
    %_8 = load i8, i8* %d
    br label %label6

label6:
    br label %label7

label5:
    br label %label7

label7:
    %_9 = phi i8 [%_8, %label6], [%_6, %label5]
    br label %label2

label2:
    br label %label3

label1:
    br label %label3

label3:
    %_10 = phi i8 [%_9, %label2], [%_4, %label1]

    ret i8 %_10
}
