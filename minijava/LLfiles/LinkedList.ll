@.LinkedList_vtable = global [0 x i8*] []
@.Element_vtable = global [6 x i8*] [i8* bitcast (i1 (i8*,i32,i32,i1)* @Element.Init to i8*), i8* bitcast (i32 (i8*)* @Element.GetAge to i8*), i8* bitcast (i32 (i8*)* @Element.GetSalary to i8*), i8* bitcast (i1 (i8*)* @Element.GetMarried to i8*), i8* bitcast (i1 (i8*,i8*)* @Element.Equal to i8*), i8* bitcast (i1 (i8*,i32,i32)* @Element.Compare to i8*)]
@.List_vtable = global [10 x i8*] [i8* bitcast (i1 (i8*)* @List.Init to i8*), i8* bitcast (i1 (i8*,i8*,i8*,i1)* @List.InitNew to i8*), i8* bitcast (i8* (i8*,i8*)* @List.Insert to i8*), i8* bitcast (i1 (i8*,i8*)* @List.SetNext to i8*), i8* bitcast (i8* (i8*,i8*)* @List.Delete to i8*), i8* bitcast (i32 (i8*,i8*)* @List.Search to i8*), i8* bitcast (i1 (i8*)* @List.GetEnd to i8*), i8* bitcast (i8* (i8*)* @List.GetElem to i8*), i8* bitcast (i8* (i8*)* @List.GetNext to i8*), i8* bitcast (i1 (i8*)* @List.Print to i8*)]
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

