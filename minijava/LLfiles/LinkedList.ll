@.LinkedList_vtable = global [0 x i8*] []
@.Element_vtable = global [6 x i8*] [i8* bitcast (i8 (i8*,i32,i32,i8)* @Element.Init to i8*), i8* bitcast (i32 (i8*)* @Element.GetAge to i8*), i8* bitcast (i32 (i8*)* @Element.GetSalary to i8*), i8* bitcast (i8 (i8*)* @Element.GetMarried to i8*), i8* bitcast (i8 (i8*,i8*)* @Element.Equal to i8*), i8* bitcast (i8 (i8*,i32,i32)* @Element.Compare to i8*)]
@.List_vtable = global [10 x i8*] [i8* bitcast (i8 (i8*)* @List.Init to i8*), i8* bitcast (i8 (i8*,i8*,i8*,i8)* @List.InitNew to i8*), i8* bitcast (i8* (i8*,i8*)* @List.Insert to i8*), i8* bitcast (i8 (i8*,i8*)* @List.SetNext to i8*), i8* bitcast (i8* (i8*,i8*)* @List.Delete to i8*), i8* bitcast (i32 (i8*,i8*)* @List.Search to i8*), i8* bitcast (i8 (i8*)* @List.GetEnd to i8*), i8* bitcast (i8* (i8*)* @List.GetElem to i8*), i8* bitcast (i8* (i8*)* @List.GetNext to i8*), i8* bitcast (i8 (i8*)* @List.Print to i8*)]
@.LL_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @LL.Start to i8*)]


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
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.LL_vtable, i32 0, i32 0
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

define i8 @Element.Init(i8* %this, i32 %.v_Age, i32 %.v_Salary, i8 %.v_Married) {
    %v_Age = alloca i32
    store i32 %.v_Age, i32* %v_Age
    %v_Salary = alloca i32
    store i32 %.v_Salary, i32* %v_Salary
    %v_Married = alloca i8
    store i8 %.v_Married, i8* %v_Married
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %v_Age
    store i32 %_2, i32* %_1
    %_3 = getelementptr i8, i8* %this, i32 12
    %_4 = bitcast i8* %_3 to i32*
    %_5 = load i32, i32* %v_Salary
    store i32 %_5, i32* %_4
    %_6 = getelementptr i8, i8* %this, i32 16
    %_7 = bitcast i8* %_6 to i8*
    %_8 = load i8, i8* %v_Married
    store i8 %_8, i8* %_7

    ret i8 1
}

define i32 @Element.GetAge(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %_1

    ret i32 %_2
}

define i32 @Element.GetSalary(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 12
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %_1

    ret i32 %_2
}

define i8 @Element.GetMarried(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 16
    %_1 = bitcast i8* %_0 to i8*
    %_2 = load i8, i8* %_1

    ret i8 %_2
}

