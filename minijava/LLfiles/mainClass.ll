@.Blah_vtable = global [0 x i8*] []
@.B_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @B.test to i8*)]
@.C_vtable = global [2 x i8*] [i8* bitcast (i32 (i8*)* @C.test to i8*), i8* bitcast (i32 (i8*)* @C.test2 to i8*)]
@.Receiver_vtable = global [5 x i8*] [i8* bitcast (i32 (i8*,i8*)* @Receiver.receiveMain to i8*), i8* bitcast (i32 (i8*,i8*)* @Receiver.final_ to i8*), i8* bitcast (i32 (i8*,i8*)* @Receiver.pass2 to i8*), i8* bitcast (i8* (i8*,i8*)* @Receiver.pass1 to i8*), i8* bitcast (i8* (i8*,i8*)* @Receiver.get_C_give_B to i8*)]
@.E_vtable = global [0 x i8*] []
@.D_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @D.test to i8*)]


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
    %b = alloca i32
    store i32 0, i32* %b
    %blah = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 8)
    store i8* %_0, i8** %blah
    %_1 = call i8* @calloc(i32 1, i32 38)
    %_2 = bitcast i8* %_1 to i8**
    %_3 = getelementptr [1 x i8*], [1 x i8*]* @.B_vtable, i32 0, i32 0
    %_4 = bitcast i8** %_3 to i8*
    store i8* %_4, i8** %_2
    store i8* %_1, i8** %blah
    %_5 = load i32, i32* %b
    call void (i32) @print_int(i32 %_5)


    ret i32 0
}

define i32 @B.test(i8* %this) {

    ret i32 1
}

define i32 @C.test(i8* %this) {
    %b = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 8)
    store i8* %_0, i8** %b

    ret i32 2
}

define i32 @C.test2(i8* %this) {
    %r = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 8)
    store i8* %_0, i8** %r
    %main_ = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 8)
    store i8* %_1, i8** %main_
    %b = alloca i8*
    %_2 = call i8* @calloc(i32 0, i32 38)
    store i8* %_2, i8** %b
    %c = alloca i8*
    %_3 = call i8* @calloc(i32 0, i32 38)
    store i8* %_3, i8** %c
    %dummy = alloca i32
    store i32 0, i32* %dummy
    %_4 = load i8*, i8** %r
    %_5 = bitcast i8* %_4 to i8**
    %_6 = load i8*, i8** %_5
    %_7 = getelementptr i8, i8* %_6, i32 0
    %_8 = bitcast i8* %_7 to i8**
    %_9 = load i8*, i8** %_8
    %_10 = bitcast i8* %_9 to i32 (i8*, i8*)*
    %_12 = load i8*, i8** %main_
    %_11 = call i32 %_10(i8* %_4, i8* %_12)
    store i32 %_11, i32* %dummy
    %_13 = load i8*, i8** %r
    %_14 = bitcast i8* %_13 to i8**
    %_15 = load i8*, i8** %_14
    %_16 = getelementptr i8, i8* %_15, i32 0
    %_17 = bitcast i8* %_16 to i8**
    %_18 = load i8*, i8** %_17
    %_19 = bitcast i8* %_18 to i32 (i8*, i8*)*
    %_21 = load i8*, i8** %b
    %_20 = call i32 %_19(i8* %_13, i8* %_21)
    store i32 %_20, i32* %dummy
    %_22 = load i8*, i8** %r
    %_23 = bitcast i8* %_22 to i8**
    %_24 = load i8*, i8** %_23
    %_25 = getelementptr i8, i8* %_24, i32 0
    %_26 = bitcast i8* %_25 to i8**
    %_27 = load i8*, i8** %_26
    %_28 = bitcast i8* %_27 to i32 (i8*, i8*)*
    %_30 = load i8*, i8** %c
    %_29 = call i32 %_28(i8* %_22, i8* %_30)
    store i32 %_29, i32* %dummy

    ret i32 3
}

define i32 @Receiver.receiveMain(i8* %this, i8* %.b) {
    %b = alloca i8*
    store i8* %.b, i8** %b
    %c = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 38)
    store i8* %_0, i8** %c
    %dummy = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 38)
    store i8* %_1, i8** %dummy
    %_2 = bitcast i8* %this to i8**
    %_3 = load i8*, i8** %_2
    %_4 = getelementptr i8, i8* %_3, i32 24
    %_5 = bitcast i8* %_4 to i8**
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i8* (i8*, i8*)*
    %_9 = load i8*, i8** %c
    %_8 = call i8* %_7(i8* %this, i8* %_9)
    store i8* %_8, i8** %dummy

    ret i32 4
}

define i32 @Receiver.final_(i8* %this, i8* %.main_) {
    %main_ = alloca i8*
    store i8* %.main_, i8** %main_

    ret i32 2
}

define i32 @Receiver.pass2(i8* %this, i8* %.b) {
    %b = alloca i8*
    store i8* %.b, i8** %b
    %_0 = bitcast i8* %this to i8**
    %_1 = load i8*, i8** %_0
    %_2 = getelementptr i8, i8* %_1, i32 8
    %_3 = bitcast i8* %_2 to i8**
    %_4 = load i8*, i8** %_3
    %_5 = bitcast i8* %_4 to i32 (i8*, i8*)*
    %_7 = load i8*, i8** %b
    %_6 = call i32 %_5(i8* %this, i8* %_7)

    ret i32 %_6
}

define i8* @Receiver.pass1(i8* %this, i8* %.c) {
    %c = alloca i8*
    store i8* %.c, i8** %c
    %dummy = alloca i32
    store i32 0, i32* %dummy
    %_0 = bitcast i8* %this to i8**
    %_1 = load i8*, i8** %_0
    %_2 = getelementptr i8, i8* %_1, i32 16
    %_3 = bitcast i8* %_2 to i8**
    %_4 = load i8*, i8** %_3
    %_5 = bitcast i8* %_4 to i32 (i8*, i8*)*
    %_7 = load i8*, i8** %c
    %_6 = call i32 %_5(i8* %this, i8* %_7)
    store i32 %_6, i32* %dummy
    %_8 = bitcast i8* %this to i8**
    %_9 = load i8*, i8** %_8
    %_10 = getelementptr i8, i8* %_9, i32 32
    %_11 = bitcast i8* %_10 to i8**
    %_12 = load i8*, i8** %_11
    %_13 = bitcast i8* %_12 to i8* (i8*, i8*)*
    %_15 = load i8*, i8** %c
    %_14 = call i8* %_13(i8* %this, i8* %_15)

    ret i8* %_14
}

define i8* @Receiver.get_C_give_B(i8* %this, i8* %.c) {
    %c = alloca i8*
    store i8* %.c, i8** %c
    %_0 = load i8*, i8** %c

    ret i8* %_0
}

define i32 @D.test(i8* %this) {
    %b = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 8)
    store i8* %_0, i8** %b

    ret i32 5
}
