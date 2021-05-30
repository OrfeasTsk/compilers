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
    %flag = alloca i8
    store i8 0, i8* %flag
    %_0 = trunc i8 1 to i1
    br i1 %_0, label %label0, label %label1

label0:
    %_1 = trunc i8 1 to i1
    br i1 %_1, label %label3, label %label4

label3:
    %_2 = trunc i8 1 to i1
    br i1 %_2, label %label6, label %label7

label6:
    %_3 = trunc i8 1 to i1
    br i1 %_3, label %label9, label %label10

label9:
    %_4 = trunc i8 1 to i1
    br i1 %_4, label %label12, label %label13

label12:
    call void (i32) @print_int(i32 1)
    br label %label14

label13:
    call void (i32) @print_int(i32 0)
    br label %label14

label14:
    call void (i32) @print_int(i32 2)
    br label %label11

label10:
    call void (i32) @print_int(i32 0)
    br label %label11

label11:
    call void (i32) @print_int(i32 3)
    br label %label8

label7:
    call void (i32) @print_int(i32 0)
    br label %label8

label8:
    call void (i32) @print_int(i32 4)
    br label %label5

label4:
    call void (i32) @print_int(i32 0)
    br label %label5

label5:
    call void (i32) @print_int(i32 5)
    br label %label2

label1:
    call void (i32) @print_int(i32 0)
    br label %label2

label2:
    %_5 = trunc i8 1 to i1
    br i1 %_5, label %label23, label %label24

label23:
    br label %label25

label25:
    br label %label26

label24:
    br label %label26

label26:
    %_6 = phi i8 [1, %label25], [1, %label24]
    %_7 = trunc i8 %_6 to i1
    br i1 %_7, label %label19, label %label20

label19:
    %_8 = xor i8 0, 1
    %_9 = trunc i8 %_8 to i1
    br i1 %_9, label %label27, label %label28

label27:
    %_10 = xor i8 0, 1
    br label %label29

label29:
    br label %label30

label28:
    br label %label30

label30:
    %_11 = phi i8 [%_10, %label29], [%_8, %label28]
    br label %label21

label21:
    br label %label22

label20:
    br label %label22

label22:
    %_12 = phi i8 [%_11, %label21], [%_6, %label20]
    %_13 = trunc i8 %_12 to i1
    br i1 %_13, label %label15, label %label16

label15:
    %_14 = icmp slt i32 100, 1000
    %_15 = zext i1 %_14 to i8
    br label %label17

label17:
    br label %label18

label16:
    br label %label18

label18:
    %_16 = phi i8 [%_15, %label17], [%_12, %label16]
    store i8 %_16, i8* %flag
    %_17 = trunc i8 1 to i1
    br i1 %_17, label %label38, label %label39

label38:
    %_18 = load i8, i8* %flag
    br label %label40

label40:
    br label %label41

label39:
    br label %label41

label41:
    %_19 = phi i8 [%_18, %label40], [1, %label39]
    %_20 = trunc i8 %_19 to i1
    br i1 %_20, label %label34, label %label35

label34:
    %_21 = xor i8 0, 1
    %_22 = trunc i8 %_21 to i1
    br i1 %_22, label %label42, label %label43

label42:
    %_23 = xor i8 0, 1
    br label %label44

label44:
    br label %label45

label43:
    br label %label45

label45:
    %_24 = phi i8 [%_23, %label44], [%_21, %label43]
    br label %label36

label36:
    br label %label37

label35:
    br label %label37

label37:
    %_25 = phi i8 [%_24, %label36], [%_19, %label35]
    %_26 = trunc i8 %_25 to i1
    br i1 %_26, label %label31, label %label32

label31:
    %_27 = trunc i8 1 to i1
    br i1 %_27, label %label53, label %label54

label53:
    %_28 = load i8, i8* %flag
    br label %label55

label55:
    br label %label56

label54:
    br label %label56

label56:
    %_29 = phi i8 [%_28, %label55], [1, %label54]
    %_30 = trunc i8 %_29 to i1
    br i1 %_30, label %label49, label %label50

label49:
    %_31 = xor i8 0, 1
    %_32 = trunc i8 %_31 to i1
    br i1 %_32, label %label57, label %label58

label57:
    %_33 = xor i8 0, 1
    br label %label59

