@.Main_vtable = global [0 x i8*] []


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
    %size = alloca i32
    store i32 0, i32* %size
    %index = alloca i32
    store i32 0, i32* %index
    %sum = alloca i32
    store i32 0, i32* %sum
    %int_array = alloca i32*
    %_0 = call i8* @calloc(i32 0, i32 4)
    %_1 = bitcast i8* %_0 to i32*
    store i32* %_1, i32** %int_array
    %int_array_ref = alloca i32*
    %_2 = call i8* @calloc(i32 0, i32 4)
    %_3 = bitcast i8* %_2 to i32*
    store i32* %_3, i32** %int_array_ref
    %flag = alloca i8
    store i8 0, i8* %flag
    store i32 1024, i32* %size
    %_4 = load i32, i32* %size
    %_5 = add i32 %_4, 1
    %_6 = sub i32 %_5, 1
    %_7 = icmp slt i32 %_6, 0
    br i1 %_7, label %label0, label %label1

label0:
    call void @throw_oob()
    br label %label2

label1:
    %_8 = add i32 %_6, 1
    %_9 = call i8* @calloc(i32 %_8, i32 4)
    %_10 = bitcast i8* %_9 to i32*
    store i32 %_6, i32* %_10
    %_11 = getelementptr i32, i32* %_10, i32 1
    br label %label2

label2:
    store i32* %_11, i32** %int_array
    %_12 = load i32*, i32** %int_array
    %_13 = getelementptr i32, i32* %_12, i32 -1
    %_14 = load i32, i32* %_13
    %_15 = load i32, i32* %size
    %_16 = icmp slt i32 %_14, %_15
    %_17 = zext i1 %_16 to i8
    %_18 = xor i8 %_17, 1
    %_19 = trunc i8 %_18 to i1
    br i1 %_19, label %label6, label %label7

label6:
    %_20 = load i32, i32* %size
    %_21 = load i32*, i32** %int_array
    %_22 = getelementptr i32, i32* %_21, i32 -1
    %_23 = load i32, i32* %_22
    %_24 = icmp slt i32 %_20, %_23
    %_25 = zext i1 %_24 to i8
    %_26 = xor i8 %_25, 1
    br label %label8

label8:
    br label %label9

label7:
    br label %label9

label9:
    %_27 = phi i8 [%_26, %label8], [%_18, %label7]
    %_28 = trunc i8 %_27 to i1
    br i1 %_28, label %label3, label %label4

label3:
    %_29 = load i32*, i32** %int_array
    %_30 = getelementptr i32, i32* %_29, i32 -1
    %_31 = load i32, i32* %_30
    call void (i32) @print_int(i32 %_31)
    br label %label5

label4:
    call void (i32) @print_int(i32 2020)
    br label %label5

label5:
    %_32 = load i32*, i32** %int_array
    %_33 = getelementptr i32, i32* %_32, i32 -1
    %_34 = load i32, i32* %_33
    %_35 = load i32, i32* %size
    %_36 = icmp slt i32 %_34, %_35
    %_37 = zext i1 %_36 to i8
    %_38 = xor i8 %_37, 1
    %_39 = trunc i8 %_38 to i1
    br i1 %_39, label %label13, label %label14

label13:
    %_40 = load i32, i32* %size
    %_41 = load i32*, i32** %int_array
    %_42 = getelementptr i32, i32* %_41, i32 -1
    %_43 = load i32, i32* %_42
    %_44 = icmp slt i32 %_40, %_43
    %_45 = zext i1 %_44 to i8
    %_46 = xor i8 %_45, 1
    br label %label15

label15:
    br label %label16

label14:
    br label %label16

label16:
    %_47 = phi i8 [%_46, %label15], [%_38, %label14]
    %_48 = trunc i8 %_47 to i1
    br i1 %_48, label %label10, label %label11

label10:
    %_49 = load i32*, i32** %int_array
    %_50 = getelementptr i32, i32* %_49, i32 -1
    %_51 = load i32, i32* %_50
    call void (i32) @print_int(i32 %_51)
    br label %label12

label11:
    call void (i32) @print_int(i32 2020)
    br label %label12

label12:
    store i32 0, i32* %index
    br label %label18

label18:
    %_52 = load i32, i32* %index
    %_53 = load i32*, i32** %int_array
    %_54 = getelementptr i32, i32* %_53, i32 -1
    %_55 = load i32, i32* %_54
    %_56 = icmp slt i32 %_52, %_55
    %_57 = zext i1 %_56 to i8
    %_58 = trunc i8 %_57 to i1
    br i1 %_58, label %label17, label %label19

