@.Main_vtable = global [0 x i8*] []
@.A_vtable = global [5 x i8*] [i8* bitcast (i32 (i8*,i32)* @A.func_int to i8*), i8* bitcast (i32* (i8*,i32*)* @A.func_int_array to i8*), i8* bitcast (i8 (i8*,i8)* @A.func_boolean to i8*), i8* bitcast (i32 (i8*,i32)* @A.decrease to i8*), i8* bitcast (i32 (i8*,i32,i32*,i8,i8*)* @A.func to i8*)]
@.B_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*)* @B.Init to i8*), i8* bitcast (i32 (i8*)* @B.Print to i8*), i8* bitcast (i8* (i8*,i8*)* @B.getB to i8*)]


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
    %a = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 12)
    store i8* %_0, i8** %a
    %b = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 12)
    store i8* %_1, i8** %b
    %int_array = alloca i32*
    %_2 = call i8* @calloc(i32 0, i32 4)
    %_3 = bitcast i8* %_2 to i32*
    store i32* %_3, i32** %int_array
    %i = alloca i32
    store i32 0, i32* %i
    %flag = alloca i8
    store i8 0, i8* %flag
    %_4 = call i8* @calloc(i32 1, i32 12)
    %_5 = bitcast i8* %_4 to i8**
    %_6 = getelementptr [5 x i8*], [5 x i8*]* @.A_vtable, i32 0, i32 0
    %_7 = bitcast i8** %_6 to i8*
    store i8* %_7, i8** %_5
    store i8* %_4, i8** %a
    %_8 = call i8* @calloc(i32 1, i32 12)
    %_9 = bitcast i8* %_8 to i8**
    %_10 = getelementptr [3 x i8*], [3 x i8*]* @.B_vtable, i32 0, i32 0
    %_11 = bitcast i8** %_10 to i8*
    store i8* %_11, i8** %_9
    store i8* %_8, i8** %b
    %_12 = load i8*, i8** %b
    %_13 = bitcast i8* %_12 to i8**
    %_14 = load i8*, i8** %_13
    %_15 = getelementptr i8, i8* %_14, i32 0
    %_16 = bitcast i8* %_15 to i8**
    %_17 = load i8*, i8** %_16
    %_18 = bitcast i8* %_17 to i32 (i8*)*
    %_19 = call i32 %_18(i8* %_12)
    store i32 %_19, i32* %i
    %_20 = icmp slt i32 1000, 0
    br i1 %_20, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_21 = add i32 1000, 1
    %_22 = call i8* @calloc(i32 %_21, i32 4)
    %_23 = bitcast i8* %_22 to i32*
    store i32 1000, i32* %_23
    %_24 = getelementptr i32, i32* %_23, i32 1
    br label %label2

label2:
    store i32* %_24, i32** %int_array
    store i32 0, i32* %i
    br label %label4

label4:
    %_25 = load i32, i32* %i
    %_26 = load i32*, i32** %int_array
    %_27 = getelementptr i32, i32* %_26, i32 -1
    %_28 = load i32, i32* %_27
    %_29 = icmp slt i32 %_25, %_28
    %_30 = zext i1 %_29 to i8
    %_31 = trunc i8 %_30 to i1
    br i1 %_31, label %label3, label %label5

label3:
    %_32 = load i32*, i32** %int_array
    %_33 = load i32, i32* %i
    %_34 = getelementptr i32, i32* %_32, i32 -1
    %_35 = load i32, i32* %_34
    %_36 = icmp ult i32 %_33, %_35
    br i1 %_36, label %label6, label %label7

label6:
    %_37 = getelementptr i32, i32* %_32, i32 %_33
    %_38 = load i32, i32* %i
    %_39 = mul i32 %_38, 2
    store i32 %_39, i32* %_37
    br label %label8

label7:
    call void @throw_oob()
    br label %label8

label8:
    %_40 = load i32, i32* %i
    %_41 = add i32 %_40, 1
    store i32 %_41, i32* %i
    br label %label4

label5:
    store i32 0, i32* %i
    store i8 1, i8* %flag
    br label %label10

label10:
    %_42 = load i32, i32* %i
    %_43 = load i32*, i32** %int_array
    %_44 = getelementptr i32, i32* %_43, i32 -1
    %_45 = load i32, i32* %_44
    %_46 = icmp slt i32 %_42, %_45
    %_47 = zext i1 %_46 to i8
    %_48 = trunc i8 %_47 to i1
    br i1 %_48, label %label9, label %label11

