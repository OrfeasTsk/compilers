@.Main_vtable = global [0 x i8*] []
@.A_vtable = global [3 x i8*] [i8* bitcast (i8 (i8*)* @A.set_x to i8*), i8* bitcast (i32 (i8*)* @A.x to i8*), i8* bitcast (i32 (i8*)* @A.y to i8*)]
@.B_vtable = global [3 x i8*] [i8* bitcast (i8 (i8*)* @B.set_x to i8*), i8* bitcast (i32 (i8*)* @B.x to i8*), i8* bitcast (i32 (i8*)* @A.y to i8*)]
@.C_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*)* @C.get_class_x to i8*), i8* bitcast (i32 (i8*)* @C.get_method_x to i8*), i8* bitcast (i8 (i8*)* @C.set_int_x to i8*)]
@.D_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*)* @C.get_class_x to i8*), i8* bitcast (i32 (i8*)* @C.get_method_x to i8*), i8* bitcast (i8 (i8*)* @C.set_int_x to i8*), i8* bitcast (i8 (i8*)* @D.get_class_x2 to i8*)]
@.E_vtable = global [6 x i8*] [i8* bitcast (i32 (i8*)* @C.get_class_x to i8*), i8* bitcast (i32 (i8*)* @C.get_method_x to i8*), i8* bitcast (i8 (i8*)* @C.set_int_x to i8*), i8* bitcast (i8 (i8*)* @D.get_class_x2 to i8*), i8* bitcast (i8 (i8*)* @E.set_bool_x to i8*), i8* bitcast (i8 (i8*)* @E.get_bool_x to i8*)]


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
    %_0 = call i8* @calloc(i32 0, i32 16)
    store i8* %_0, i8** %a
    %c = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 12)
    store i8* %_1, i8** %c
    %d = alloca i8*
    %_2 = call i8* @calloc(i32 0, i32 13)
    store i8* %_2, i8** %d
    %e = alloca i8*
    %_3 = call i8* @calloc(i32 0, i32 14)
    store i8* %_3, i8** %e
    %dummy = alloca i8
    store i8 0, i8* %dummy
    %_4 = call i8* @calloc(i32 1, i32 16)
    %_5 = bitcast i8* %_4 to i8**
    %_6 = getelementptr [3 x i8*], [3 x i8*]* @.A_vtable, i32 0, i32 0
    %_7 = bitcast i8** %_6 to i8*
    store i8* %_7, i8** %_5
    store i8* %_4, i8** %a
    %_8 = load i8*, i8** %a
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    %_11 = getelementptr i8, i8* %_10, i32 0
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = bitcast i8* %_13 to i8 (i8*)*
    %_15 = call i8 %_14(i8* %_8)
    store i8 %_15, i8* %dummy
    %_16 = load i8*, i8** %a
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = getelementptr i8, i8* %_18, i32 8
    %_20 = bitcast i8* %_19 to i8**
    %_21 = load i8*, i8** %_20
    %_22 = bitcast i8* %_21 to i32 (i8*)*
    %_23 = call i32 %_22(i8* %_16)
    call void (i32) @print_int(i32 %_23)
    %_24 = load i8*, i8** %a
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = getelementptr i8, i8* %_26, i32 16
    %_28 = bitcast i8* %_27 to i8**
    %_29 = load i8*, i8** %_28
    %_30 = bitcast i8* %_29 to i32 (i8*)*
    %_31 = call i32 %_30(i8* %_24)
    call void (i32) @print_int(i32 %_31)
    %_32 = call i8* @calloc(i32 1, i32 20)
    %_33 = bitcast i8* %_32 to i8**
    %_34 = getelementptr [3 x i8*], [3 x i8*]* @.B_vtable, i32 0, i32 0
    %_35 = bitcast i8** %_34 to i8*
    store i8* %_35, i8** %_33
    store i8* %_32, i8** %a
    %_36 = load i8*, i8** %a
    %_37 = bitcast i8* %_36 to i8**
    %_38 = load i8*, i8** %_37
    %_39 = getelementptr i8, i8* %_38, i32 0
    %_40 = bitcast i8* %_39 to i8**
    %_41 = load i8*, i8** %_40
    %_42 = bitcast i8* %_41 to i8 (i8*)*
    %_43 = call i8 %_42(i8* %_36)
    store i8 %_43, i8* %dummy
    %_44 = load i8*, i8** %a
    %_45 = bitcast i8* %_44 to i8**
    %_46 = load i8*, i8** %_45
    %_47 = getelementptr i8, i8* %_46, i32 8
    %_48 = bitcast i8* %_47 to i8**
    %_49 = load i8*, i8** %_48
    %_50 = bitcast i8* %_49 to i32 (i8*)*
    %_51 = call i32 %_50(i8* %_44)
    call void (i32) @print_int(i32 %_51)
    %_52 = load i8*, i8** %a
    %_53 = bitcast i8* %_52 to i8**
    %_54 = load i8*, i8** %_53
    %_55 = getelementptr i8, i8* %_54, i32 16
    %_56 = bitcast i8* %_55 to i8**
    %_57 = load i8*, i8** %_56
    %_58 = bitcast i8* %_57 to i32 (i8*)*
    %_59 = call i32 %_58(i8* %_52)
    call void (i32) @print_int(i32 %_59)
    %_60 = call i8* @calloc(i32 1, i32 12)
    %_61 = bitcast i8* %_60 to i8**
    %_62 = getelementptr [3 x i8*], [3 x i8*]* @.C_vtable, i32 0, i32 0
    %_63 = bitcast i8** %_62 to i8*
    store i8* %_63, i8** %_61
    store i8* %_60, i8** %c
    %_64 = load i8*, i8** %c
    %_65 = bitcast i8* %_64 to i8**
    %_66 = load i8*, i8** %_65
    %_67 = getelementptr i8, i8* %_66, i32 8
    %_68 = bitcast i8* %_67 to i8**
    %_69 = load i8*, i8** %_68
    %_70 = bitcast i8* %_69 to i32 (i8*)*
    %_71 = call i32 %_70(i8* %_64)
    call void (i32) @print_int(i32 %_71)
    %_72 = load i8*, i8** %c
    %_73 = bitcast i8* %_72 to i8**
    %_74 = load i8*, i8** %_73
    %_75 = getelementptr i8, i8* %_74, i32 0
    %_76 = bitcast i8* %_75 to i8**
    %_77 = load i8*, i8** %_76
    %_78 = bitcast i8* %_77 to i32 (i8*)*
    %_79 = call i32 %_78(i8* %_72)
    call void (i32) @print_int(i32 %_79)
    %_80 = call i8* @calloc(i32 1, i32 13)
    %_81 = bitcast i8* %_80 to i8**
    %_82 = getelementptr [4 x i8*], [4 x i8*]* @.D_vtable, i32 0, i32 0
    %_83 = bitcast i8** %_82 to i8*
    store i8* %_83, i8** %_81
    store i8* %_80, i8** %d
    %_84 = load i8*, i8** %d
    %_85 = bitcast i8* %_84 to i8**
    %_86 = load i8*, i8** %_85
    %_87 = getelementptr i8, i8* %_86, i32 16
    %_88 = bitcast i8* %_87 to i8**
    %_89 = load i8*, i8** %_88
    %_90 = bitcast i8* %_89 to i8 (i8*)*
    %_91 = call i8 %_90(i8* %_84)
    store i8 %_91, i8* %dummy
    %_92 = load i8*, i8** %d
    %_93 = bitcast i8* %_92 to i8**
    %_94 = load i8*, i8** %_93
    %_95 = getelementptr i8, i8* %_94, i32 24
    %_96 = bitcast i8* %_95 to i8**
    %_97 = load i8*, i8** %_96
    %_98 = bitcast i8* %_97 to i8 (i8*)*
    %_99 = call i8 %_98(i8* %_92)
    %_100 = trunc i8 %_99 to i1
    br i1 %_100, label %label0, label %label1

