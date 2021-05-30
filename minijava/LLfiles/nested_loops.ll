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
    %i = alloca i32
    store i32 0, i32* %i
    %j = alloca i32
    store i32 0, i32* %j
    %z = alloca i32
    store i32 0, i32* %z
    %x = alloca i32
    store i32 0, i32* %x
    %sum = alloca i32
    store i32 0, i32* %sum
    %flag = alloca i8
    store i8 0, i8* %flag
    store i32 0, i32* %sum
    store i32 0, i32* %i
    br label %label1

label1:
    %_0 = load i32, i32* %i
    %_1 = icmp slt i32 %_0, 6
    %_2 = zext i1 %_1 to i8
    %_3 = trunc i8 %_2 to i1
    br i1 %_3, label %label0, label %label2

label0:
    store i32 0, i32* %j
    br label %label4

label4:
    %_4 = load i32, i32* %j
    %_5 = icmp slt i32 %_4, 5
    %_6 = zext i1 %_5 to i8
    %_7 = trunc i8 %_6 to i1
    br i1 %_7, label %label3, label %label5

label3:
    store i32 0, i32* %z
    br label %label7

label7:
    %_8 = load i32, i32* %z
    %_9 = icmp slt i32 %_8, 4
    %_10 = zext i1 %_9 to i8
    %_11 = trunc i8 %_10 to i1
    br i1 %_11, label %label6, label %label8

label6:
    store i32 0, i32* %x
    br label %label10

label10:
    %_12 = load i32, i32* %x
    %_13 = icmp slt i32 %_12, 4
    %_14 = zext i1 %_13 to i8
    %_15 = trunc i8 %_14 to i1
    br i1 %_15, label %label9, label %label11

label9:
    %_16 = load i32, i32* %sum
    %_17 = load i32, i32* %i
    %_18 = load i32, i32* %j
    %_19 = add i32 %_17, %_18
    %_20 = load i32, i32* %z
    %_21 = add i32 %_19, %_20
    %_22 = load i32, i32* %x
    %_23 = add i32 %_21, %_22
    %_24 = add i32 %_16, %_23
    store i32 %_24, i32* %sum
    %_25 = load i32, i32* %x
    %_26 = add i32 %_25, 1
    store i32 %_26, i32* %x
    br label %label10

label11:
    %_27 = load i32, i32* %z
    %_28 = add i32 %_27, 1
    store i32 %_28, i32* %z
    br label %label7

label8:
    %_29 = load i32, i32* %j
    %_30 = add i32 %_29, 1
    store i32 %_30, i32* %j
    br label %label4

label5:
    %_31 = load i32, i32* %i
    %_32 = add i32 %_31, 1
    store i32 %_32, i32* %i
    br label %label1

label2:
    %_33 = load i32, i32* %sum
    call void (i32) @print_int(i32 %_33)
    store i32 0, i32* %sum
    store i32 0, i32* %i
    store i8 1, i8* %flag
    br label %label13

label13:
    %_34 = load i32, i32* %i
    %_35 = icmp slt i32 %_34, 6
    %_36 = zext i1 %_35 to i8
    %_37 = trunc i8 %_36 to i1
    br i1 %_37, label %label12, label %label14

label12:
    store i32 0, i32* %j
    %_38 = load i8, i8* %flag
    %_39 = trunc i8 %_38 to i1
    br i1 %_39, label %label15, label %label16

label15:
    br label %label19

label19:
    %_40 = load i32, i32* %j
    %_41 = icmp slt i32 %_40, 5
    %_42 = zext i1 %_41 to i8
    %_43 = trunc i8 %_42 to i1
    br i1 %_43, label %label18, label %label20

label18:
    store i32 0, i32* %z
    br label %label22

label22:
    %_44 = load i32, i32* %z
    %_45 = icmp slt i32 %_44, 4
    %_46 = zext i1 %_45 to i8
    %_47 = trunc i8 %_46 to i1
    br i1 %_47, label %label21, label %label23

label21:
    store i32 0, i32* %x
    br label %label25

label25:
    %_48 = load i32, i32* %x
    %_49 = icmp slt i32 %_48, 4
    %_50 = zext i1 %_49 to i8
    %_51 = trunc i8 %_50 to i1
    br i1 %_51, label %label24, label %label26

label24:
    %_52 = load i32, i32* %sum
    %_53 = load i32, i32* %i
    %_54 = load i32, i32* %j
    %_55 = add i32 %_53, %_54
    %_56 = load i32, i32* %z
    %_57 = add i32 %_55, %_56
    %_58 = load i32, i32* %x
    %_59 = add i32 %_57, %_58
    %_60 = add i32 %_52, %_59
    store i32 %_60, i32* %sum
    %_61 = load i32, i32* %x
    %_62 = add i32 %_61, 1
    store i32 %_62, i32* %x
    br label %label25

label26:
    %_63 = load i32, i32* %z
    %_64 = add i32 %_63, 1
    store i32 %_64, i32* %z
    br label %label22

label23:
    %_65 = load i32, i32* %j
    %_66 = add i32 %_65, 1
    store i32 %_66, i32* %j
    br label %label19

label20:
    store i8 0, i8* %flag
    br label %label17

label16:
    br label %label28

label28:
    %_67 = load i32, i32* %j
    %_68 = icmp slt i32 %_67, 4
    %_69 = zext i1 %_68 to i8
    %_70 = trunc i8 %_69 to i1
    br i1 %_70, label %label27, label %label29

label27:
    store i32 0, i32* %z
    br label %label31

label31:
    %_71 = load i32, i32* %z
    %_72 = icmp slt i32 %_71, 10
    %_73 = zext i1 %_72 to i8
    %_74 = trunc i8 %_73 to i1
    br i1 %_74, label %label30, label %label32

label30:
    store i32 0, i32* %x
    br label %label34

label34:
    %_75 = load i32, i32* %x
    %_76 = icmp slt i32 %_75, 4
    %_77 = zext i1 %_76 to i8
    %_78 = trunc i8 %_77 to i1
    br i1 %_78, label %label33, label %label35

label33:
    %_79 = load i32, i32* %sum
    %_80 = load i32, i32* %i
    %_81 = load i32, i32* %j
    %_82 = mul i32 %_80, %_81
    %_83 = load i32, i32* %z
    %_84 = add i32 %_82, %_83
    %_85 = load i32, i32* %x
    %_86 = add i32 %_84, %_85
    %_87 = add i32 %_79, %_86
    store i32 %_87, i32* %sum
    %_88 = load i32, i32* %x
    %_89 = add i32 %_88, 1
    store i32 %_89, i32* %x
    br label %label34

label35:
    %_90 = load i32, i32* %z
    %_91 = add i32 %_90, 1
    store i32 %_91, i32* %z
    br label %label31

label32:
    %_92 = load i32, i32* %j
    %_93 = add i32 %_92, 1
    store i32 %_93, i32* %j
    br label %label28

label29:
    store i8 0, i8* %flag
    br label %label17

label17:
    %_94 = load i32, i32* %i
    %_95 = add i32 %_94, 1
    store i32 %_95, i32* %i
    br label %label13

label14:
    %_96 = load i32, i32* %sum
    call void (i32) @print_int(i32 %_96)


    ret i32 0
}