label9:
    %_49 = load i8, i8* %flag
    %_50 = xor i8 %_49, 1
    store i8 %_50, i8* %flag
    %_51 = load i32, i32* %i
    %_52 = add i32 %_51, 1
    store i32 %_52, i32* %i
    br label %label10

label11:
    %_53 = load i8*, i8** %a
    %_54 = bitcast i8* %_53 to i8**
    %_55 = load i8*, i8** %_54
    %_56 = getelementptr i8, i8* %_55, i32 32
    %_57 = bitcast i8* %_56 to i8**
    %_58 = load i8*, i8** %_57
    %_59 = bitcast i8* %_58 to i32 (i8*, i32, i32*, i8, i8*)*
    %_61 = load i8*, i8** %a
    %_62 = bitcast i8* %_61 to i8**
    %_63 = load i8*, i8** %_62
    %_64 = getelementptr i8, i8* %_63, i32 0
    %_65 = bitcast i8* %_64 to i8**
    %_66 = load i8*, i8** %_65
    %_67 = bitcast i8* %_66 to i32 (i8*, i32)*
    %_69 = load i8*, i8** %a
    %_70 = bitcast i8* %_69 to i8**
    %_71 = load i8*, i8** %_70
    %_72 = getelementptr i8, i8* %_71, i32 0
    %_73 = bitcast i8* %_72 to i8**
    %_74 = load i8*, i8** %_73
    %_75 = bitcast i8* %_74 to i32 (i8*, i32)*
    %_77 = load i8*, i8** %a
    %_78 = bitcast i8* %_77 to i8**
    %_79 = load i8*, i8** %_78
    %_80 = getelementptr i8, i8* %_79, i32 0
    %_81 = bitcast i8* %_80 to i8**
    %_82 = load i8*, i8** %_81
    %_83 = bitcast i8* %_82 to i32 (i8*, i32)*
    %_85 = load i8*, i8** %a
    %_86 = bitcast i8* %_85 to i8**
    %_87 = load i8*, i8** %_86
    %_88 = getelementptr i8, i8* %_87, i32 0
    %_89 = bitcast i8* %_88 to i8**
    %_90 = load i8*, i8** %_89
    %_91 = bitcast i8* %_90 to i32 (i8*, i32)*
    %_93 = load i8*, i8** %a
    %_94 = bitcast i8* %_93 to i8**
    %_95 = load i8*, i8** %_94
    %_96 = getelementptr i8, i8* %_95, i32 0
    %_97 = bitcast i8* %_96 to i8**
    %_98 = load i8*, i8** %_97
    %_99 = bitcast i8* %_98 to i32 (i8*, i32)*
    %_101 = load i8*, i8** %a
    %_102 = bitcast i8* %_101 to i8**
    %_103 = load i8*, i8** %_102
    %_104 = getelementptr i8, i8* %_103, i32 0
    %_105 = bitcast i8* %_104 to i8**
    %_106 = load i8*, i8** %_105
    %_107 = bitcast i8* %_106 to i32 (i8*, i32)*
    %_109 = load i8*, i8** %a
    %_110 = bitcast i8* %_109 to i8**
    %_111 = load i8*, i8** %_110
    %_112 = getelementptr i8, i8* %_111, i32 0
    %_113 = bitcast i8* %_112 to i8**
    %_114 = load i8*, i8** %_113
    %_115 = bitcast i8* %_114 to i32 (i8*, i32)*
    %_116 = call i32 %_115(i8* %_109, i32 1024)
    %_108 = call i32 %_107(i8* %_101, i32 %_116)
    %_100 = call i32 %_99(i8* %_93, i32 %_108)
    %_92 = call i32 %_91(i8* %_85, i32 %_100)
    %_84 = call i32 %_83(i8* %_77, i32 %_92)
    %_76 = call i32 %_75(i8* %_69, i32 %_84)
    %_68 = call i32 %_67(i8* %_61, i32 %_76)
    %_117 = load i8*, i8** %a
    %_118 = bitcast i8* %_117 to i8**
    %_119 = load i8*, i8** %_118
    %_120 = getelementptr i8, i8* %_119, i32 8
    %_121 = bitcast i8* %_120 to i8**
    %_122 = load i8*, i8** %_121
    %_123 = bitcast i8* %_122 to i32* (i8*, i32*)*
    %_125 = load i8*, i8** %a
    %_126 = bitcast i8* %_125 to i8**
    %_127 = load i8*, i8** %_126
    %_128 = getelementptr i8, i8* %_127, i32 8
    %_129 = bitcast i8* %_128 to i8**
    %_130 = load i8*, i8** %_129
    %_131 = bitcast i8* %_130 to i32* (i8*, i32*)*
    %_133 = load i8*, i8** %a
    %_134 = bitcast i8* %_133 to i8**
    %_135 = load i8*, i8** %_134
    %_136 = getelementptr i8, i8* %_135, i32 8
    %_137 = bitcast i8* %_136 to i8**
    %_138 = load i8*, i8** %_137
    %_139 = bitcast i8* %_138 to i32* (i8*, i32*)*
    %_141 = load i8*, i8** %a
    %_142 = bitcast i8* %_141 to i8**
    %_143 = load i8*, i8** %_142
    %_144 = getelementptr i8, i8* %_143, i32 8
    %_145 = bitcast i8* %_144 to i8**
    %_146 = load i8*, i8** %_145
    %_147 = bitcast i8* %_146 to i32* (i8*, i32*)*
    %_149 = load i8*, i8** %a
    %_150 = bitcast i8* %_149 to i8**
    %_151 = load i8*, i8** %_150
    %_152 = getelementptr i8, i8* %_151, i32 8
    %_153 = bitcast i8* %_152 to i8**
    %_154 = load i8*, i8** %_153
    %_155 = bitcast i8* %_154 to i32* (i8*, i32*)*
    %_157 = load i8*, i8** %a
    %_158 = bitcast i8* %_157 to i8**
    %_159 = load i8*, i8** %_158
    %_160 = getelementptr i8, i8* %_159, i32 8
    %_161 = bitcast i8* %_160 to i8**
    %_162 = load i8*, i8** %_161
    %_163 = bitcast i8* %_162 to i32* (i8*, i32*)*
    %_165 = load i32*, i32** %int_array
    %_164 = call i32* %_163(i8* %_157, i32* %_165)
    %_156 = call i32* %_155(i8* %_149, i32* %_164)
    %_148 = call i32* %_147(i8* %_141, i32* %_156)
    %_140 = call i32* %_139(i8* %_133, i32* %_148)
    %_132 = call i32* %_131(i8* %_125, i32* %_140)
    %_124 = call i32* %_123(i8* %_117, i32* %_132)
    %_166 = load i8*, i8** %a
    %_167 = bitcast i8* %_166 to i8**
    %_168 = load i8*, i8** %_167
    %_169 = getelementptr i8, i8* %_168, i32 16
    %_170 = bitcast i8* %_169 to i8**
    %_171 = load i8*, i8** %_170
    %_172 = bitcast i8* %_171 to i8 (i8*, i8)*
    %_174 = load i8*, i8** %a
    %_175 = bitcast i8* %_174 to i8**
    %_176 = load i8*, i8** %_175
    %_177 = getelementptr i8, i8* %_176, i32 16
    %_178 = bitcast i8* %_177 to i8**
    %_179 = load i8*, i8** %_178
    %_180 = bitcast i8* %_179 to i8 (i8*, i8)*
    %_182 = load i8*, i8** %a
    %_183 = bitcast i8* %_182 to i8**
    %_184 = load i8*, i8** %_183
    %_185 = getelementptr i8, i8* %_184, i32 16
    %_186 = bitcast i8* %_185 to i8**
    %_187 = load i8*, i8** %_186
    %_188 = bitcast i8* %_187 to i8 (i8*, i8)*
    %_190 = load i8*, i8** %a
    %_191 = bitcast i8* %_190 to i8**
    %_192 = load i8*, i8** %_191
    %_193 = getelementptr i8, i8* %_192, i32 16
    %_194 = bitcast i8* %_193 to i8**
    %_195 = load i8*, i8** %_194
    %_196 = bitcast i8* %_195 to i8 (i8*, i8)*
    %_198 = load i8*, i8** %a
    %_199 = bitcast i8* %_198 to i8**
    %_200 = load i8*, i8** %_199
    %_201 = getelementptr i8, i8* %_200, i32 16
    %_202 = bitcast i8* %_201 to i8**
    %_203 = load i8*, i8** %_202
    %_204 = bitcast i8* %_203 to i8 (i8*, i8)*
    %_206 = load i8*, i8** %a
    %_207 = bitcast i8* %_206 to i8**
    %_208 = load i8*, i8** %_207
    %_209 = getelementptr i8, i8* %_208, i32 16
    %_210 = bitcast i8* %_209 to i8**
    %_211 = load i8*, i8** %_210
    %_212 = bitcast i8* %_211 to i8 (i8*, i8)*
    %_214 = load i8*, i8** %a
    %_215 = bitcast i8* %_214 to i8**
    %_216 = load i8*, i8** %_215
    %_217 = getelementptr i8, i8* %_216, i32 16
    %_218 = bitcast i8* %_217 to i8**
    %_219 = load i8*, i8** %_218
    %_220 = bitcast i8* %_219 to i8 (i8*, i8)*
    %_221 = call i8 %_220(i8* %_214, i8 1)
    %_213 = call i8 %_212(i8* %_206, i8 %_221)
    %_205 = call i8 %_204(i8* %_198, i8 %_213)
    %_197 = call i8 %_196(i8* %_190, i8 %_205)
    %_189 = call i8 %_188(i8* %_182, i8 %_197)
    %_181 = call i8 %_180(i8* %_174, i8 %_189)
    %_173 = call i8 %_172(i8* %_166, i8 %_181)
    %_222 = load i8*, i8** %b
    %_223 = bitcast i8* %_222 to i8**
    %_224 = load i8*, i8** %_223
    %_225 = getelementptr i8, i8* %_224, i32 16
    %_226 = bitcast i8* %_225 to i8**
    %_227 = load i8*, i8** %_226
    %_228 = bitcast i8* %_227 to i8* (i8*, i8*)*
    %_230 = load i8*, i8** %b
    %_231 = bitcast i8* %_230 to i8**
    %_232 = load i8*, i8** %_231
    %_233 = getelementptr i8, i8* %_232, i32 16
    %_234 = bitcast i8* %_233 to i8**
    %_235 = load i8*, i8** %_234
    %_236 = bitcast i8* %_235 to i8* (i8*, i8*)*
    %_238 = load i8*, i8** %b
    %_239 = bitcast i8* %_238 to i8**
    %_240 = load i8*, i8** %_239
    %_241 = getelementptr i8, i8* %_240, i32 16
    %_242 = bitcast i8* %_241 to i8**
    %_243 = load i8*, i8** %_242
    %_244 = bitcast i8* %_243 to i8* (i8*, i8*)*
    %_246 = load i8*, i8** %b
    %_247 = bitcast i8* %_246 to i8**
    %_248 = load i8*, i8** %_247
    %_249 = getelementptr i8, i8* %_248, i32 16
    %_250 = bitcast i8* %_249 to i8**
    %_251 = load i8*, i8** %_250
    %_252 = bitcast i8* %_251 to i8* (i8*, i8*)*
    %_254 = load i8*, i8** %b
    %_255 = bitcast i8* %_254 to i8**
    %_256 = load i8*, i8** %_255
    %_257 = getelementptr i8, i8* %_256, i32 16
    %_258 = bitcast i8* %_257 to i8**
    %_259 = load i8*, i8** %_258
    %_260 = bitcast i8* %_259 to i8* (i8*, i8*)*
    %_262 = load i8*, i8** %b
    %_261 = call i8* %_260(i8* %_254, i8* %_262)
    %_253 = call i8* %_252(i8* %_246, i8* %_261)
    %_245 = call i8* %_244(i8* %_238, i8* %_253)
    %_237 = call i8* %_236(i8* %_230, i8* %_245)
    %_229 = call i8* %_228(i8* %_222, i8* %_237)
    %_60 = call i32 %_59(i8* %_53, i32 %_68, i32* %_124, i8 %_173, i8* %_229)
    store i32 %_60, i32* %i


    ret i32 0
}

