	.intel_syntax noprefix			# Использование синтаксиса Intel
	.text

	.globl	array_A				# Массив A
	.bss
	.align 32
	.size	array_A, 400000
array_A:
	.zero	400000

	.globl	array_B				# Массив B
	.align 32
	.size	array_B, 400000
array_B:					
	.zero	400000

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

	lea	rax, .LC0[rip]			# printf("Input A size: ")
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT

	lea	rax, -8[rbp]			# Загрузка &array_A_size (это -8[rbp]) в rsi
	mov	rsi, rax

	lea	rax, .LC1[rip]			# Вызов scanf("%d", &array_A_size)
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT

	lea	rax, .LC2[rip]			# printf("Input A: ");
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT

	mov	DWORD PTR -4[rbp], 0		# i = 0 (i находится в -4[rbp])

	jmp	.L2
.L3:
	mov	eax, DWORD PTR -4[rbp]		# Запись i в eax
	
	lea	rdx, 0[0+rax*4]			# Запись &array_A[i] в rsi
	lea	rax, array_A[rip]
	add	rax, rdx
	mov	rsi, rax
	
	lea	rax, .LC1[rip]			# scanf("%d", &array_A[i])
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	
	add	DWORD PTR -4[rbp], 1		# i++
.L2:
	mov	eax, DWORD PTR -8[rbp]		# Если i < array_A_size, то не происходит выход из цикла
	cmp	DWORD PTR -4[rbp], eax
	jl	.L3
	
	mov	eax, DWORD PTR -8[rbp]		# Запись array_A_size в eax для возврата
	
	leave					# Эпилог функции
	ret

	.globl	processArray
processArray:					# Функция processArray
	push	rbp				# Пролог функции
	mov	rbp, rsp
	
	mov	DWORD PTR -20[rbp], edi		# Загрузка array_A_size (по адресу -20[rbp])
	
	mov	DWORD PTR -4[rbp], 0		# array_B_size = 0 (array_B_size по адресу -4[rbp])
	
	cmp	DWORD PTR -20[rbp], 0		# Если array_A_size != 0, то прыжок на .L6, иначе на .L7
	jne	.L6
	mov	eax, 0				# Возврат 0
	jmp	.L7

.L6:
	mov	eax, DWORD PTR array_A[rip]	# array_B[0] = array_A[0]
	mov	DWORD PTR array_B[rip], eax
	
	add	DWORD PTR -4[rbp], 1		# array_B_size++
	
	mov	DWORD PTR -8[rbp], 1		# i = 1 (i по адресу -8[rbp])
	
	jmp	.L8
.L10:
	mov	eax, DWORD PTR -8[rbp] 		# Запись i в eax
	
	lea	rdx, 0[0+rax*4]			# Если array_A[i] < array_B[array_B_size - 1], то прыжок на .L9
	lea	rax, array_A[rip]
	mov	edx, DWORD PTR [rdx+rax]
	mov	eax, DWORD PTR -4[rbp]
	sub	eax, 1
	lea	rcx, 0[0+rax*4]
	lea	rax, array_B[rip]
	mov	eax, DWORD PTR [rcx+rax]
	cmp	edx, eax
	jl	.L9
	
	mov	eax, DWORD PTR -8[rbp]		# array_B[array_B_size] = array_A[i]
	lea	rdx, 0[0+rax*4]
	lea	rax, array_A[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	edx, DWORD PTR -4[rbp]
	lea	rcx, 0[0+rdx*4]
	lea	rdx, array_B[rip]
	mov	DWORD PTR [rcx+rdx], eax
	
	add	DWORD PTR -4[rbp], 1		# array_B_size++
.L9:
	add	DWORD PTR -8[rbp], 1		# i++
.L8:
	mov	eax, DWORD PTR -8[rbp]		# Если i < array_A_size, то не происходит выход из цикла
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L10
	
	mov	eax, DWORD PTR -4[rbp]		# Запись array_B_size в eax для возврата
.L7:
	pop	rbp				# Эпилог функции
	ret
	.size	processArray, .-processArray

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
	sub	rsp, 32
	
	mov	DWORD PTR -20[rbp], edi		# Загрузка array_B_size (по адресу -20[rbp])
	
	lea	rax, .LC3[rip]			# printf("Resulting B: ")
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	
	mov	DWORD PTR -4[rbp], 0		# i = 0 (i по адресу -4[rbp]) 
	jmp	.L12
.L13:
	mov	eax, DWORD PTR -4[rbp]		# Запись i в eax
	
	lea	rdx, 0[0+rax*4]			# Запись array_B[i] в esi
	lea	rax, array_B[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	esi, eax
	
	lea	rax, .LC4[rip]			# printf("%d ", array_B[i])
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	
	add	DWORD PTR -4[rbp], 1		# i++
.L12:
	mov	eax, DWORD PTR -4[rbp]		# Если i < array_B_size, то не происходит выход из цикла
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L13
	
	leave					# Эпилог функции
	ret

	.globl	main
main:						# Функция main
	push	rbp				# Пролог функции
	mov	rbp, rsp
	sub	rsp, 16
	
	mov	eax, 0				# Вызов inputArray
	call	inputArray
	
	mov	DWORD PTR -4[rbp], eax		# Запись резлультата inputArray в array_A_size (array_A_size по адресу -4[rbp])
	
	mov	eax, DWORD PTR -4[rbp]		# Запись array_A_size в edi для передачи в processArray
	mov	edi, eax
	
	call	processArray			# Вызов processArray(array_A_size)
	
	mov	DWORD PTR -8[rbp], eax		# Запись резлультата processArray в array_B_size (array_B_size по адресу -8[rbp])
	
	mov	eax, DWORD PTR -8[rbp]		# Запись array_B_size в edi для передачи в processArray
	mov	edi, eax
	
	call	outputArray			# Вызов outputArray(array_B_size)
	
	mov	eax, 0				# Возврат 0
	
	leave					# Эпилог функции
	ret