label0:
    call void (i32) @print_int(i32 1)
    br label %label2

label1:
    call void (i32) @print_int(i32 0)
    br label %label2

label2:
    %_101 = call i8* @calloc(i32 1, i32 14)
    %_102 = bitcast i8* %_101 to i8**
    %_103 = getelementptr [6 x i8*], [6 x i8*]* @.E_vtable, i32 0, i32 0
    %_104 = bitcast i8** %_103 to i8*
    store i8* %_104, i8** %_102
    store i8* %_101, i8** %e
    %_105 = load i8*, i8** %e
    %_106 = bitcast i8* %_105 to i8**
    %_107 = load i8*, i8** %_106
    %_108 = getelementptr i8, i8* %_107, i32 16
    %_109 = bitcast i8* %_108 to i8**
    %_110 = load i8*, i8** %_109
    %_111 = bitcast i8* %_110 to i8 (i8*)*
    %_112 = call i8 %_111(i8* %_105)
    store i8 %_112, i8* %dummy
    %_113 = load i8*, i8** %e
    %_114 = bitcast i8* %_113 to i8**
    %_115 = load i8*, i8** %_114
    %_116 = getelementptr i8, i8* %_115, i32 24
    %_117 = bitcast i8* %_116 to i8**
    %_118 = load i8*, i8** %_117
    %_119 = bitcast i8* %_118 to i8 (i8*)*
    %_120 = call i8 %_119(i8* %_113)
    %_121 = trunc i8 %_120 to i1
    br i1 %_121, label %label3, label %label4

