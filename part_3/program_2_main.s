	.intel_syntax noprefix
	.text

	.globl	array_A				# Массив A
	.bss
	.align 32
	.type	array_A, @object
	.size	array_A, 400000
array_A:
	.zero	400000

	.globl	array_B				# Массив B
	.align 32
	.type	array_B, @object
	.size	array_B, 400000
array_B:
	.zero	400000

	.section	.rodata 		# Строки для main
.LC0:
	.string	"Generated A: "
.LC1:
	.string	"%d "
.LC2:
	.string	"r"
.LC3:
	.string	"Elapsed: %ld ns\n"
.LC4:
	.string	"w"

	.text
	.globl	main
main:						# Функция main, в ней сложно использовать регистры процессора для хранения локальных переменных, т.к. в вызываемых функциях регистры тоже используются для хранения переменных
	push	rbp				# Пролог функции
	mov	rbp, rsp
	sub	rsp, 96
	
	mov	DWORD PTR -84[rbp], edi		# Загрузка argc (argc в -84[rbp])
	
	mov	QWORD PTR -96[rbp], rsi		# Загрузка argv (argv в -96[rbp])
	
	cmp	DWORD PTR -84[rbp], 1		# Проверка количетва параметров консоли
	jne	.L2
	
	mov	eax, 0				# Вызов inputArray
	call	inputArray@PLT
	
	mov	DWORD PTR -4[rbp], eax		# array_A_size = inputArray() (array_A_size в -4[rbp])
	jmp	.L3
.L2:
	cmp	DWORD PTR -84[rbp], 2		# Проверка количетва параметров консоли
	jne	.L4
	
	mov	rax, QWORD PTR -96[rbp]		# array_A_size = generateArray(atoi(argv[1]))
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	edi, eax
	call	generateArray@PLT
	mov	DWORD PTR -4[rbp], eax
	
	lea	rdi, .LC0[rip]			# printf("Generated A: ")
	mov	eax, 0
	call	printf@PLT
	
	mov	ebx, 0				# i = 0 (i в ebx)
	jmp	.L5
.L6:
	mov	eax, ebx			# printf("%d ", array_A[i])
	lea	rdx, 0[0+rax*4]
	lea	rax, array_A[rip]
	mov	esi, DWORD PTR [rdx+rax]
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	printf@PLT
	
	add	ebx, 1				# i++
.L5:
	cmp	ebx, DWORD PTR -4[rbp]		# Выход из цикла
	jl	.L6

	mov	edi, 10				# printf("\n")
	call	putchar@PLT
	
	jmp	.L3
.L4:
	cmp	DWORD PTR -84[rbp], 3		# Проверка количетва параметров консоли
	jne	.L7
	
	mov	rax, QWORD PTR -96[rbp]		# input = fopen(argv[1], "r")
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	rdi, rax
	
	call	readArray@PLT			# Вызов readArray
	mov	DWORD PTR -4[rbp], eax		# array_A_size = readArray(input)
	jmp	.L3
.L7:
	mov	eax, -1				# Возврат -1
	jmp	.L8
.L3:
	lea	rsi, -64[rbp]			# clock_gettime(CLOCK_MONOTONIC, &t1)
	mov	edi, 1
	call	clock_gettime@PLT
	
	mov	edi, DWORD PTR -4[rbp]		# array_B_size = processArray(array_A_size)
	call	processArray@PLT
	mov	DWORD PTR -20[rbp], eax
	
	lea	rsi, -80[rbp]			# clock_gettime(CLOCK_MONOTONIC, &t2)
	mov	edi, 1
	call	clock_gettime@PLT
	
	mov	rax, QWORD PTR -80[rbp]		# elapsed_time = calculateElapsedTime(t1, t2);
	mov	rdx, QWORD PTR -72[rbp]
	mov	rdi, QWORD PTR -64[rbp]
	mov	rsi, QWORD PTR -56[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	calculateElapsedTime@PLT
	
	mov	rsi, rax			# printf("Elapsed: %ld ns\n", elapsed_time)
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	
	cmp	DWORD PTR -84[rbp], 3		# Проверка количетва параметров консоли
	jne	.L9
	
	mov	rax, QWORD PTR -96[rbp]		# output = fopen(argv[2], "w");
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC4[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	
	mov	rdx, rax			# writeArray(array_B_size, output)
	mov	eax, DWORD PTR -20[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	writeArray@PLT
	
	jmp	.L10
.L9:
	mov	edi, DWORD PTR -20[rbp]		# outputArray(array_B_size)
	call	outputArray@PLT
	
	mov	edi, 10				# printf("\n")
	call	putchar@PLT
.L10:
	mov	eax, 0				# Возврат 0
.L8:
	leave					# Эпилог функции
	ret