label17:
    %_59 = load i32*, i32** %int_array
    %_60 = load i32, i32* %index
    %_61 = getelementptr i32, i32* %_59, i32 -1
    %_62 = load i32, i32* %_61
    %_63 = icmp ult i32 %_60, %_62
    br i1 %_63, label %label20, label %label21

label20:
    %_64 = getelementptr i32, i32* %_59, i32 %_60
    %_65 = load i32, i32* %index
    %_66 = mul i32 %_65, 2
    store i32 %_66, i32* %_64
    br label %label22

label21:
    call void @throw_oob()
    br label %label22

label22:
    %_67 = load i32, i32* %index
    %_68 = add i32 %_67, 1
    store i32 %_68, i32* %index
    br label %label18

label19:
    store i32 0, i32* %index
    %_69 = load i32*, i32** %int_array
    store i32* %_69, i32** %int_array_ref
    store i32 0, i32* %sum
    br label %label24

label24:
    %_70 = load i32, i32* %index
    %_71 = load i32*, i32** %int_array_ref
    %_72 = getelementptr i32, i32* %_71, i32 -1
    %_73 = load i32, i32* %_72
    %_74 = icmp slt i32 %_70, %_73
    %_75 = zext i1 %_74 to i8
    %_76 = trunc i8 %_75 to i1
    br i1 %_76, label %label23, label %label25

label23:
    %_77 = load i32*, i32** %int_array_ref
    %_78 = load i32, i32* %index
    %_79 = getelementptr i32, i32* %_77, i32 -1
    %_80 = load i32, i32* %_79
    %_81 = icmp ult i32 %_78, %_80
    br i1 %_81, label %label26, label %label27

label26:
    %_82 = getelementptr i32, i32* %_77, i32 %_78
    %_83 = load i32, i32* %_82
    br label %label28

label27:
    call void @throw_oob()
    br label %label28

label28:
    %_84 = load i32, i32* %sum
    %_85 = add i32 %_83, %_84
    store i32 %_85, i32* %sum
    %_86 = load i32, i32* %index
    %_87 = add i32 %_86, 1
    store i32 %_87, i32* %index
    br label %label24

label25:
    %_88 = load i32, i32* %sum
    call void (i32) @print_int(i32 %_88)
    store i32 0, i32* %index
    store i8 1, i8* %flag
    br label %label30

label30:
    %_89 = load i32, i32* %index
    %_90 = load i32*, i32** %int_array
    %_91 = getelementptr i32, i32* %_90, i32 -1
    %_92 = load i32, i32* %_91
    %_93 = icmp slt i32 %_89, %_92
    %_94 = zext i1 %_93 to i8
    %_95 = trunc i8 %_94 to i1
    br i1 %_95, label %label29, label %label31

label29:
    %_96 = load i8, i8* %flag
    %_97 = xor i8 %_96, 1
    store i8 %_97, i8* %flag
    %_98 = load i32, i32* %index
    %_99 = add i32 %_98, 1
    store i32 %_99, i32* %index
    br label %label30

label31:
    store i32 0, i32* %index
    store i32 0, i32* %sum
    br label %label33

label33:
    %_100 = load i32, i32* %index
    %_101 = load i32*, i32** %int_array
    %_102 = getelementptr i32, i32* %_101, i32 -1
    %_103 = load i32, i32* %_102
    %_104 = icmp slt i32 %_100, %_103
    %_105 = zext i1 %_104 to i8
    %_106 = trunc i8 %_105 to i1
    br i1 %_106, label %label32, label %label34

label32:
    %_107 = load i32*, i32** %int_array
    %_108 = load i32, i32* %index
    %_109 = getelementptr i32, i32* %_107, i32 -1
    %_110 = load i32, i32* %_109
    %_111 = icmp ult i32 %_108, %_110
    br i1 %_111, label %label38, label %label39

label38:
    %_112 = getelementptr i32, i32* %_107, i32 %_108
    %_113 = load i32, i32* %_112
    br label %label40

label39:
    call void @throw_oob()
    br label %label40

label40:
    %_114 = icmp slt i32 %_113, 1
    %_115 = zext i1 %_114 to i8
    %_116 = trunc i8 %_115 to i1
    br i1 %_116, label %label35, label %label36

label35:
    %_117 = load i32, i32* %sum
    %_118 = add i32 %_117, 1
    store i32 %_118, i32* %sum
    br label %label37

label36:
    %_119 = load i32, i32* %sum
    %_120 = add i32 %_119, 10
    store i32 %_120, i32* %sum
    br label %label37

label37:
    %_121 = load i32, i32* %index
    %_122 = add i32 %_121, 1
    store i32 %_122, i32* %index
    br label %label33

label34:
    %_123 = load i32, i32* %sum
    call void (i32) @print_int(i32 %_123)


    ret i32 0
}
