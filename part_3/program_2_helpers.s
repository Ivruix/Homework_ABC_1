	.intel_syntax noprefix
	.text
	.section	.rodata			# Строки для inputArray
.LC0:
	.string	"Input A size: "
.LC1:
	.string	"%d"
.LC2:
	.string	"Input A: "

	.text
	.globl	inputArray
inputArray:					# Функция inputArray
	push	rbp				# Пролог функции
	mov	rbp, rsp
	sub	rsp, 16

	lea	rdi, .LC0[rip]			# printf("Input A size: ")
	mov	eax, 0
	call	printf@PLT

	lea	rsi, -8[rbp]			# Загрузка &array_A_size (это -8[rbp]) в rsi

	lea	rdi, .LC1[rip]			# Вызов scanf("%d", &array_A_size)
	mov	eax, 0
	call	__isoc99_scanf@PLT
	
	mov	r12d, -8[rbp]			# Теперь array_A_size в r12d

	lea	rdi, .LC2[rip]			# printf("Input A: ");
	mov	eax, 0
	call	printf@PLT

	mov	ebx, 0				# i = 0 (i находится в ebx)

	jmp	.L2
.L3:
	lea	rdx, 0[0+rbx*4]			# Запись &array_A[i] в rsi
	lea	rax, array_A[rip]
	add	rax, rdx
	mov	rsi, rax
	
	lea	rax, .LC1[rip]			# scanf("%d", &array_A[i])
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	
	add	ebx, 1				# i++
.L2:
	cmp	ebx, r12d			# Если i < array_A_size, то не происходит выход из цикла
	jl	.L3
	
	mov	eax, r12d			# Запись array_A_size в eax для возврата
	
	leave					# Эпилог функции
	ret

	.globl	processArray
processArray:					# Функция processArray
	push	rbp				# Пролог функции
	mov	rbp, rsp
	
	mov	r12d, edi			# Загрузка array_A_size (в r12d)
		
	mov	r13d, 0				# array_B_size = 0 (array_B_size в r13d)
	
	cmp	r12d, 0				# Если array_A_size != 0, то прыжок на .L6, иначе на .L7
	jne	.L6
	mov	eax, 0				# Возврат 0
	jmp	.L7

.L6:
	mov	eax, DWORD PTR array_A[rip]	# array_B[0] = array_A[0]
	mov	DWORD PTR array_B[rip], eax
	
	add	r13d, 1				# array_B_size++
	
	mov	ebx, 1				# i = 1 (i находится в ebx)
	
	jmp	.L8
