@.Factorial_vtable = global [0 x i8*] []
@.Fac_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*,i32)* @Fac.ComputeFac to i8*)]


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
    %_2 = getelementptr [1 x i8*], [1 x i8*]* @.Fac_vtable, i32 0, i32 0
    %_3 = bitcast i8** %_2 to i8*
    store i8* %_3, i8** %_1
    %_4 = bitcast i8* %_0 to i8**
    %_5 = load i8*, i8** %_4
    %_6 = getelementptr i8, i8* %_5, i32 0
    %_7 = bitcast i8* %_6 to i8**
    %_8 = load i8*, i8** %_7
    %_9 = bitcast i8* %_8 to i32 (i8*, i32)*
    %_10 = call i32 %_9(i8* %_0, i32 10)
    call void (i32) @print_int(i32 %_10)


    ret i32 0
}

define i32 @Fac.ComputeFac(i8* %this, i32 %.num) {
    %num = alloca i32
    store i32 %.num, i32* %num
    %num_aux = alloca i32
    store i32 0, i32* %num_aux
    %_0 = load i32, i32* %num
    %_1 = icmp slt i32 %_0, 1
    %_2 = zext i1 %_1 to i8
    %_3 = trunc i8 %_2 to i1
    br i1 %_3, label %label0, label %label1

label0:
    store i32 1, i32* %num_aux
    br label %label2

label1:
    %_4 = load i32, i32* %num
    %_5 = bitcast i8* %this to i8**
    %_6 = load i8*, i8** %_5
    %_7 = getelementptr i8, i8* %_6, i32 0
    %_8 = bitcast i8* %_7 to i8**
    %_9 = load i8*, i8** %_8
    %_10 = bitcast i8* %_9 to i32 (i8*, i32)*
    %_12 = load i32, i32* %num
    %_13 = sub i32 %_12, 1
    %_11 = call i32 %_10(i8* %this, i32 %_13)
    %_14 = mul i32 %_4, %_11
    store i32 %_14, i32* %num_aux
    br label %label2

label2:
    %_15 = load i32, i32* %num_aux

    ret i32 %_15
}
