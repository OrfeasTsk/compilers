@.ManyClasses_vtable = global [0 x i8*] []
@.A_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @A.get to i8*)]
@.B_vtable = global [2 x i8*] [i8* bitcast (i32 (i8*)* @A.get to i8*), i8* bitcast (i8 (i8*)* @B.set to i8*)]
@.C_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*)* @A.get to i8*), i8* bitcast (i8 (i8*)* @B.set to i8*), i8* bitcast (i8 (i8*)* @C.reset to i8*)]


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
    %rv = alloca i8
    store i8 0, i8* %rv
    %a = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 9)
    store i8* %_0, i8** %a
    %b = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 9)
    store i8* %_1, i8** %b
    %c = alloca i8*
    %_2 = call i8* @calloc(i32 0, i32 9)
    store i8* %_2, i8** %c
    %_3 = call i8* @calloc(i32 1, i32 9)
    %_4 = bitcast i8* %_3 to i8**
    %_5 = getelementptr [2 x i8*], [2 x i8*]* @.B_vtable, i32 0, i32 0
    %_6 = bitcast i8** %_5 to i8*
    store i8* %_6, i8** %_4
    store i8* %_3, i8** %b
    %_7 = call i8* @calloc(i32 1, i32 9)
    %_8 = bitcast i8* %_7 to i8**
    %_9 = getelementptr [3 x i8*], [3 x i8*]* @.C_vtable, i32 0, i32 0
    %_10 = bitcast i8** %_9 to i8*
    store i8* %_10, i8** %_8
    store i8* %_7, i8** %c
    %_11 = load i8*, i8** %b
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = getelementptr i8, i8* %_13, i32 8
    %_15 = bitcast i8* %_14 to i8**
    %_16 = load i8*, i8** %_15
    %_17 = bitcast i8* %_16 to i8 (i8*)*
    %_18 = call i8 %_17(i8* %_11)
    store i8 %_18, i8* %rv
    %_19 = load i8*, i8** %c
    %_20 = bitcast i8* %_19 to i8**
    %_21 = load i8*, i8** %_20
    %_22 = getelementptr i8, i8* %_21, i32 16
    %_23 = bitcast i8* %_22 to i8**
    %_24 = load i8*, i8** %_23
    %_25 = bitcast i8* %_24 to i8 (i8*)*
    %_26 = call i8 %_25(i8* %_19)
    store i8 %_26, i8* %rv
    %_27 = load i8*, i8** %b
    %_28 = bitcast i8* %_27 to i8**
    %_29 = load i8*, i8** %_28
    %_30 = getelementptr i8, i8* %_29, i32 0
    %_31 = bitcast i8* %_30 to i8**
    %_32 = load i8*, i8** %_31
    %_33 = bitcast i8* %_32 to i32 (i8*)*
    %_34 = call i32 %_33(i8* %_27)
    call void (i32) @print_int(i32 %_34)
    %_35 = load i8*, i8** %c
    %_36 = bitcast i8* %_35 to i8**
    %_37 = load i8*, i8** %_36
    %_38 = getelementptr i8, i8* %_37, i32 0
    %_39 = bitcast i8* %_38 to i8**
    %_40 = load i8*, i8** %_39
    %_41 = bitcast i8* %_40 to i32 (i8*)*
    %_42 = call i32 %_41(i8* %_35)
    call void (i32) @print_int(i32 %_42)


    ret i32 0
}

define i32 @A.get(i8* %this) {
    %rv = alloca i32
    store i32 0, i32* %rv
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i8*
    %_2 = load i8, i8* %_1
    %_3 = trunc i8 %_2 to i1
    br i1 %_3, label %label0, label %label1

label0:
    store i32 1, i32* %rv
    br label %label2

label1:
    store i32 0, i32* %rv
    br label %label2

label2:
    %_4 = load i32, i32* %rv

    ret i32 %_4
}

define i8 @B.set(i8* %this) {
    %old = alloca i8
    store i8 0, i8* %old
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i8*
    %_2 = load i8, i8* %_1
    store i8 %_2, i8* %old
    %_3 = getelementptr i8, i8* %this, i32 8
    %_4 = bitcast i8* %_3 to i8*
    store i8 1, i8* %_4
    %_5 = getelementptr i8, i8* %this, i32 8
    %_6 = bitcast i8* %_5 to i8*
    %_7 = load i8, i8* %_6

    ret i8 %_7
}

define i8 @C.reset(i8* %this) {
    %old = alloca i8
    store i8 0, i8* %old
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i8*
    %_2 = load i8, i8* %_1
    store i8 %_2, i8* %old
    %_3 = getelementptr i8, i8* %this, i32 8
    %_4 = bitcast i8* %_3 to i8*
    store i8 0, i8* %_4
    %_5 = getelementptr i8, i8* %this, i32 8
    %_6 = bitcast i8* %_5 to i8*
    %_7 = load i8, i8* %_6

    ret i8 %_7
}