define i8 @Element.Equal(i8* %this, i8* %.other) {
    %other = alloca i8*
    store i8* %.other, i8** %other
    %ret_val = alloca i8
    store i8 0, i8* %ret_val
    %aux01 = alloca i32
    store i32 0, i32* %aux01
    %aux02 = alloca i32
    store i32 0, i32* %aux02
    %nt = alloca i32
    store i32 0, i32* %nt
    store i8 1, i8* %ret_val
    %_0 = load i8*, i8** %other
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1
    %_3 = getelementptr i8, i8* %_2, i32 8
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i32 (i8*)*
    %_7 = call i32 %_6(i8* %_0)
    store i32 %_7, i32* %aux01
    %_8 = bitcast i8* %this to i8**
    %_9 = load i8*, i8** %_8
    %_10 = getelementptr i8, i8* %_9, i32 40
    %_11 = bitcast i8* %_10 to i8**
    %_12 = load i8*, i8** %_11
    %_13 = bitcast i8* %_12 to i8 (i8*, i32, i32)*
    %_15 = load i32, i32* %aux01
    %_16 = getelementptr i8, i8* %this, i32 8
    %_17 = bitcast i8* %_16 to i32*
    %_18 = load i32, i32* %_17
    %_14 = call i8 %_13(i8* %this, i32 %_15, i32 %_18)
    %_19 = xor i8 %_14, 1
    %_20 = trunc i8 %_19 to i1
    br i1 %_20, label %label0, label %label1

label0:
    store i8 0, i8* %ret_val
    br label %label2

label1:
    %_21 = load i8*, i8** %other
    %_22 = bitcast i8* %_21 to i8**
    %_23 = load i8*, i8** %_22
    %_24 = getelementptr i8, i8* %_23, i32 16
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = bitcast i8* %_26 to i32 (i8*)*
    %_28 = call i32 %_27(i8* %_21)
    store i32 %_28, i32* %aux02
    %_29 = bitcast i8* %this to i8**
    %_30 = load i8*, i8** %_29
    %_31 = getelementptr i8, i8* %_30, i32 40
    %_32 = bitcast i8* %_31 to i8**
    %_33 = load i8*, i8** %_32
    %_34 = bitcast i8* %_33 to i8 (i8*, i32, i32)*
    %_36 = load i32, i32* %aux02
    %_37 = getelementptr i8, i8* %this, i32 12
    %_38 = bitcast i8* %_37 to i32*
    %_39 = load i32, i32* %_38
    %_35 = call i8 %_34(i8* %this, i32 %_36, i32 %_39)
    %_40 = xor i8 %_35, 1
    %_41 = trunc i8 %_40 to i1
    br i1 %_41, label %label3, label %label4

label3:
    store i8 0, i8* %ret_val
    br label %label5

label4:
    %_42 = getelementptr i8, i8* %this, i32 16
    %_43 = bitcast i8* %_42 to i8*
    %_44 = load i8, i8* %_43
    %_45 = trunc i8 %_44 to i1
    br i1 %_45, label %label6, label %label7

label6:
    %_46 = load i8*, i8** %other
    %_47 = bitcast i8* %_46 to i8**
    %_48 = load i8*, i8** %_47
    %_49 = getelementptr i8, i8* %_48, i32 24
    %_50 = bitcast i8* %_49 to i8**
    %_51 = load i8*, i8** %_50
    %_52 = bitcast i8* %_51 to i8 (i8*)*
    %_53 = call i8 %_52(i8* %_46)
    %_54 = xor i8 %_53, 1
    %_55 = trunc i8 %_54 to i1
    br i1 %_55, label %label9, label %label10

label9:
    store i8 0, i8* %ret_val
    br label %label11

label10:
    store i32 0, i32* %nt
    br label %label11

label11:
    br label %label8

label7:
    %_56 = load i8*, i8** %other
    %_57 = bitcast i8* %_56 to i8**
    %_58 = load i8*, i8** %_57
    %_59 = getelementptr i8, i8* %_58, i32 24
    %_60 = bitcast i8* %_59 to i8**
    %_61 = load i8*, i8** %_60
    %_62 = bitcast i8* %_61 to i8 (i8*)*
    %_63 = call i8 %_62(i8* %_56)
    %_64 = trunc i8 %_63 to i1
    br i1 %_64, label %label12, label %label13

label12:
    store i8 0, i8* %ret_val
    br label %label14

label13:
    store i32 0, i32* %nt
    br label %label14

label14:
    br label %label8

label8:
    br label %label5

label5:
    br label %label2

label2:
    %_65 = load i8, i8* %ret_val

    ret i8 %_65
}

define i8 @Element.Compare(i8* %this, i32 %.num1, i32 %.num2) {
    %num1 = alloca i32
    store i32 %.num1, i32* %num1
    %num2 = alloca i32
    store i32 %.num2, i32* %num2
    %retval = alloca i8
    store i8 0, i8* %retval
    %aux02 = alloca i32
    store i32 0, i32* %aux02
    store i8 0, i8* %retval
    %_0 = load i32, i32* %num2
    %_1 = add i32 %_0, 1
    store i32 %_1, i32* %aux02
    %_2 = load i32, i32* %num1
    %_3 = load i32, i32* %num2
    %_4 = icmp slt i32 %_2, %_3
    %_5 = zext i1 %_4 to i8
    %_6 = trunc i8 %_5 to i1
    br i1 %_6, label %label0, label %label1

label0:
    store i8 0, i8* %retval
    br label %label2

label1:
    %_7 = load i32, i32* %num1
    %_8 = load i32, i32* %aux02
    %_9 = icmp slt i32 %_7, %_8
    %_10 = zext i1 %_9 to i8
    %_11 = xor i8 %_10, 1
    %_12 = trunc i8 %_11 to i1
    br i1 %_12, label %label3, label %label4

label3:
    store i8 0, i8* %retval
    br label %label5

label4:
    store i8 1, i8* %retval
    br label %label5

label5:
    br label %label2

label2:
    %_13 = load i8, i8* %retval

    ret i8 %_13
}

define i8 @List.Init(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 24
    %_1 = bitcast i8* %_0 to i8*
    store i8 1, i8* %_1

    ret i8 1
}

define i8 @List.InitNew(i8* %this, i8* %.v_elem, i8* %.v_next, i8 %.v_end) {
    %v_elem = alloca i8*
    store i8* %.v_elem, i8** %v_elem
    %v_next = alloca i8*
    store i8* %.v_next, i8** %v_next
    %v_end = alloca i8
    store i8 %.v_end, i8* %v_end
    %_0 = getelementptr i8, i8* %this, i32 24
    %_1 = bitcast i8* %_0 to i8*
    %_2 = load i8, i8* %v_end
    store i8 %_2, i8* %_1
    %_3 = getelementptr i8, i8* %this, i32 8
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %v_elem
    store i8* %_5, i8** %_4
    %_6 = getelementptr i8, i8* %this, i32 16
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %v_next
    store i8* %_8, i8** %_7

    ret i8 1
}

