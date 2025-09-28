; 全局变量声明
@global_int = global i32 1
@global_float = constant float 2.0

; 外部函数声明
declare i32 @getint()
declare i32 @getch()
declare void @getarray(i32*)
declare float @getfloat()
declare void @getfarray(float*)

declare void @putint(i32)
declare void @putch(i32)
declare void @putarray(i32, i32*)
declare void @putfloat(float)

declare void @putfarray(i32, float*)

; 简单函数：加法运算
define i32 @add(i32 %a, i32 %b) {
entry:
  %sum = add i32 %a, %b
  ret i32 %sum
}

; 主函数
define i32 @main() {
entry:
  ; 局部变量声明与赋值
  %a = alloca i32
  %b = alloca i32
  %c = alloca i32
  %f = alloca float
  %arr = alloca [2 x i32]
  %arr_ptr = getelementptr inbounds [2 x i32], [2 x i32]* %arr, i32 0, i32 0
  
  store i32 1, i32* %a
  store i32 2, i32* %b
  
  ; 赋值语句
  %a_val = load i32, i32* %a
  %b_val = load i32, i32* %b
  %sum1 = add i32 %a_val, %b_val
  store i32 %sum1, i32* %c
  
  ; 条件分支语句
  %c_val = load i32, i32* %c
  %cmp1 = icmp sgt i32 %c_val, 2
  br i1 %cmp1, label %if.then, label %if.else

if.then:
  store i32 1, i32* %c
  br label %if.end

if.else:
  store i32 2, i32* %c
  br label %if.end

if.end:
  
  ; 循环语句
  br label %while.cond

while.cond:
  %a_val2 = load i32, i32* %a
  %cmp2 = icmp slt i32 %a_val2, 3
  br i1 %cmp2, label %while.body, label %while.end

while.body:
  %a_val3 = load i32, i32* %a
  %add1 = add i32 %a_val3, 1
  store i32 %add1, i32* %a
  br label %while.cond

while.end:
  
  ; 类型转换：int 转 float
  %c_val2 = load i32, i32* %c
  %conv1 = sitofp i32 %c_val2 to float
  store float %conv1, float* %f
  
  ; 函数调用
  %a_val4 = load i32, i32* %a
  %b_val2 = load i32, i32* %b
  %call_add = call i32 @add(i32 %a_val4, i32 %b_val2)
  store i32 %call_add, i32* %c
  
  ; 库函数调用（I/O）
  %c_val3 = load i32, i32* %c
  call void @putint(i32 %c_val3)
  call void @putch(i32 10)  ; 换行符
  
  ; 数组操作
  %arr_idx0 = getelementptr inbounds [2 x i32], [2 x i32]* %arr, i32 0, i32 0
  %arr_idx1 = getelementptr inbounds [2 x i32], [2 x i32]* %arr, i32 0, i32 1
  store i32 1, i32* %arr_idx0
  store i32 2, i32* %arr_idx1
  call void @putarray(i32 2, i32* %arr_ptr)
  
  ; 浮点数操作
  %call_getfloat = call float @getfloat()
  store float %call_getfloat, float* %f
  %f_val = load float, float* %f
  call void @putfloat(float %f_val)
  call void @putch(i32 10)  ; 换行符
  
  ret i32 0
}