define i32 @A.func_int(i8* %this, i32 %.i) {
    %i = alloca i32
    store i32 %.i, i32* %i
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %i
    store i32 %_2, i32* %_1
    %_3 = load i32, i32* %i

    ret i32 %_3
}

define i32* @A.func_int_array(i8* %this, i32* %.arr) {
    %arr = alloca i32*
    store i32* %.arr, i32** %arr
    %_0 = load i32*, i32** %arr

    ret i32* %_0
}

define i8 @A.func_boolean(i8* %this, i8 %.b) {
    %b = alloca i8
    store i8 %.b, i8* %b
    %_0 = load i8, i8* %b

    ret i8 %_0
}

define i32 @A.decrease(i8* %this, i32 %.i) {
    %i = alloca i32
    store i32 %.i, i32* %i
    %_0 = load i32, i32* %i
    %_1 = sub i32 %_0, 1
    store i32 %_1, i32* %i
    %_2 = load i32, i32* %i

    ret i32 %_2
}

define i32 @A.func(i8* %this, i32 %.i, i32* %.int_arr, i8 %.b, i8* %.c_b) {
    %i = alloca i32
    store i32 %.i, i32* %i
    %int_arr = alloca i32*
    store i32* %.int_arr, i32** %int_arr
    %b = alloca i8
    store i8 %.b, i8* %b
    %c_b = alloca i8*
    store i8* %.c_b, i8** %c_b
    %j = alloca i32
    store i32 0, i32* %j
    %sum = alloca i32
    store i32 0, i32* %sum
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %_1
    call void (i32) @print_int(i32 %_2)
    %_3 = load i32, i32* %i
    call void (i32) @print_int(i32 %_3)
    %_4 = load i32*, i32** %int_arr
    %_5 = getelementptr i32, i32* %_4, i32 -1
    %_6 = load i32, i32* %_5
    call void (i32) @print_int(i32 %_6)
    store i32 0, i32* %j
    store i32 0, i32* %sum
    br label %label1

label1:
    %_7 = load i32, i32* %j
    %_8 = load i32*, i32** %int_arr
    %_9 = getelementptr i32, i32* %_8, i32 -1
    %_10 = load i32, i32* %_9
    %_11 = icmp slt i32 %_7, %_10
    %_12 = zext i1 %_11 to i8
    %_13 = trunc i8 %_12 to i1
    br i1 %_13, label %label0, label %label2

label0:
    %_14 = load i32*, i32** %int_arr
    %_15 = load i32, i32* %j
    %_16 = getelementptr i32, i32* %_14, i32 -1
    %_17 = load i32, i32* %_16
    %_18 = icmp ult i32 %_15, %_17
    br i1 %_18, label %label3, label %label4

label3:
    %_19 = getelementptr i32, i32* %_14, i32 %_15
    %_20 = load i32, i32* %_19
    br label %label5

label4:
    call void @throw_oob()
    br label %label5

label5:
    %_21 = load i32, i32* %sum
    %_22 = add i32 %_20, %_21
    store i32 %_22, i32* %sum
    %_23 = load i32, i32* %j
    %_24 = add i32 %_23, 1
    store i32 %_24, i32* %j
    br label %label1

label2:
    %_25 = load i32, i32* %sum
    call void (i32) @print_int(i32 %_25)
    %_26 = load i8, i8* %b
    %_27 = trunc i8 %_26 to i1
    br i1 %_27, label %label6, label %label7

label6:
    call void (i32) @print_int(i32 1)
    br label %label8

label7:
    call void (i32) @print_int(i32 0)
    br label %label8

label8:
    %_28 = load i32*, i32** %int_arr
    %_29 = getelementptr i32, i32* %_28, i32 -1
    %_30 = load i32, i32* %_29
    call void (i32) @print_int(i32 %_30)
    store i32 0, i32* %j
    store i32 0, i32* %sum
    %_31 = load i32*, i32** %int_arr
    %_32 = load i32, i32* %j
    %_33 = getelementptr i32, i32* %_31, i32 -1
    %_34 = load i32, i32* %_33
    %_35 = icmp ult i32 %_32, %_34
    br i1 %_35, label %label12, label %label13

label12:
    %_36 = getelementptr i32, i32* %_31, i32 %_32
    %_37 = load i32, i32* %_36
    br label %label14

label13:
    call void @throw_oob()
    br label %label14

label14:
    %_38 = icmp slt i32 %_37, 0
    %_39 = zext i1 %_38 to i8
    %_40 = trunc i8 %_39 to i1
    br i1 %_40, label %label9, label %label10

label9:
    %_41 = load i32, i32* %sum
    %_42 = add i32 %_41, 1
    store i32 %_42, i32* %sum
    br label %label11

label10:
    %_43 = load i32, i32* %sum
    %_44 = add i32 %_43, 10
    store i32 %_44, i32* %sum
    br label %label11

label11:
    %_45 = load i32, i32* %sum
    call void (i32) @print_int(i32 %_45)
    %_46 = load i8*, i8** %c_b
    %_47 = bitcast i8* %_46 to i8**
    %_48 = load i8*, i8** %_47
    %_49 = getelementptr i8, i8* %_48, i32 8
    %_50 = bitcast i8* %_49 to i8**
    %_51 = load i8*, i8** %_50
    %_52 = bitcast i8* %_51 to i32 (i8*)*
    %_53 = call i32 %_52(i8* %_46)
    store i32 %_53, i32* %j
    %_54 = load i32, i32* %j

    ret i32 %_54
}

define i32 @B.Init(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    store i32 1048576, i32* %_1

    ret i32 1
}

define i32 @B.Print(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %_1
    call void (i32) @print_int(i32 %_2)

    ret i32 1
}

define i8* @B.getB(i8* %this, i8* %.b) {
    %b = alloca i8*
    store i8* %.b, i8** %b
    %_0 = load i8*, i8** %b

    ret i8* %_0
}