define i8* @List.Insert(i8* %this, i8* %.new_elem) {
    %new_elem = alloca i8*
    store i8* %.new_elem, i8** %new_elem
    %ret_val = alloca i8
    store i8 0, i8* %ret_val
    %aux03 = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 25)
    store i8* %_0, i8** %aux03
    %aux02 = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 25)
    store i8* %_1, i8** %aux02
    store i8* %this, i8** %aux03
    %_2 = call i8* @calloc(i32 1, i32 25)
    %_3 = bitcast i8* %_2 to i8**
    %_4 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0
    %_5 = bitcast i8** %_4 to i8*
    store i8* %_5, i8** %_3
    store i8* %_2, i8** %aux02
    %_6 = load i8*, i8** %aux02
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %_7
    %_9 = getelementptr i8, i8* %_8, i32 8
    %_10 = bitcast i8* %_9 to i8**
    %_11 = load i8*, i8** %_10
    %_12 = bitcast i8* %_11 to i8 (i8*, i8*, i8*, i8)*
    %_14 = load i8*, i8** %new_elem
    %_15 = load i8*, i8** %aux03
    %_13 = call i8 %_12(i8* %_6, i8* %_14, i8* %_15, i8 0)
    store i8 %_13, i8* %ret_val
    %_16 = load i8*, i8** %aux02

    ret i8* %_16
}

define i8 @List.SetNext(i8* %this, i8* %.v_next) {
    %v_next = alloca i8*
    store i8* %.v_next, i8** %v_next
    %_0 = getelementptr i8, i8* %this, i32 16
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %v_next
    store i8* %_2, i8** %_1

    ret i8 1
}

define i8* @List.Delete(i8* %this, i8* %.e) {
    %e = alloca i8*
    store i8* %.e, i8** %e
    %my_head = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 25)
    store i8* %_0, i8** %my_head
    %ret_val = alloca i8
    store i8 0, i8* %ret_val
    %aux05 = alloca i8
    store i8 0, i8* %aux05
    %aux01 = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 25)
    store i8* %_1, i8** %aux01
    %prev = alloca i8*
    %_2 = call i8* @calloc(i32 0, i32 25)
    store i8* %_2, i8** %prev
    %var_end = alloca i8
    store i8 0, i8* %var_end
    %var_elem = alloca i8*
    %_3 = call i8* @calloc(i32 0, i32 17)
    store i8* %_3, i8** %var_elem
    %aux04 = alloca i32
    store i32 0, i32* %aux04
    %nt = alloca i32
    store i32 0, i32* %nt
    store i8* %this, i8** %my_head
    store i8 0, i8* %ret_val
    %_4 = sub i32 0, 1
    store i32 %_4, i32* %aux04
    store i8* %this, i8** %aux01
    store i8* %this, i8** %prev
    %_5 = getelementptr i8, i8* %this, i32 24
    %_6 = bitcast i8* %_5 to i8*
    %_7 = load i8, i8* %_6
    store i8 %_7, i8* %var_end
    %_8 = getelementptr i8, i8* %this, i32 8
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    store i8* %_10, i8** %var_elem
    br label %label1

label1:
    %_11 = load i8, i8* %var_end
    %_12 = xor i8 %_11, 1
    %_13 = trunc i8 %_12 to i1
    br i1 %_13, label %label3, label %label4

label3:
    %_14 = load i8, i8* %ret_val
    %_15 = xor i8 %_14, 1
    br label %label5

label5:
    br label %label6

label4:
    br label %label6

label6:
    %_16 = phi i8 [%_15, %label5], [%_12, %label4]
    %_17 = trunc i8 %_16 to i1
    br i1 %_17, label %label0, label %label2

label0:
    %_18 = load i8*, i8** %e
    %_19 = bitcast i8* %_18 to i8**
    %_20 = load i8*, i8** %_19
    %_21 = getelementptr i8, i8* %_20, i32 32
    %_22 = bitcast i8* %_21 to i8**
    %_23 = load i8*, i8** %_22
    %_24 = bitcast i8* %_23 to i8 (i8*, i8*)*
    %_26 = load i8*, i8** %var_elem
    %_25 = call i8 %_24(i8* %_18, i8* %_26)
    %_27 = trunc i8 %_25 to i1
    br i1 %_27, label %label7, label %label8

label7:
    store i8 1, i8* %ret_val
    %_28 = load i32, i32* %aux04
    %_29 = icmp slt i32 %_28, 0
    %_30 = zext i1 %_29 to i8
    %_31 = trunc i8 %_30 to i1
    br i1 %_31, label %label10, label %label11

