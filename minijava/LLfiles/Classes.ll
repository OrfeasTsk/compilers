@.Classes_vtable = global [0 x i8*] []
@.Base_vtable = global [2 x i8*] [i8* bitcast (i32 (i8*,i32)* @Base.set to i8*), i8* bitcast (i32 (i8*)* @Base.get to i8*)]
@.Derived_vtable = global [2 x i8*] [i8* bitcast (i32 (i8*,i32)* @Derived.set to i8*), i8* bitcast (i32 (i8*)* @Base.get to i8*)]


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
    %b = alloca i8*
    %_0 = call i8* @calloc(i32 0, i32 12)
    store i8* %_0, i8** %b
    %d = alloca i8*
    %_1 = call i8* @calloc(i32 0, i32 12)
    store i8* %_1, i8** %d
    %_2 = call i8* @calloc(i32 1, i32 12)
    %_3 = bitcast i8* %_2 to i8**
    %_4 = getelementptr [2 x i8*], [2 x i8*]* @.Base_vtable, i32 0, i32 0
    %_5 = bitcast i8** %_4 to i8*
    store i8* %_5, i8** %_3
    store i8* %_2, i8** %b
    %_6 = call i8* @calloc(i32 1, i32 12)
    %_7 = bitcast i8* %_6 to i8**
    %_8 = getelementptr [2 x i8*], [2 x i8*]* @.Derived_vtable, i32 0, i32 0
    %_9 = bitcast i8** %_8 to i8*
    store i8* %_9, i8** %_7
    store i8* %_6, i8** %d
    %_10 = load i8*, i8** %d
    store i8* %_10, i8** %b
    %_11 = load i8*, i8** %b
    %_12 = bitcast i8* %_11 to i8**
    %_13 = load i8*, i8** %_12
    %_14 = getelementptr i8, i8* %_13, i32 0
    %_15 = bitcast i8* %_14 to i8**
    %_16 = load i8*, i8** %_15
    %_17 = bitcast i8* %_16 to i32 (i8*, i32)*
    %_18 = call i32 %_17(i8* %_11, i32 1)
    call void (i32) @print_int(i32 %_18)
    %_19 = load i8*, i8** %b
    %_20 = bitcast i8* %_19 to i8**
    %_21 = load i8*, i8** %_20
    %_22 = getelementptr i8, i8* %_21, i32 0
    %_23 = bitcast i8* %_22 to i8**
    %_24 = load i8*, i8** %_23
    %_25 = bitcast i8* %_24 to i32 (i8*, i32)*
    %_26 = call i32 %_25(i8* %_19, i32 3)
    call void (i32) @print_int(i32 %_26)


    ret i32 0
}

define i32 @Base.set(i8* %this, i32 %.x) {
    %x = alloca i32
    store i32 %.x, i32* %x
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %x
    store i32 %_2, i32* %_1
    %_3 = getelementptr i8, i8* %this, i32 8
    %_4 = bitcast i8* %_3 to i32*
    %_5 = load i32, i32* %_4

    ret i32 %_5
}

define i32 @Base.get(i8* %this) {
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %_1

    ret i32 %_2
}

define i32 @Derived.set(i8* %this, i32 %.x) {
    %x = alloca i32
    store i32 %.x, i32* %x
    %_0 = getelementptr i8, i8* %this, i32 8
    %_1 = bitcast i8* %_0 to i32*
    %_2 = load i32, i32* %x
    %_3 = mul i32 %_2, 2
    store i32 %_3, i32* %_1
    %_4 = getelementptr i8, i8* %this, i32 8
    %_5 = bitcast i8* %_4 to i32*
    %_6 = load i32, i32* %_5

    ret i32 %_6
}