label3:
    call void (i32) @print_int(i32 1)
    br label %label5

label4:
    call void (i32) @print_int(i32 0)
    br label %label5

label5:
    %_122 = load i8*, i8** %e
    %_123 = bitcast i8* %_122 to i8**
    %_124 = load i8*, i8** %_123
    %_125 = getelementptr i8, i8* %_124, i32 32
    %_126 = bitcast i8* %_125 to i8**
    %_127 = load i8*, i8** %_126
    %_128 = bitcast i8* %_127 to i8 (i8*)*
    %_129 = call i8 %_128(i8* %_122)
    store i8 %_129, i8* %dummy
    %_130 = load i8*, i8** %e
    %_131 = bitcast i8* %_130 to i8**
    %_132 = load i8*, i8** %_131
    %_133 = getelementptr i8, i8* %_132, i32 40
    %_134 = bitcast i8* %_133 to i8**
    %_135 = load i8*, i8** %_134
    %_136 = bitcast i8* %_135 to i8 (i8*)*
    %_137 = call i8 %_136(i8* %_130)
    %_138 = trunc i8 %_137 to i1
    br i1 %_138, label %label6, label %label7

label6:
    call void (i32) @print_int(i32 1)
    br label %label8

label7:
    call void (i32) @print_int(i32 0)
    br label %label8

label8:


    ret i32 0
}

define i8 @A.set_x(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    store i32 1, i32* %_1

    ret i8 1
}

define i32 @A.x(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %_1

    ret i32 %_2
}

define i32 @A.y(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 12
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %_1

    ret i32 %_2
}

define i8 @B.set_x(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 16
    %_1 = bitcast i8* %_0 to i32*
    store i32 2, i32* %_1

    ret i8 1
}

define i32 @B.x(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 16
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %_1

    ret i32 %_2
}

define i32 @C.get_class_x(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %_1

    ret i32 %_2
}

define i32 @C.get_method_x(i8* %this) {
    %x = alloca i32
    store i32 0, i32* %x
    store i32 3, i32* %x
    %_0 = load i32, i32* %x

    ret i32 %_0
}

define i8 @C.set_int_x(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    store i32 20, i32* %_1

    ret i8 1
}

define i8 @D.get_class_x2(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 12
    %_1 = bitcast i8* %_0 to i8*
    %_2 = load i8, i8* %_1

    ret i8 %_2
}

define i8 @E.set_bool_x(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 13
    %_1 = bitcast i8* %_0 to i8*
    store i8 1, i8* %_1

    ret i8 1
}

define i8 @E.get_bool_x(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 13
    %_1 = bitcast i8* %_0 to i8*
    %_2 = load i8, i8* %_1

    ret i8 %_2
}