label59:
    br label %label60

label58:
    br label %label60

label60:
    %_34 = phi i8 [%_33, %label59], [%_31, %label58]
    br label %label51

label51:
    br label %label52

label50:
    br label %label52

label52:
    %_35 = phi i8 [%_34, %label51], [%_29, %label50]
    %_36 = trunc i8 %_35 to i1
    br i1 %_36, label %label46, label %label47

label46:
    %_37 = trunc i8 1 to i1
    br i1 %_37, label %label68, label %label69

label68:
    %_38 = load i8, i8* %flag
    br label %label70

label70:
    br label %label71

label69:
    br label %label71

label71:
    %_39 = phi i8 [%_38, %label70], [1, %label69]
    %_40 = trunc i8 %_39 to i1
    br i1 %_40, label %label64, label %label65

label64:
    %_41 = xor i8 0, 1
    %_42 = trunc i8 %_41 to i1
    br i1 %_42, label %label72, label %label73

label72:
    %_43 = xor i8 0, 1
    br label %label74

label74:
    br label %label75

label73:
    br label %label75

label75:
    %_44 = phi i8 [%_43, %label74], [%_41, %label73]
    br label %label66

label66:
    br label %label67

label65:
    br label %label67

label67:
    %_45 = phi i8 [%_44, %label66], [%_39, %label65]
    %_46 = trunc i8 %_45 to i1
    br i1 %_46, label %label61, label %label62

label61:
    %_47 = trunc i8 1 to i1
    br i1 %_47, label %label83, label %label84

label83:
    %_48 = load i8, i8* %flag
    br label %label85

label85:
    br label %label86

label84:
    br label %label86

label86:
    %_49 = phi i8 [%_48, %label85], [1, %label84]
    %_50 = trunc i8 %_49 to i1
    br i1 %_50, label %label79, label %label80

label79:
    %_51 = xor i8 0, 1
    %_52 = trunc i8 %_51 to i1
    br i1 %_52, label %label87, label %label88

label87:
    %_53 = xor i8 0, 1
    br label %label89

label89:
    br label %label90

label88:
    br label %label90

label90:
    %_54 = phi i8 [%_53, %label89], [%_51, %label88]
    br label %label81

label81:
    br label %label82

label80:
    br label %label82

label82:
    %_55 = phi i8 [%_54, %label81], [%_49, %label80]
    %_56 = trunc i8 %_55 to i1
    br i1 %_56, label %label76, label %label77

label76:
    %_57 = load i8, i8* %flag
    %_58 = trunc i8 %_57 to i1
    br i1 %_58, label %label98, label %label99

label98:
    %_59 = load i8, i8* %flag
    br label %label100

label100:
    br label %label101

label99:
    br label %label101

label101:
    %_60 = phi i8 [%_59, %label100], [%_57, %label99]
    %_61 = trunc i8 %_60 to i1
    br i1 %_61, label %label94, label %label95

label94:
    %_62 = xor i8 0, 1
    %_63 = trunc i8 %_62 to i1
    br i1 %_63, label %label102, label %label103

label102:
    %_64 = xor i8 0, 1
    br label %label104

label104:
    br label %label105

label103:
    br label %label105

label105:
    %_65 = phi i8 [%_64, %label104], [%_62, %label103]
    br label %label96

label96:
    br label %label97

label95:
    br label %label97

label97:
    %_66 = phi i8 [%_65, %label96], [%_60, %label95]
    %_67 = trunc i8 %_66 to i1
    br i1 %_67, label %label91, label %label92

label91:
    call void (i32) @print_int(i32 1)
    br label %label93

label92:
    call void (i32) @print_int(i32 0)
    br label %label93

label93:
    call void (i32) @print_int(i32 2)
    br label %label78

label77:
    call void (i32) @print_int(i32 0)
    br label %label78

label78:
    call void (i32) @print_int(i32 3)
    br label %label63

label62:
    call void (i32) @print_int(i32 0)
    br label %label63

label63:
    call void (i32) @print_int(i32 4)
    br label %label48

label47:
    call void (i32) @print_int(i32 0)
    br label %label48

label48:
    call void (i32) @print_int(i32 5)
    br label %label33

label32:
    call void (i32) @print_int(i32 0)
    br label %label33

label33:


    ret i32 0
}