label10:
    %_32 = load i8*, i8** %aux01
    %_33 = bitcast i8* %_32 to i8**
    %_34 = load i8*, i8** %_33
    %_35 = getelementptr i8, i8* %_34, i32 64
    %_36 = bitcast i8* %_35 to i8**
    %_37 = load i8*, i8** %_36
    %_38 = bitcast i8* %_37 to i8* (i8*)*
    %_39 = call i8* %_38(i8* %_32)
    store i8* %_39, i8** %my_head
    br label %label12

label11:
    %_40 = sub i32 0, 555
    call void (i32) @print_int(i32 %_40)
    %_41 = load i8*, i8** %prev
    %_42 = bitcast i8* %_41 to i8**
    %_43 = load i8*, i8** %_42
    %_44 = getelementptr i8, i8* %_43, i32 24
    %_45 = bitcast i8* %_44 to i8**
    %_46 = load i8*, i8** %_45
    %_47 = bitcast i8* %_46 to i8 (i8*, i8*)*
    %_49 = load i8*, i8** %aux01
    %_50 = bitcast i8* %_49 to i8**
    %_51 = load i8*, i8** %_50
    %_52 = getelementptr i8, i8* %_51, i32 64
    %_53 = bitcast i8* %_52 to i8**
    %_54 = load i8*, i8** %_53
    %_55 = bitcast i8* %_54 to i8* (i8*)*
    %_56 = call i8* %_55(i8* %_49)
    %_48 = call i8 %_47(i8* %_41, i8* %_56)
    store i8 %_48, i8* %aux05
    %_57 = sub i32 0, 555
    call void (i32) @print_int(i32 %_57)
    br label %label12

label12:
    br label %label9

label8:
    store i32 0, i32* %nt
    br label %label9

label9:
    %_58 = load i8, i8* %ret_val
    %_59 = xor i8 %_58, 1
    %_60 = trunc i8 %_59 to i1
    br i1 %_60, label %label13, label %label14

label13:
    %_61 = load i8*, i8** %aux01
    store i8* %_61, i8** %prev
    %_62 = load i8*, i8** %aux01
    %_63 = bitcast i8* %_62 to i8**
    %_64 = load i8*, i8** %_63
    %_65 = getelementptr i8, i8* %_64, i32 64
    %_66 = bitcast i8* %_65 to i8**
    %_67 = load i8*, i8** %_66
    %_68 = bitcast i8* %_67 to i8* (i8*)*
    %_69 = call i8* %_68(i8* %_62)
    store i8* %_69, i8** %aux01
    %_70 = load i8*, i8** %aux01
    %_71 = bitcast i8* %_70 to i8**
    %_72 = load i8*, i8** %_71
    %_73 = getelementptr i8, i8* %_72, i32 48
    %_74 = bitcast i8* %_73 to i8**
    %_75 = load i8*, i8** %_74
    %_76 = bitcast i8* %_75 to i8 (i8*)*
    %_77 = call i8 %_76(i8* %_70)
    store i8 %_77, i8* %var_end
    %_78 = load i8*, i8** %aux01
    %_79 = bitcast i8* %_78 to i8**
    %_80 = load i8*, i8** %_79
    %_81 = getelementptr i8, i8* %_80, i32 56
    %_82 = bitcast i8* %_81 to i8**
    %_83 = load i8*, i8** %_82
    %_84 = bitcast i8* %_83 to i8* (i8*)*
    %_85 = call i8* %_84(i8* %_78)
    store i8* %_85, i8** %var_elem
    store i32 1, i32* %aux04
    br label %label15

label14:
    store i32 0, i32* %nt
    br label %label15

label15:
    br label %label1

label2:
    %_86 = load i8*, i8** %my_head

    ret i8* %_86
}

define i32 @List.Search(i8* %this, i8* %.e) {
    %e = alloca i8*
    store i8* %.e, i8** %e
    %int_ret_val = alloca i32
    store i32 0, i32* %int_ret_val
    %aux01 = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 25)
    store i8* %_0, i8** %aux01
    %var_elem = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 17)
    store i8* %_1, i8** %var_elem
    %var_end = alloca i8
    store i8 0, i8* %var_end
    %nt = alloca i32
    store i32 0, i32* %nt
    store i32 0, i32* %int_ret_val
    store i8* %this, i8** %aux01
    %_2 = getelementptr i8, i8* %this, i32 24
    %_3 = bitcast i8* %_2 to i8*
    %_4 = load i8, i8* %_3
    store i8 %_4, i8* %var_end
    %_5 = getelementptr i8, i8* %this, i32 8
    %_6 = bitcast i8* %_5 to i8**
    %_7 = load i8*, i8** %_6
    store i8* %_7, i8** %var_elem
    br label %label1

label1:
    %_8 = load i8, i8* %var_end
    %_9 = xor i8 %_8, 1
    %_10 = trunc i8 %_9 to i1
    br i1 %_10, label %label0, label %label2

