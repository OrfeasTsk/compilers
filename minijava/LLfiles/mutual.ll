@.test15_vtable = global [0 x i8*] []
@.Test_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*)* @Test.start to i8*), i8* bitcast (i32 (i8*)* @Test.mutual1 to i8*), i8* bitcast (i32 (i8*)* @Test.mutual2 to i8*)]


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
    %_0 = call i8* @calloc(i32 1, i32 16)
    %_1 = bitcast i8* %_0 to i8**
    %_2 = getelementptr [3 x i8*], [3 x i8*]* @.Test_vtable, i32 0, i32 0
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

define i32 @Test.start(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    store i32 4, i32* %_1
    %_2 = getelementptr i8, i8* %this, i32 12
    %_3 = bitcast i8* %_2 to i32*
    store i32 0, i32* %_3
    %_4 = bitcast i8* %this to i8**
    %_5 = load i8*, i8** %_4
    %_6 = getelementptr i8, i8* %_5, i32 8
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %_7
    %_9 = bitcast i8* %_8 to i32 (i8*)*
    %_10 = call i32 %_9(i8* %this)

    ret i32 %_10
}

define i32 @Test.mutual1(i8* %this) {
    %j = alloca i32
    store i32 0, i32* %j
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = getelementptr i8, i8* %this, i32 8
    %_3 = bitcast i8* %_2 to i32*
    %_4 = load i32, i32* %_3
    %_5 = sub i32 %_4, 1
    store i32 %_5, i32* %_1
    %_6 = getelementptr i8, i8* %this, i32 8
    %_7 = bitcast i8* %_6 to i32*
    %_8 = load i32, i32* %_7
    %_9 = icmp slt i32 %_8, 0
    %_10 = zext i1 %_9 to i8
    %_11 = trunc i8 %_10 to i1
    br i1 %_11, label %label0, label %label1

label0:
    %_12 = getelementptr i8, i8* %this, i32 12
    %_13 = bitcast i8* %_12 to i32*
    store i32 0, i32* %_13
    br label %label2

label1:
    %_14 = getelementptr i8, i8* %this, i32 12
    %_15 = bitcast i8* %_14 to i32*
    %_16 = load i32, i32* %_15
    call void (i32) @print_int(i32 %_16)
    %_17 = getelementptr i8, i8* %this, i32 12
    %_18 = bitcast i8* %_17 to i32*
    store i32 1, i32* %_18
    %_19 = bitcast i8* %this to i8**
    %_20 = load i8*, i8** %_19
    %_21 = getelementptr i8, i8* %_20, i32 16
    %_22 = bitcast i8* %_21 to i8**
    %_23 = load i8*, i8** %_22
    %_24 = bitcast i8* %_23 to i32 (i8*)*
    %_25 = call i32 %_24(i8* %this)
    store i32 %_25, i32* %j
    br label %label2

label2:
    %_26 = getelementptr i8, i8* %this, i32 12
    %_27 = bitcast i8* %_26 to i32*
    %_28 = load i32, i32* %_27

    ret i32 %_28
}

define i32 @Test.mutual2(i8* %this) {
    %j = alloca i32
    store i32 0, i32* %j
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = getelementptr i8, i8* %this, i32 8
    %_3 = bitcast i8* %_2 to i32*
    %_4 = load i32, i32* %_3
    %_5 = sub i32 %_4, 1
    store i32 %_5, i32* %_1
    %_6 = getelementptr i8, i8* %this, i32 8
    %_7 = bitcast i8* %_6 to i32*
    %_8 = load i32, i32* %_7
    %_9 = icmp slt i32 %_8, 0
    %_10 = zext i1 %_9 to i8
    %_11 = trunc i8 %_10 to i1
    br i1 %_11, label %label0, label %label1

label0:
    %_12 = getelementptr i8, i8* %this, i32 12
    %_13 = bitcast i8* %_12 to i32*
    store i32 0, i32* %_13
    br label %label2

label1:
    %_14 = getelementptr i8, i8* %this, i32 12
    %_15 = bitcast i8* %_14 to i32*
    %_16 = load i32, i32* %_15
    call void (i32) @print_int(i32 %_16)
    %_17 = getelementptr i8, i8* %this, i32 12
    %_18 = bitcast i8* %_17 to i32*
    store i32 0, i32* %_18
    %_19 = bitcast i8* %this to i8**
    %_20 = load i8*, i8** %_19
    %_21 = getelementptr i8, i8* %_20, i32 8
    %_22 = bitcast i8* %_21 to i8**
    %_23 = load i8*, i8** %_22
    %_24 = bitcast i8* %_23 to i32 (i8*)*
    %_25 = call i32 %_24(i8* %this)
    store i32 %_25, i32* %j
    br label %label2

label2:
    %_26 = getelementptr i8, i8* %this, i32 12
    %_27 = bitcast i8* %_26 to i32*
    %_28 = load i32, i32* %_27

    ret i32 %_28
}