.L10:
	lea	rdx, 0[0+rbx*4]			# Если array_A[i] < array_B[array_B_size - 1], то прыжок на .L9
	lea	rax, array_A[rip]
	mov	edx, DWORD PTR [rdx+rax]
	mov	eax, r13d
	sub	eax, 1
	lea	rcx, 0[0+rax*4]
	lea	rax, array_B[rip]
	mov	eax, DWORD PTR [rcx+rax]
	cmp	edx, eax
	jl	.L9
	
	mov	eax, ebx			# array_B[array_B_size] = array_A[i]
	lea	rdx, 0[0+rax*4]
	lea	rax, array_A[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	edx, r13d
	lea	rcx, 0[0+rdx*4]
	lea	rdx, array_B[rip]
	mov	DWORD PTR [rcx+rdx], eax
	
	add	r13d, 1				# array_B_size++
.L9:
	add	ebx, 1				# i++
.L8:
	cmp	ebx, r12d			# Если i < array_A_size, то не происходит выход из цикла
	jl	.L10
	
	mov	eax, r13d			# Запись array_B_size в eax для возврата
.L7:
	pop	rbp				# Эпилог функции
	ret

	.section	.rodata			# Строки для outputArray
.LC3:
	.string	"Resulting B: "
.LC4:
	.string	"%d "

	.text
	.globl	outputArray
outputArray:					# Функция outputArray
	push	rbp				# Пролог функции
	mov	rbp, rsp
	
	mov	r12d, edi			# Загрузка array_B_size (в r12d)
	
	lea	rdi, .LC3[rip]			# printf("Resulting B: ")
	mov	eax, 0
	call	printf@PLT
	
	mov	ebx, 0				# i = 0 (i в ebx) 
	jmp	.L12
.L13:	
	lea	rdx, 0[0+rbx*4]			# Запись array_B[i] в esi
	lea	rax, array_B[rip]
	mov	esi, DWORD PTR [rdx+rax]
	
	lea	rdi, .LC4[rip]			# printf("%d ", array_B[i])
	mov	eax, 0
	call	printf@PLT
	
	add	ebx, 1				# i++
.L12:
	cmp	ebx, r12d			# Если i < array_B_size, то не происходит выход из цикла
	jl	.L13
	
	leave					# Эпилог функции
	ret

	.globl	writeArray
writeArray:					# Функция writeArray
	push	rbp				# Пролог функции
	mov	rbp, rsp
	sub	rsp, 32
	
	mov	ebx, edi			# Загрузка array_B_size (в ebx)
	mov	r12, rsi			# Загрузка *output (в r12)
	mov	r13d, 0				# i = 0 (i в r13)
	jmp	.L15
.L16:
	mov	eax, r13d			# fprintf(output, "%d ", array_B[i])
	lea	rdx, 0[0+rax*4]
	lea	rax, array_B[rip]
	mov	edx, DWORD PTR [rdx+rax]
	mov	rax, r12
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	add	r13d, 1
.L15:	
	cmp	r13d, ebx			# Выход из цикла
	jl	.L16

	leave					# Эпилог функции
	ret

	.globl	generateArray
generateArray:					# Функция generateArray
	push	rbp				# Пролог функции
	mov	rbp, rsp
	sub	rsp, 32
	
	mov	ebx, edi			# Загрузка seed (в ebx)

	mov	edi, ebx			# srand(seed)
	call	srand@PLT
	
	call	rand@PLT			# array_A_size = rand() % 20 (array_A_size в r12d)
	mov	edx, eax
	movsx	rax, edx
	imul	rax, rax, 1717986919
	shr	rax, 32
	sar	eax, 3
	mov	ecx, edx
	sar	ecx, 31
	sub	eax, ecx
	mov	r12d, eax
	mov	ecx, r12d
	mov	eax, ecx
	sal	eax, 2
	add	eax, ecx
	sal	eax, 2
	sub	edx, eax
	mov	r12d, edx
	
	mov	r13d, 0				# i = 0 (i в r13d)
	jmp	.L18
.L19:
	call	rand@PLT			# array_A[i] = rand() % 1001 - 500;
	movsx	rdx, eax
	imul	rdx, rdx, 1098413215
	shr	rdx, 32
	sar	edx, 8
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 1001
	sub	eax, ecx
	mov	edx, eax
	lea	ecx, -500[rdx]
	mov	eax, r13d
	lea	rdx, 0[0+rax*4]
	lea	rax, array_A[rip]
	mov	DWORD PTR [rdx+rax], ecx
	
	add	r13d, 1				# i++
.L18:
	cmp	r13d, r12d			# Выход из цикла
	jl	.L19
	
	mov	eax, r12d
	leave					# Эпилог функции
	ret

	.globl	readArray
readArray:					# Функция readArray
	push	rbp				# Пролог функции
	mov	rbp, rsp
	sub	rsp, 32
	
	mov	rbx, rdi			# Загрузка *input (в rbx)
	
	lea	rdx, -8[rbp]			# fscanf(input, "%d", &array_A_size)
	mov	rax, rbx
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	
	mov	r12d, -8[rbp]			# Загрузка array_A_size в r12d
	
	mov	r13d, 0				# i = 0 (i в r13d)
	jmp	.L22
.L23:
	mov	eax, r13d
	
	lea	rdx, 0[0+rax*4]			# fscanf(input, "%d", &array_A[i])
	lea	rax, array_A[rip]
	add	rdx, rax
	mov	rax, rbx
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	
	add	r13d, 1				# i++
.L22:
	cmp	r13d, r12d			# Выход из цикла
	jl	.L23
	mov	eax, r12d

	leave					# Эпилог функции
	ret

	.globl	calculateElapsedTime
calculateElapsedTime:				# Функция calculateElapsedTime
	push	rbp				# Пролог функции
	mov	rbp, rsp

	mov	rax, rsi			# Загрузка imespec t1 и timespec t2
	mov	r8, rdi
	mov	rsi, rdi
	mov	rdi, r9
	mov	rdi, rax
	mov	r12, rsi
	mov	r14, rdi
	mov	r11, rdx
	mov	r15, rcx
	mov	rax, r12
	mov	rbx, rax
	mov	rax, rbx
	imul	rax, rax, 1000000000		# ns1 *= 1000000000;
	mov	rbx, rax
	mov	rax, r14
	add	rbx, rax
	mov	rax, r11
	mov	r13, rax
	mov	rax, r13
	imul	rax, rax, 1000000000		# ns2 *= 1000000000;
	mov	r13, rax
	mov	rax, r15
	add	r13, rax
	mov	rax, r13
	sub	rax, rbx

	pop	rbp				# Эпилог функции
	ret