label0:
    %_11 = load i8*, i8** %e
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = getelementptr i8, i8* %_13, i32 32
    %_15 = bitcast i8* %_14 to i8**
    %_16 = load i8*, i8** %_15
    %_17 = bitcast i8* %_16 to i8 (i8*, i8*)*
    %_19 = load i8*, i8** %var_elem
    %_18 = call i8 %_17(i8* %_11, i8* %_19)
    %_20 = trunc i8 %_18 to i1
    br i1 %_20, label %label3, label %label4

label3:
    store i32 1, i32* %int_ret_val
    br label %label5

label4:
    store i32 0, i32* %nt
    br label %label5

label5:
    %_21 = load i8*, i8** %aux01
    %_22 = bitcast i8* %_21 to i8**
    %_23 = load i8*, i8** %_22
    %_24 = getelementptr i8, i8* %_23, i32 64
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = bitcast i8* %_26 to i8* (i8*)*
    %_28 = call i8* %_27(i8* %_21)
    store i8* %_28, i8** %aux01
    %_29 = load i8*, i8** %aux01
    %_30 = bitcast i8* %_29 to i8**
    %_31 = load i8*, i8** %_30
    %_32 = getelementptr i8, i8* %_31, i32 48
    %_33 = bitcast i8* %_32 to i8**
    %_34 = load i8*, i8** %_33
    %_35 = bitcast i8* %_34 to i8 (i8*)*
    %_36 = call i8 %_35(i8* %_29)
    store i8 %_36, i8* %var_end
    %_37 = load i8*, i8** %aux01
    %_38 = bitcast i8* %_37 to i8**
    %_39 = load i8*, i8** %_38
    %_40 = getelementptr i8, i8* %_39, i32 56
    %_41 = bitcast i8* %_40 to i8**
    %_42 = load i8*, i8** %_41
    %_43 = bitcast i8* %_42 to i8* (i8*)*
    %_44 = call i8* %_43(i8* %_37)
    store i8* %_44, i8** %var_elem
    br label %label1

label2:
    %_45 = load i32, i32* %int_ret_val

    ret i32 %_45
}

define i8 @List.GetEnd(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 24
    %_1 = bitcast i8* %_0 to i8*
    %_2 = load i8, i8* %_1

    ret i8 %_2
}

define i8* @List.GetElem(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1

    ret i8* %_2
}

define i8* @List.GetNext(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 16
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %_1

    ret i8* %_2
}

define i8 @List.Print(i8* %this) {
    %aux01 = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 25)
    store i8* %_0, i8** %aux01
    %var_end = alloca i8
    store i8 0, i8* %var_end
    %var_elem = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 17)
    store i8* %_1, i8** %var_elem
    store i8* %this, i8** %aux01
    %_2 = getelementptr i8, i8* %this, i32 24
    %_3 = bitcast i8* %_2 to i8*
    %_4 = load i8, i8* %_3
    store i8 %_4, i8* %var_end
    %_5 = getelementptr i8, i8* %this, i32 8
    %_6 = bitcast i8* %_5 to i8**
    %_7 = load i8*, i8** %_6
    store i8* %_7, i8** %var_elem
    br label %label1

label1:
    %_8 = load i8, i8* %var_end
    %_9 = xor i8 %_8, 1
    %_10 = trunc i8 %_9 to i1
    br i1 %_10, label %label0, label %label2

label0:
    %_11 = load i8*, i8** %var_elem
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = getelementptr i8, i8* %_13, i32 8
    %_15 = bitcast i8* %_14 to i8**
    %_16 = load i8*, i8** %_15
    %_17 = bitcast i8* %_16 to i32 (i8*)*
    %_18 = call i32 %_17(i8* %_11)
    call void (i32) @print_int(i32 %_18)
    %_19 = load i8*, i8** %aux01
    %_20 = bitcast i8* %_19 to i8**
    %_21 = load i8*, i8** %_20
    %_22 = getelementptr i8, i8* %_21, i32 64
    %_23 = bitcast i8* %_22 to i8**
    %_24 = load i8*, i8** %_23
    %_25 = bitcast i8* %_24 to i8* (i8*)*
    %_26 = call i8* %_25(i8* %_19)
    store i8* %_26, i8** %aux01
    %_27 = load i8*, i8** %aux01
    %_28 = bitcast i8* %_27 to i8**
    %_29 = load i8*, i8** %_28
    %_30 = getelementptr i8, i8* %_29, i32 48
    %_31 = bitcast i8* %_30 to i8**
    %_32 = load i8*, i8** %_31
    %_33 = bitcast i8* %_32 to i8 (i8*)*
    %_34 = call i8 %_33(i8* %_27)
    store i8 %_34, i8* %var_end
    %_35 = load i8*, i8** %aux01
    %_36 = bitcast i8* %_35 to i8**
    %_37 = load i8*, i8** %_36
    %_38 = getelementptr i8, i8* %_37, i32 56
    %_39 = bitcast i8* %_38 to i8**
    %_40 = load i8*, i8** %_39
    %_41 = bitcast i8* %_40 to i8* (i8*)*
    %_42 = call i8* %_41(i8* %_35)
    store i8* %_42, i8** %var_elem
    br label %label1