define i1 @Element.Init(i8* %this, i32 %.v_Age, i32 %.v_Salary, i1 %.v_Married) {
    %v_Age = alloca i32
    store i32 %.v_Age, i32* %v_Age
    %v_Salary = alloca i32
    store i32 %.v_Salary, i32* %v_Salary
    %v_Married = alloca i1
    store i1 %.v_Married, i1* %v_Married
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %v_Age
    store i32 %_2, i32* %_1
    %_3 = getelementptr i8, i8* %this, i32 12
    %_4 = bitcast i8* %_3 to i32*
    %_5 = load i32, i32* %v_Salary
    store i32 %_5, i32* %_4
    %_6 = getelementptr i8, i8* %this, i32 16
    %_7 = bitcast i8* %_6 to i1*
    %_8 = load i1, i1* %v_Married
    store i1 %_8, i1* %_7

    ret i1 1
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

define i1 @Element.GetMarried(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 16
    %_1 = bitcast i8* %_0 to i1*
    %_2 = load i1, i1* %_1

    ret i1 %_2
}

define i1 @Element.Equal(i8* %this, i8* %.other) {
    %other = alloca i8*
    store i8* %.other, i8** %other
    %ret_val = alloca i1
    %aux01 = alloca i32
    %aux02 = alloca i32
    %nt = alloca i32
    store i1 1, i1* %ret_val
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
    %_13 = bitcast i8* %_12 to i1 (i8*, i32, i32)*
    %_15 = load i32, i32* %aux01
    %_16 = getelementptr i8, i8* %this, i32 8
    %_17 = bitcast i8* %_16 to i32*
    %_18 = load i32, i32* %_17
    %_14 = call i1 %_13(i8* %this, i32 %_15, i32 %_18)
    %_19 = xor i1 %_14, 1
    br i1 %_19, label %label0, label %label1

label0:
    store i1 0, i1* %ret_val
    br label %label2

label1:
    %_20 = load i8*, i8** %other
    %_21 = bitcast i8* %_20 to i8**
    %_22 = load i8*, i8** %_21
    %_23 = getelementptr i8, i8* %_22, i32 16
    %_24 = bitcast i8* %_23 to i8**
    %_25 = load i8*, i8** %_24
    %_26 = bitcast i8* %_25 to i32 (i8*)*
    %_27 = call i32 %_26(i8* %_20)
    store i32 %_27, i32* %aux02
    %_28 = bitcast i8* %this to i8**
    %_29 = load i8*, i8** %_28
    %_30 = getelementptr i8, i8* %_29, i32 40
    %_31 = bitcast i8* %_30 to i8**
    %_32 = load i8*, i8** %_31
    %_33 = bitcast i8* %_32 to i1 (i8*, i32, i32)*
    %_35 = load i32, i32* %aux02
    %_36 = getelementptr i8, i8* %this, i32 12
    %_37 = bitcast i8* %_36 to i32*
    %_38 = load i32, i32* %_37
    %_34 = call i1 %_33(i8* %this, i32 %_35, i32 %_38)
    %_39 = xor i1 %_34, 1
    br i1 %_39, label %label3, label %label4

label3:
    store i1 0, i1* %ret_val
    br label %label5

label4:
    %_40 = getelementptr i8, i8* %this, i32 16
    %_41 = bitcast i8* %_40 to i1*
    %_42 = load i1, i1* %_41
    br i1 %_42, label %label6, label %label7

label6:
    %_43 = load i8*, i8** %other
    %_44 = bitcast i8* %_43 to i8**
    %_45 = load i8*, i8** %_44
    %_46 = getelementptr i8, i8* %_45, i32 24
    %_47 = bitcast i8* %_46 to i8**
    %_48 = load i8*, i8** %_47
    %_49 = bitcast i8* %_48 to i1 (i8*)*
    %_50 = call i1 %_49(i8* %_43)
    %_51 = xor i1 %_50, 1
    br i1 %_51, label %label9, label %label10

label9:
    store i1 0, i1* %ret_val
    br label %label11

label10:
    store i32 0, i32* %nt
    br label %label11

label11:
    br label %label8

label7:
    %_52 = load i8*, i8** %other
    %_53 = bitcast i8* %_52 to i8**
    %_54 = load i8*, i8** %_53
    %_55 = getelementptr i8, i8* %_54, i32 24
    %_56 = bitcast i8* %_55 to i8**
    %_57 = load i8*, i8** %_56
    %_58 = bitcast i8* %_57 to i1 (i8*)*
    %_59 = call i1 %_58(i8* %_52)
    br i1 %_59, label %label12, label %label13

label12:
    store i1 0, i1* %ret_val
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
    %_60 = load i1, i1* %ret_val

    ret i1 %_60
}

define i1 @Element.Compare(i8* %this, i32 %.num1, i32 %.num2) {
    %num1 = alloca i32
    store i32 %.num1, i32* %num1
    %num2 = alloca i32
    store i32 %.num2, i32* %num2
    %retval = alloca i1
    %aux02 = alloca i32
    store i1 0, i1* %retval
    %_0 = load i32, i32* %num2
    %_1 = add i32 %_0, 1
    store i32 %_1, i32* %aux02
    %_2 = load i32, i32* %num1
    %_3 = load i32, i32* %num2
    %_4 = icmp slt i32 %_2, %_3
    br i1 %_4, label %label0, label %label1

label0:
    store i1 0, i1* %retval
    br label %label2

label1:
    %_5 = load i32, i32* %num1
    %_6 = load i32, i32* %aux02
    %_7 = icmp slt i32 %_5, %_6
    %_8 = xor i1 %_7, 1
    br i1 %_8, label %label3, label %label4

label3:
    store i1 0, i1* %retval
    br label %label5

label4:
    store i1 1, i1* %retval
    br label %label5

label5:
    br label %label2

label2:
    %_9 = load i1, i1* %retval

    ret i1 %_9
}

define i1 @List.Init(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 24
    %_1 = bitcast i8* %_0 to i1*
    store i1 1, i1* %_1

    ret i1 1
}

define i1 @List.InitNew(i8* %this, i8* %.v_elem, i8* %.v_next, i1 %.v_end) {
    %v_elem = alloca i8*
    store i8* %.v_elem, i8** %v_elem
    %v_next = alloca i8*
    store i8* %.v_next, i8** %v_next
    %v_end = alloca i1
    store i1 %.v_end, i1* %v_end
    %_0 = getelementptr i8, i8* %this, i32 24
    %_1 = bitcast i8* %_0 to i1*
    %_2 = load i1, i1* %v_end
    store i1 %_2, i1* %_1
    %_3 = getelementptr i8, i8* %this, i32 8
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %v_elem
    store i8* %_5, i8** %_4
    %_6 = getelementptr i8, i8* %this, i32 16
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %v_next
    store i8* %_8, i8** %_7

    ret i1 1
}

define i8* @List.Insert(i8* %this, i8* %.new_elem) {
    %new_elem = alloca i8*
    store i8* %.new_elem, i8** %new_elem
    %ret_val = alloca i1
    %aux03 = alloca i8*
    %aux02 = alloca i8*
    store i8* %this, i8** %aux03
    %_0 = call i8* @calloc(i32 1, i32 25)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1
    store i8* %_0, i8** %aux02
    %_4 = load i8*, i8** %aux02
    %_5 = bitcast i8* %_4 to i8**
    %_6 = load i8*, i8** %_5
    %_7 = getelementptr i8, i8* %_6, i32 8
    %_8 = bitcast i8* %_7 to i8**
    %_9 = load i8*, i8** %_8
    %_10 = bitcast i8* %_9 to i1 (i8*, i8*, i8*, i1)*
    %_12 = load i8*, i8** %new_elem
    %_13 = load i8*, i8** %aux03
    %_11 = call i1 %_10(i8* %_4, i8* %_12, i8* %_13, i1 0)
    store i1 %_11, i1* %ret_val
    %_14 = load i8*, i8** %aux02

    ret i8* %_14
}

define i1 @List.SetNext(i8* %this, i8* %.v_next) {
    %v_next = alloca i8*
    store i8* %.v_next, i8** %v_next
    %_0 = getelementptr i8, i8* %this, i32 16
    %_1 = bitcast i8* %_0 to i8**
    %_2 = load i8*, i8** %v_next
    store i8* %_2, i8** %_1

    ret i1 1
}

define i8* @List.Delete(i8* %this, i8* %.e) {
    %e = alloca i8*
    store i8* %.e, i8** %e
    %my_head = alloca i8*
    %ret_val = alloca i1
    %aux05 = alloca i1
    %aux01 = alloca i8*
    %prev = alloca i8*
    %var_end = alloca i1
    %var_elem = alloca i8*
    %aux04 = alloca i32
    %nt = alloca i32
    store i8* %this, i8** %my_head
    store i1 0, i1* %ret_val
    %_0 = sub i32 0, 1
    store i32 %_0, i32* %aux04
    store i8* %this, i8** %aux01
    store i8* %this, i8** %prev
    %_1 = getelementptr i8, i8* %this, i32 24
    %_2 = bitcast i8* %_1 to i1*
    %_3 = load i1, i1* %_2
    store i1 %_3, i1* %var_end
    %_4 = getelementptr i8, i8* %this, i32 8
    %_5 = bitcast i8* %_4 to i8**
    %_6 = load i8*, i8** %_5
    store i8* %_6, i8** %var_elem
    br label %label1

label1:
    %_7 = load i1, i1* %var_end
    %_8 = xor i1 %_7, 1
    br i1 %_8, label %label3, label %label4

label3:
    %_9 = load i1, i1* %ret_val
    %_10 = xor i1 %_9, 1
    br label %label5

label4:
    br label %label5

label5:
    %_11 = phi i1 [%_10, %label3], [%_8, %label4]
    br i1 %_11, label %label0, label %label2

label0:
    %_12 = load i8*, i8** %e
    %_13 = bitcast i8* %_12 to i8**
    %_14 = load i8*, i8** %_13
    %_15 = getelementptr i8, i8* %_14, i32 32
    %_16 = bitcast i8* %_15 to i8**
    %_17 = load i8*, i8** %_16
    %_18 = bitcast i8* %_17 to i1 (i8*, i8*)*
    %_20 = load i8*, i8** %var_elem
    %_19 = call i1 %_18(i8* %_12, i8* %_20)
    br i1 %_19, label %label6, label %label7

label6:
    store i1 1, i1* %ret_val
    %_21 = load i32, i32* %aux04
    %_22 = icmp slt i32 %_21, 0
    br i1 %_22, label %label9, label %label10

label9:
    %_23 = load i8*, i8** %aux01
    %_24 = bitcast i8* %_23 to i8**
    %_25 = load i8*, i8** %_24
    %_26 = getelementptr i8, i8* %_25, i32 64
    %_27 = bitcast i8* %_26 to i8**
    %_28 = load i8*, i8** %_27
    %_29 = bitcast i8* %_28 to i8* (i8*)*
    %_30 = call i8* %_29(i8* %_23)
    store i8* %_30, i8** %my_head
    br label %label11

label10:
    %_31 = sub i32 0, 555
    call void (i32) @print_int(i32 %_31)    %_32 = load i8*, i8** %prev
    %_33 = bitcast i8* %_32 to i8**
    %_34 = load i8*, i8** %_33
    %_35 = getelementptr i8, i8* %_34, i32 24
    %_36 = bitcast i8* %_35 to i8**
    %_37 = load i8*, i8** %_36
    %_38 = bitcast i8* %_37 to i1 (i8*, i8*)*
    %_40 = load i8*, i8** %aux01
    %_41 = bitcast i8* %_40 to i8**
    %_42 = load i8*, i8** %_41
    %_43 = getelementptr i8, i8* %_42, i32 64
    %_44 = bitcast i8* %_43 to i8**
    %_45 = load i8*, i8** %_44
    %_46 = bitcast i8* %_45 to i8* (i8*)*
    %_47 = call i8* %_46(i8* %_40)
    %_39 = call i1 %_38(i8* %_32, i8* %_47)
    store i1 %_39, i1* %aux05
    %_48 = sub i32 0, 555
    call void (i32) @print_int(i32 %_48)    br label %label11

label11:
    br label %label8

label7:
    store i32 0, i32* %nt
    br label %label8

label8:
    %_49 = load i1, i1* %ret_val
    %_50 = xor i1 %_49, 1
    br i1 %_50, label %label12, label %label13

label12:
    %_51 = load i8*, i8** %aux01
    store i8* %_51, i8** %prev
    %_52 = load i8*, i8** %aux01
    %_53 = bitcast i8* %_52 to i8**
    %_54 = load i8*, i8** %_53
    %_55 = getelementptr i8, i8* %_54, i32 64
    %_56 = bitcast i8* %_55 to i8**
    %_57 = load i8*, i8** %_56
    %_58 = bitcast i8* %_57 to i8* (i8*)*
    %_59 = call i8* %_58(i8* %_52)
    store i8* %_59, i8** %aux01
    %_60 = load i8*, i8** %aux01
    %_61 = bitcast i8* %_60 to i8**
    %_62 = load i8*, i8** %_61
    %_63 = getelementptr i8, i8* %_62, i32 48
    %_64 = bitcast i8* %_63 to i8**
    %_65 = load i8*, i8** %_64
    %_66 = bitcast i8* %_65 to i1 (i8*)*
    %_67 = call i1 %_66(i8* %_60)
    store i1 %_67, i1* %var_end
    %_68 = load i8*, i8** %aux01
    %_69 = bitcast i8* %_68 to i8**
    %_70 = load i8*, i8** %_69
    %_71 = getelementptr i8, i8* %_70, i32 56
    %_72 = bitcast i8* %_71 to i8**
    %_73 = load i8*, i8** %_72
    %_74 = bitcast i8* %_73 to i8* (i8*)*
    %_75 = call i8* %_74(i8* %_68)
    store i8* %_75, i8** %var_elem
    store i32 1, i32* %aux04
    br label %label14

label13:
    store i32 0, i32* %nt
    br label %label14

label14:
    br label %label1

label2:
    %_76 = load i8*, i8** %my_head

    ret i8* %_76
}

define i32 @List.Search(i8* %this, i8* %.e) {
    %e = alloca i8*
    store i8* %.e, i8** %e
    %int_ret_val = alloca i32
    %aux01 = alloca i8*
    %var_elem = alloca i8*
    %var_end = alloca i1
    %nt = alloca i32
    store i32 0, i32* %int_ret_val
    store i8* %this, i8** %aux01
    %_0 = getelementptr i8, i8* %this, i32 24
    %_1 = bitcast i8* %_0 to i1*
    %_2 = load i1, i1* %_1
    store i1 %_2, i1* %var_end
    %_3 = getelementptr i8, i8* %this, i32 8
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    store i8* %_5, i8** %var_elem
    br label %label1

label1:
    %_6 = load i1, i1* %var_end
    %_7 = xor i1 %_6, 1
    br i1 %_7, label %label0, label %label2

label0:
    %_8 = load i8*, i8** %e
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    %_11 = getelementptr i8, i8* %_10, i32 32
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = bitcast i8* %_13 to i1 (i8*, i8*)*
    %_16 = load i8*, i8** %var_elem
    %_15 = call i1 %_14(i8* %_8, i8* %_16)
    br i1 %_15, label %label3, label %label4

label3:
    store i32 1, i32* %int_ret_val
    br label %label5

label4:
    store i32 0, i32* %nt
    br label %label5

label5:
    %_17 = load i8*, i8** %aux01
    %_18 = bitcast i8* %_17 to i8**
    %_19 = load i8*, i8** %_18
    %_20 = getelementptr i8, i8* %_19, i32 64
    %_21 = bitcast i8* %_20 to i8**
    %_22 = load i8*, i8** %_21
    %_23 = bitcast i8* %_22 to i8* (i8*)*
    %_24 = call i8* %_23(i8* %_17)
    store i8* %_24, i8** %aux01
    %_25 = load i8*, i8** %aux01
    %_26 = bitcast i8* %_25 to i8**
    %_27 = load i8*, i8** %_26
    %_28 = getelementptr i8, i8* %_27, i32 48
    %_29 = bitcast i8* %_28 to i8**
    %_30 = load i8*, i8** %_29
    %_31 = bitcast i8* %_30 to i1 (i8*)*
    %_32 = call i1 %_31(i8* %_25)
    store i1 %_32, i1* %var_end
    %_33 = load i8*, i8** %aux01
    %_34 = bitcast i8* %_33 to i8**
    %_35 = load i8*, i8** %_34
    %_36 = getelementptr i8, i8* %_35, i32 56
    %_37 = bitcast i8* %_36 to i8**
    %_38 = load i8*, i8** %_37
    %_39 = bitcast i8* %_38 to i8* (i8*)*
    %_40 = call i8* %_39(i8* %_33)
    store i8* %_40, i8** %var_elem
    br label %label1

label2:
    %_41 = load i32, i32* %int_ret_val

    ret i32 %_41
}

define i1 @List.GetEnd(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 24
    %_1 = bitcast i8* %_0 to i1*
    %_2 = load i1, i1* %_1

    ret i1 %_2
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

define i1 @List.Print(i8* %this) {
    %aux01 = alloca i8*
    %var_end = alloca i1
    %var_elem = alloca i8*
    store i8* %this, i8** %aux01
    %_0 = getelementptr i8, i8* %this, i32 24
    %_1 = bitcast i8* %_0 to i1*
    %_2 = load i1, i1* %_1
    store i1 %_2, i1* %var_end
    %_3 = getelementptr i8, i8* %this, i32 8
    %_4 = bitcast i8* %_3 to i8**
    %_5 = load i8*, i8** %_4
    store i8* %_5, i8** %var_elem
    br label %label1

label1:
    %_6 = load i1, i1* %var_end
    %_7 = xor i1 %_6, 1
    br i1 %_7, label %label0, label %label2

label0:
    %_8 = load i8*, i8** %var_elem
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    %_11 = getelementptr i8, i8* %_10, i32 8
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = bitcast i8* %_13 to i32 (i8*)*
    %_15 = call i32 %_14(i8* %_8)
    call void (i32) @print_int(i32 %_15)    %_16 = load i8*, i8** %aux01
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = getelementptr i8, i8* %_18, i32 64
    %_20 = bitcast i8* %_19 to i8**
    %_21 = load i8*, i8** %_20
    %_22 = bitcast i8* %_21 to i8* (i8*)*
    %_23 = call i8* %_22(i8* %_16)
    store i8* %_23, i8** %aux01
    %_24 = load i8*, i8** %aux01
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = getelementptr i8, i8* %_26, i32 48
    %_28 = bitcast i8* %_27 to i8**
    %_29 = load i8*, i8** %_28
    %_30 = bitcast i8* %_29 to i1 (i8*)*
    %_31 = call i1 %_30(i8* %_24)
    store i1 %_31, i1* %var_end
    %_32 = load i8*, i8** %aux01
    %_33 = bitcast i8* %_32 to i8**
    %_34 = load i8*, i8** %_33
    %_35 = getelementptr i8, i8* %_34, i32 56
    %_36 = bitcast i8* %_35 to i8**
    %_37 = load i8*, i8** %_36
    %_38 = bitcast i8* %_37 to i8* (i8*)*
    %_39 = call i8* %_38(i8* %_32)
    store i8* %_39, i8** %var_elem
    br label %label1

label2:

    ret i1 1
}

define i32 @LL.Start(i8* %this) {
    %head = alloca i8*
    %last_elem = alloca i8*
    %aux01 = alloca i1
    %el01 = alloca i8*
    %el02 = alloca i8*
    %el03 = alloca i8*
    %_0 = call i8* @calloc(i32 1, i32 25)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1
    store i8* %_0, i8** %last_elem
    %_4 = load i8*, i8** %last_elem
    %_5 = bitcast i8* %_4 to i8**
    %_6 = load i8*, i8** %_5
    %_7 = getelementptr i8, i8* %_6, i32 0
    %_8 = bitcast i8* %_7 to i8**
    %_9 = load i8*, i8** %_8
    %_10 = bitcast i8* %_9 to i1 (i8*)*
    %_11 = call i1 %_10(i8* %_4)
    store i1 %_11, i1* %aux01
    %_12 = load i8*, i8** %last_elem
    store i8* %_12, i8** %head
    %_13 = load i8*, i8** %head
    %_14 = bitcast i8* %_13 to i8**
    %_15 = load i8*, i8** %_14
    %_16 = getelementptr i8, i8* %_15, i32 0
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = bitcast i8* %_18 to i1 (i8*)*
    %_20 = call i1 %_19(i8* %_13)
    store i1 %_20, i1* %aux01
    %_21 = load i8*, i8** %head
    %_22 = bitcast i8* %_21 to i8**
    %_23 = load i8*, i8** %_22
    %_24 = getelementptr i8, i8* %_23, i32 72
    %_25 = bitcast i8* %_24 to i8**
    %_26 = load i8*, i8** %_25
    %_27 = bitcast i8* %_26 to i1 (i8*)*
    %_28 = call i1 %_27(i8* %_21)
    store i1 %_28, i1* %aux01
    %_29 = call i8* @calloc(i32 1, i32 17)
    %_30 = bitcast i8* %_29 to i8**
    %_31 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    %_32 = bitcast i8** %_31 to i8*
    store i8* %_32, i8** %_30
    store i8* %_29, i8** %el01
    %_33 = load i8*, i8** %el01
    %_34 = bitcast i8* %_33 to i8**
    %_35 = load i8*, i8** %_34
    %_36 = getelementptr i8, i8* %_35, i32 0
    %_37 = bitcast i8* %_36 to i8**
    %_38 = load i8*, i8** %_37
    %_39 = bitcast i8* %_38 to i1 (i8*, i32, i32, i1)*
    %_40 = call i1 %_39(i8* %_33, i32 25, i32 37000, i1 0)
    store i1 %_40, i1* %aux01
    %_41 = load i8*, i8** %head
    %_42 = bitcast i8* %_41 to i8**
    %_43 = load i8*, i8** %_42
    %_44 = getelementptr i8, i8* %_43, i32 16
    %_45 = bitcast i8* %_44 to i8**
    %_46 = load i8*, i8** %_45
    %_47 = bitcast i8* %_46 to i8* (i8*, i8*)*
    %_49 = load i8*, i8** %el01
    %_48 = call i8* %_47(i8* %_41, i8* %_49)
    store i8* %_48, i8** %head
    %_50 = load i8*, i8** %head
    %_51 = bitcast i8* %_50 to i8**
    %_52 = load i8*, i8** %_51
    %_53 = getelementptr i8, i8* %_52, i32 72
    %_54 = bitcast i8* %_53 to i8**
    %_55 = load i8*, i8** %_54
    %_56 = bitcast i8* %_55 to i1 (i8*)*
    %_57 = call i1 %_56(i8* %_50)
    store i1 %_57, i1* %aux01
    call void (i32) @print_int(i32 10000000)    %_58 = call i8* @calloc(i32 1, i32 17)
    %_59 = bitcast i8* %_58 to i8**
    %_60 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    %_61 = bitcast i8** %_60 to i8*
    store i8* %_61, i8** %_59
    store i8* %_58, i8** %el01
    %_62 = load i8*, i8** %el01
    %_63 = bitcast i8* %_62 to i8**
    %_64 = load i8*, i8** %_63
    %_65 = getelementptr i8, i8* %_64, i32 0
    %_66 = bitcast i8* %_65 to i8**
    %_67 = load i8*, i8** %_66
    %_68 = bitcast i8* %_67 to i1 (i8*, i32, i32, i1)*
    %_69 = call i1 %_68(i8* %_62, i32 39, i32 42000, i1 1)
    store i1 %_69, i1* %aux01
    %_70 = load i8*, i8** %el01
    store i8* %_70, i8** %el02
    %_71 = load i8*, i8** %head
    %_72 = bitcast i8* %_71 to i8**
    %_73 = load i8*, i8** %_72
    %_74 = getelementptr i8, i8* %_73, i32 16
    %_75 = bitcast i8* %_74 to i8**
    %_76 = load i8*, i8** %_75
    %_77 = bitcast i8* %_76 to i8* (i8*, i8*)*
    %_79 = load i8*, i8** %el01
    %_78 = call i8* %_77(i8* %_71, i8* %_79)
    store i8* %_78, i8** %head
    %_80 = load i8*, i8** %head
    %_81 = bitcast i8* %_80 to i8**
    %_82 = load i8*, i8** %_81
    %_83 = getelementptr i8, i8* %_82, i32 72
    %_84 = bitcast i8* %_83 to i8**
    %_85 = load i8*, i8** %_84
    %_86 = bitcast i8* %_85 to i1 (i8*)*
    %_87 = call i1 %_86(i8* %_80)
    store i1 %_87, i1* %aux01
    call void (i32) @print_int(i32 10000000)    %_88 = call i8* @calloc(i32 1, i32 17)
    %_89 = bitcast i8* %_88 to i8**
    %_90 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    %_91 = bitcast i8** %_90 to i8*
    store i8* %_91, i8** %_89
    store i8* %_88, i8** %el01
    %_92 = load i8*, i8** %el01
    %_93 = bitcast i8* %_92 to i8**
    %_94 = load i8*, i8** %_93
    %_95 = getelementptr i8, i8* %_94, i32 0
    %_96 = bitcast i8* %_95 to i8**
    %_97 = load i8*, i8** %_96
    %_98 = bitcast i8* %_97 to i1 (i8*, i32, i32, i1)*
    %_99 = call i1 %_98(i8* %_92, i32 22, i32 34000, i1 0)
    store i1 %_99, i1* %aux01
    %_100 = load i8*, i8** %head
    %_101 = bitcast i8* %_100 to i8**
    %_102 = load i8*, i8** %_101
    %_103 = getelementptr i8, i8* %_102, i32 16
    %_104 = bitcast i8* %_103 to i8**
    %_105 = load i8*, i8** %_104
    %_106 = bitcast i8* %_105 to i8* (i8*, i8*)*
    %_108 = load i8*, i8** %el01
    %_107 = call i8* %_106(i8* %_100, i8* %_108)
    store i8* %_107, i8** %head
    %_109 = load i8*, i8** %head
    %_110 = bitcast i8* %_109 to i8**
    %_111 = load i8*, i8** %_110
    %_112 = getelementptr i8, i8* %_111, i32 72
    %_113 = bitcast i8* %_112 to i8**
    %_114 = load i8*, i8** %_113
    %_115 = bitcast i8* %_114 to i1 (i8*)*
    %_116 = call i1 %_115(i8* %_109)
    store i1 %_116, i1* %aux01
    %_117 = call i8* @calloc(i32 1, i32 17)
    %_118 = bitcast i8* %_117 to i8**
    %_119 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    %_120 = bitcast i8** %_119 to i8*
    store i8* %_120, i8** %_118
    store i8* %_117, i8** %el03
    %_121 = load i8*, i8** %el03
    %_122 = bitcast i8* %_121 to i8**
    %_123 = load i8*, i8** %_122
    %_124 = getelementptr i8, i8* %_123, i32 0
    %_125 = bitcast i8* %_124 to i8**
    %_126 = load i8*, i8** %_125
    %_127 = bitcast i8* %_126 to i1 (i8*, i32, i32, i1)*
    %_128 = call i1 %_127(i8* %_121, i32 27, i32 34000, i1 0)
    store i1 %_128, i1* %aux01
    %_129 = load i8*, i8** %head
    %_130 = bitcast i8* %_129 to i8**
    %_131 = load i8*, i8** %_130
    %_132 = getelementptr i8, i8* %_131, i32 40
    %_133 = bitcast i8* %_132 to i8**
    %_134 = load i8*, i8** %_133
    %_135 = bitcast i8* %_134 to i32 (i8*, i8*)*
    %_137 = load i8*, i8** %el02
    %_136 = call i32 %_135(i8* %_129, i8* %_137)
    call void (i32) @print_int(i32 %_136)    %_138 = load i8*, i8** %head
    %_139 = bitcast i8* %_138 to i8**
    %_140 = load i8*, i8** %_139
    %_141 = getelementptr i8, i8* %_140, i32 40
    %_142 = bitcast i8* %_141 to i8**
    %_143 = load i8*, i8** %_142
    %_144 = bitcast i8* %_143 to i32 (i8*, i8*)*
    %_146 = load i8*, i8** %el03
    %_145 = call i32 %_144(i8* %_138, i8* %_146)
    call void (i32) @print_int(i32 %_145)    call void (i32) @print_int(i32 10000000)    %_147 = call i8* @calloc(i32 1, i32 17)
    %_148 = bitcast i8* %_147 to i8**
    %_149 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
    %_150 = bitcast i8** %_149 to i8*
    store i8* %_150, i8** %_148
    store i8* %_147, i8** %el01
    %_151 = load i8*, i8** %el01
    %_152 = bitcast i8* %_151 to i8**
    %_153 = load i8*, i8** %_152
    %_154 = getelementptr i8, i8* %_153, i32 0
    %_155 = bitcast i8* %_154 to i8**
    %_156 = load i8*, i8** %_155
    %_157 = bitcast i8* %_156 to i1 (i8*, i32, i32, i1)*
    %_158 = call i1 %_157(i8* %_151, i32 28, i32 35000, i1 0)
    store i1 %_158, i1* %aux01
    %_159 = load i8*, i8** %head
    %_160 = bitcast i8* %_159 to i8**
    %_161 = load i8*, i8** %_160
    %_162 = getelementptr i8, i8* %_161, i32 16
    %_163 = bitcast i8* %_162 to i8**
    %_164 = load i8*, i8** %_163
    %_165 = bitcast i8* %_164 to i8* (i8*, i8*)*
    %_167 = load i8*, i8** %el01
    %_166 = call i8* %_165(i8* %_159, i8* %_167)
    store i8* %_166, i8** %head
    %_168 = load i8*, i8** %head
    %_169 = bitcast i8* %_168 to i8**
    %_170 = load i8*, i8** %_169
    %_171 = getelementptr i8, i8* %_170, i32 72
    %_172 = bitcast i8* %_171 to i8**
    %_173 = load i8*, i8** %_172
    %_174 = bitcast i8* %_173 to i1 (i8*)*
    %_175 = call i1 %_174(i8* %_168)
    store i1 %_175, i1* %aux01
    call void (i32) @print_int(i32 2220000)    %_176 = load i8*, i8** %head
    %_177 = bitcast i8* %_176 to i8**
    %_178 = load i8*, i8** %_177
    %_179 = getelementptr i8, i8* %_178, i32 32
    %_180 = bitcast i8* %_179 to i8**
    %_181 = load i8*, i8** %_180
    %_182 = bitcast i8* %_181 to i8* (i8*, i8*)*
    %_184 = load i8*, i8** %el02
    %_183 = call i8* %_182(i8* %_176, i8* %_184)
    store i8* %_183, i8** %head
    %_185 = load i8*, i8** %head
    %_186 = bitcast i8* %_185 to i8**
    %_187 = load i8*, i8** %_186
    %_188 = getelementptr i8, i8* %_187, i32 72
    %_189 = bitcast i8* %_188 to i8**
    %_190 = load i8*, i8** %_189
    %_191 = bitcast i8* %_190 to i1 (i8*)*
    %_192 = call i1 %_191(i8* %_185)
    store i1 %_192, i1* %aux01
    call void (i32) @print_int(i32 33300000)    %_193 = load i8*, i8** %head
    %_194 = bitcast i8* %_193 to i8**
    %_195 = load i8*, i8** %_194
    %_196 = getelementptr i8, i8* %_195, i32 32
    %_197 = bitcast i8* %_196 to i8**
    %_198 = load i8*, i8** %_197
    %_199 = bitcast i8* %_198 to i8* (i8*, i8*)*
    %_201 = load i8*, i8** %el01
    %_200 = call i8* %_199(i8* %_193, i8* %_201)
    store i8* %_200, i8** %head
    %_202 = load i8*, i8** %head
    %_203 = bitcast i8* %_202 to i8**
    %_204 = load i8*, i8** %_203
    %_205 = getelementptr i8, i8* %_204, i32 72
    %_206 = bitcast i8* %_205 to i8**
    %_207 = load i8*, i8** %_206
    %_208 = bitcast i8* %_207 to i1 (i8*)*
    %_209 = call i1 %_208(i8* %_202)
    store i1 %_209, i1* %aux01
    call void (i32) @print_int(i32 44440000)
    ret i32 0
}