label2:

    ret i8 1
}

define i32 @LL.Start(i8* %this) {
    %head = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 25)
    store i8* %_0, i8** %head
    %last_elem = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 25)
    store i8* %_1, i8** %last_elem
    %aux01 = alloca i8
    store i8 0, i8* %aux01
    %el01 = alloca i8*
    %_2 = call i8* @calloc(i32 0, i32 17)
    store i8* %_2, i8** %el01
    %el02 = alloca i8*
    %_3 = call i8* @calloc(i32 0, i32 17)
    store i8* %_3, i8** %el02
    %el03 = alloca i8*
    %_4 = call i8* @calloc(i32 0, i32 17)
    store i8* %_4, i8** %el03
    %_5 = call i8* @calloc(i32 1, i32 25)
    %_6 = bitcast i8* %_5 to i8**
    %_7 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0
    %_8 = bitcast i8** %_7 to i8*
    store i8* %_8, i8** %_6
    store i8* %_5, i8** %last_elem
    %_9 = load i8*, i8** %last_elem
    %_10 = bitcast i8* %_9 to i8**
    %_11 = load i8*, i8** %_10
    %_12 = getelementptr i8, i8* %_11, i32 0
    %_13 = bitcast i8* %_12 to i8**
    %_14 = load i8*, i8** %_13
    %_15 = bitcast i8* %_14 to i8 (i8*)*
    %_16 = call i8 %_15(i8* %_9)
    store i8 %_16, i8* %aux01
    %_17 = load i8*, i8** %last_elem
    store i8* %_17, i8** %head
    %_18 = load i8*, i8** %head
    %_19 = bitcast i8* %_18 to i8**
    %_20 = load i8*, i8** %_19
    %_21 = getelementptr i8, i8* %_20, i32 0
    %_22 = bitcast i8* %_21 to i8**
    %_23 = load i8*, i8** %_22
    %_24 = bitcast i8* %_23 to i8 (i8*)*
    %_25 = call i8 %_24(i8* %_18)
    store i8 %_25, i8* %aux01
    %_26 = load i8*, i8** %head
    %_27 = bitcast i8* %_26 to i8**
    %_28 = load i8*, i8** %_27
    %_29 = getelementptr i8, i8* %_28, i32 72
    %_30 = bitcast i8* %_29 to i8**
    %_31 = load i8*, i8** %_30
    %_32 = bitcast i8* %_31 to i8 (i8*)*
    %_33 = call i8 %_32(i8* %_26)
    store i8 %_33, i8* %aux01
    %_34 = call i8* @calloc(i32 1, i32 17)
    %_35 = bitcast i8* %_34 to i8**
    %_36 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    %_37 = bitcast i8** %_36 to i8*
    store i8* %_37, i8** %_35
    store i8* %_34, i8** %el01
    %_38 = load i8*, i8** %el01
    %_39 = bitcast i8* %_38 to i8**
    %_40 = load i8*, i8** %_39
    %_41 = getelementptr i8, i8* %_40, i32 0
    %_42 = bitcast i8* %_41 to i8**
    %_43 = load i8*, i8** %_42
    %_44 = bitcast i8* %_43 to i8 (i8*, i32, i32, i8)*
    %_45 = call i8 %_44(i8* %_38, i32 25, i32 37000, i8 0)
    store i8 %_45, i8* %aux01
    %_46 = load i8*, i8** %head
    %_47 = bitcast i8* %_46 to i8**
    %_48 = load i8*, i8** %_47
    %_49 = getelementptr i8, i8* %_48, i32 16
    %_50 = bitcast i8* %_49 to i8**
    %_51 = load i8*, i8** %_50
    %_52 = bitcast i8* %_51 to i8* (i8*, i8*)*
    %_54 = load i8*, i8** %el01
    %_53 = call i8* %_52(i8* %_46, i8* %_54)
    store i8* %_53, i8** %head
    %_55 = load i8*, i8** %head
    %_56 = bitcast i8* %_55 to i8**
    %_57 = load i8*, i8** %_56
    %_58 = getelementptr i8, i8* %_57, i32 72
    %_59 = bitcast i8* %_58 to i8**
    %_60 = load i8*, i8** %_59
    %_61 = bitcast i8* %_60 to i8 (i8*)*
    %_62 = call i8 %_61(i8* %_55)
    store i8 %_62, i8* %aux01
    call void (i32) @print_int(i32 10000000)
    %_63 = call i8* @calloc(i32 1, i32 17)
    %_64 = bitcast i8* %_63 to i8**
    %_65 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    %_66 = bitcast i8** %_65 to i8*
    store i8* %_66, i8** %_64
    store i8* %_63, i8** %el01
    %_67 = load i8*, i8** %el01
    %_68 = bitcast i8* %_67 to i8**
    %_69 = load i8*, i8** %_68
    %_70 = getelementptr i8, i8* %_69, i32 0
    %_71 = bitcast i8* %_70 to i8**
    %_72 = load i8*, i8** %_71
    %_73 = bitcast i8* %_72 to i8 (i8*, i32, i32, i8)*
    %_74 = call i8 %_73(i8* %_67, i32 39, i32 42000, i8 1)
    store i8 %_74, i8* %aux01
    %_75 = load i8*, i8** %el01
    store i8* %_75, i8** %el02
    %_76 = load i8*, i8** %head
    %_77 = bitcast i8* %_76 to i8**
    %_78 = load i8*, i8** %_77
    %_79 = getelementptr i8, i8* %_78, i32 16
    %_80 = bitcast i8* %_79 to i8**
    %_81 = load i8*, i8** %_80
    %_82 = bitcast i8* %_81 to i8* (i8*, i8*)*
    %_84 = load i8*, i8** %el01
    %_83 = call i8* %_82(i8* %_76, i8* %_84)
    store i8* %_83, i8** %head
    %_85 = load i8*, i8** %head
    %_86 = bitcast i8* %_85 to i8**
    %_87 = load i8*, i8** %_86
    %_88 = getelementptr i8, i8* %_87, i32 72
    %_89 = bitcast i8* %_88 to i8**
    %_90 = load i8*, i8** %_89
    %_91 = bitcast i8* %_90 to i8 (i8*)*
    %_92 = call i8 %_91(i8* %_85)
    store i8 %_92, i8* %aux01
    call void (i32) @print_int(i32 10000000)
    %_93 = call i8* @calloc(i32 1, i32 17)
    %_94 = bitcast i8* %_93 to i8**
    %_95 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    %_96 = bitcast i8** %_95 to i8*
    store i8* %_96, i8** %_94
    store i8* %_93, i8** %el01
    %_97 = load i8*, i8** %el01
    %_98 = bitcast i8* %_97 to i8**
    %_99 = load i8*, i8** %_98
    %_100 = getelementptr i8, i8* %_99, i32 0
    %_101 = bitcast i8* %_100 to i8**
    %_102 = load i8*, i8** %_101
    %_103 = bitcast i8* %_102 to i8 (i8*, i32, i32, i8)*
    %_104 = call i8 %_103(i8* %_97, i32 22, i32 34000, i8 0)
    store i8 %_104, i8* %aux01
    %_105 = load i8*, i8** %head
    %_106 = bitcast i8* %_105 to i8**
    %_107 = load i8*, i8** %_106
    %_108 = getelementptr i8, i8* %_107, i32 16
    %_109 = bitcast i8* %_108 to i8**
    %_110 = load i8*, i8** %_109
    %_111 = bitcast i8* %_110 to i8* (i8*, i8*)*
    %_113 = load i8*, i8** %el01
    %_112 = call i8* %_111(i8* %_105, i8* %_113)
    store i8* %_112, i8** %head
    %_114 = load i8*, i8** %head
    %_115 = bitcast i8* %_114 to i8**
    %_116 = load i8*, i8** %_115
    %_117 = getelementptr i8, i8* %_116, i32 72
    %_118 = bitcast i8* %_117 to i8**
    %_119 = load i8*, i8** %_118
    %_120 = bitcast i8* %_119 to i8 (i8*)*
    %_121 = call i8 %_120(i8* %_114)
    store i8 %_121, i8* %aux01
    %_122 = call i8* @calloc(i32 1, i32 17)
    %_123 = bitcast i8* %_122 to i8**
    %_124 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    %_125 = bitcast i8** %_124 to i8*
    store i8* %_125, i8** %_123
    store i8* %_122, i8** %el03
    %_126 = load i8*, i8** %el03
    %_127 = bitcast i8* %_126 to i8**
    %_128 = load i8*, i8** %_127
    %_129 = getelementptr i8, i8* %_128, i32 0
    %_130 = bitcast i8* %_129 to i8**
    %_131 = load i8*, i8** %_130
    %_132 = bitcast i8* %_131 to i8 (i8*, i32, i32, i8)*
    %_133 = call i8 %_132(i8* %_126, i32 27, i32 34000, i8 0)
    store i8 %_133, i8* %aux01
    %_134 = load i8*, i8** %head
    %_135 = bitcast i8* %_134 to i8**
    %_136 = load i8*, i8** %_135
    %_137 = getelementptr i8, i8* %_136, i32 40
    %_138 = bitcast i8* %_137 to i8**
    %_139 = load i8*, i8** %_138
    %_140 = bitcast i8* %_139 to i32 (i8*, i8*)*
    %_142 = load i8*, i8** %el02
    %_141 = call i32 %_140(i8* %_134, i8* %_142)
    call void (i32) @print_int(i32 %_141)
    %_143 = load i8*, i8** %head
    %_144 = bitcast i8* %_143 to i8**
    %_145 = load i8*, i8** %_144
    %_146 = getelementptr i8, i8* %_145, i32 40
    %_147 = bitcast i8* %_146 to i8**
    %_148 = load i8*, i8** %_147
    %_149 = bitcast i8* %_148 to i32 (i8*, i8*)*
    %_151 = load i8*, i8** %el03
    %_150 = call i32 %_149(i8* %_143, i8* %_151)
    call void (i32) @print_int(i32 %_150)
    call void (i32) @print_int(i32 10000000)
    %_152 = call i8* @calloc(i32 1, i32 17)
    %_153 = bitcast i8* %_152 to i8**
    %_154 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    %_155 = bitcast i8** %_154 to i8*
    store i8* %_155, i8** %_153
    store i8* %_152, i8** %el01
    %_156 = load i8*, i8** %el01
    %_157 = bitcast i8* %_156 to i8**
    %_158 = load i8*, i8** %_157
    %_159 = getelementptr i8, i8* %_158, i32 0
    %_160 = bitcast i8* %_159 to i8**
    %_161 = load i8*, i8** %_160
    %_162 = bitcast i8* %_161 to i8 (i8*, i32, i32, i8)*
    %_163 = call i8 %_162(i8* %_156, i32 28, i32 35000, i8 0)
    store i8 %_163, i8* %aux01
    %_164 = load i8*, i8** %head
    %_165 = bitcast i8* %_164 to i8**
    %_166 = load i8*, i8** %_165
    %_167 = getelementptr i8, i8* %_166, i32 16
    %_168 = bitcast i8* %_167 to i8**
    %_169 = load i8*, i8** %_168
    %_170 = bitcast i8* %_169 to i8* (i8*, i8*)*
    %_172 = load i8*, i8** %el01
    %_171 = call i8* %_170(i8* %_164, i8* %_172)
    store i8* %_171, i8** %head
    %_173 = load i8*, i8** %head
    %_174 = bitcast i8* %_173 to i8**
    %_175 = load i8*, i8** %_174
    %_176 = getelementptr i8, i8* %_175, i32 72
    %_177 = bitcast i8* %_176 to i8**
    %_178 = load i8*, i8** %_177
    %_179 = bitcast i8* %_178 to i8 (i8*)*
    %_180 = call i8 %_179(i8* %_173)
    store i8 %_180, i8* %aux01
    call void (i32) @print_int(i32 2220000)
    %_181 = load i8*, i8** %head
    %_182 = bitcast i8* %_181 to i8**
    %_183 = load i8*, i8** %_182
    %_184 = getelementptr i8, i8* %_183, i32 32
    %_185 = bitcast i8* %_184 to i8**
    %_186 = load i8*, i8** %_185
    %_187 = bitcast i8* %_186 to i8* (i8*, i8*)*
    %_189 = load i8*, i8** %el02
    %_188 = call i8* %_187(i8* %_181, i8* %_189)
    store i8* %_188, i8** %head
    %_190 = load i8*, i8** %head
    %_191 = bitcast i8* %_190 to i8**
    %_192 = load i8*, i8** %_191
    %_193 = getelementptr i8, i8* %_192, i32 72
    %_194 = bitcast i8* %_193 to i8**
    %_195 = load i8*, i8** %_194
    %_196 = bitcast i8* %_195 to i8 (i8*)*
    %_197 = call i8 %_196(i8* %_190)
    store i8 %_197, i8* %aux01
    call void (i32) @print_int(i32 33300000)
    %_198 = load i8*, i8** %head
    %_199 = bitcast i8* %_198 to i8**
    %_200 = load i8*, i8** %_199
    %_201 = getelementptr i8, i8* %_200, i32 32
    %_202 = bitcast i8* %_201 to i8**
    %_203 = load i8*, i8** %_202
    %_204 = bitcast i8* %_203 to i8* (i8*, i8*)*
    %_206 = load i8*, i8** %el01
    %_205 = call i8* %_204(i8* %_198, i8* %_206)
    store i8* %_205, i8** %head
    %_207 = load i8*, i8** %head
    %_208 = bitcast i8* %_207 to i8**
    %_209 = load i8*, i8** %_208
    %_210 = getelementptr i8, i8* %_209, i32 72
    %_211 = bitcast i8* %_210 to i8**
    %_212 = load i8*, i8** %_211
    %_213 = bitcast i8* %_212 to i8 (i8*)*
    %_214 = call i8 %_213(i8* %_207)
    store i8 %_214, i8* %aux01
    call void (i32) @print_int(i32 44440000)

    ret i32 0
}
