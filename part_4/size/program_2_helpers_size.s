	.file	"program_2_helpers.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Input A size: "
.LC1:
	.string	"%d"
.LC2:
	.string	"Input A: "
	.text
	.globl	inputArray
	.type	inputArray, @function
inputArray:
	endbr64
	push	r12
	lea	rsi, .LC0[rip]
	mov	edi, 1
	xor	eax, eax
	push	rbp
	lea	r12, .LC1[rip]
	lea	rbp, array_A[rip]
	push	rbx
	xor	ebx, ebx
	sub	rsp, 16
	call	__printf_chk@PLT
	lea	rsi, 12[rsp]
	mov	rdi, r12
	xor	eax, eax
	call	__isoc99_scanf@PLT
	lea	rsi, .LC2[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
.L2:
	mov	eax, DWORD PTR 12[rsp]
	cmp	eax, ebx
	jle	.L6
	mov	rsi, rbp
	mov	rdi, r12
	xor	eax, eax
	inc	ebx
	call	__isoc99_scanf@PLT
	add	rbp, 4
	jmp	.L2
.L6:
	add	rsp, 16
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.size	inputArray, .-inputArray
	.globl	processArray
	.type	processArray, @function
processArray:
	endbr64
	xor	eax, eax
	test	edi, edi
	je	.L7
	mov	eax, DWORD PTR array_A[rip]
	mov	edx, 1
	lea	r9, array_A[rip]
	lea	rsi, array_B[rip]
	mov	DWORD PTR array_B[rip], eax
	mov	eax, 1
.L9:
	cmp	edi, edx
	jle	.L7
	lea	ecx, -1[rax]
	mov	r8d, DWORD PTR [r9+rdx*4]
	movsx	rcx, ecx
	cmp	r8d, DWORD PTR [rsi+rcx*4]
	jl	.L10
	movsx	rcx, eax
	inc	eax
	mov	DWORD PTR [rsi+rcx*4], r8d
.L10:
	inc	rdx
	jmp	.L9
.L7:
	ret
	.size	processArray, .-processArray
	.section	.rodata.str1.1
.LC3:
	.string	"Resulting B: "
.LC4:
	.string	"%d "
	.text
	.globl	outputArray
	.type	outputArray, @function
outputArray:
	endbr64
	push	r12
	lea	rsi, .LC3[rip]
	xor	eax, eax
	lea	r12, array_B[rip]
	push	rbp
	mov	ebp, edi
	mov	edi, 1
	push	rbx
	xor	ebx, ebx
	call	__printf_chk@PLT
.L14:
	cmp	ebp, ebx
	jle	.L17
	mov	edx, DWORD PTR [r12+rbx*4]
	lea	rsi, .LC4[rip]
	mov	edi, 1
	xor	eax, eax
	inc	rbx
	call	__printf_chk@PLT
	jmp	.L14
.L17:
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.size	outputArray, .-outputArray
	.globl	writeArray
	.type	writeArray, @function
writeArray:
	endbr64
	push	r13
	lea	r13, array_B[rip]
	push	r12
	mov	r12, rsi
	push	rbp
	mov	ebp, edi
	push	rbx
	xor	ebx, ebx
	push	rdx
.L19:
	cmp	ebp, ebx
	jle	.L22
	mov	ecx, DWORD PTR 0[r13+rbx*4]
	mov	esi, 1
	mov	rdi, r12
	xor	eax, eax
	lea	rdx, .LC4[rip]
	inc	rbx
	call	__fprintf_chk@PLT
	jmp	.L19
.L22:
	pop	rax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.size	writeArray, .-writeArray
	.globl	generateArray
	.type	generateArray, @function
generateArray:
	endbr64
	push	r12
	push	rbp
	lea	rbp, array_A[rip]
	push	rbx
	xor	ebx, ebx
	call	srand@PLT
	call	rand@PLT
	mov	esi, 20
	cdq
	idiv	esi
	mov	r12d, edx
.L24:
	cmp	r12d, ebx
	jle	.L27
	call	rand@PLT
	mov	ecx, 1001
	cdq
	idiv	ecx
	sub	edx, 500
	mov	DWORD PTR 0[rbp+rbx*4], edx
	inc	rbx
	jmp	.L24
.L27:
	mov	eax, r12d
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.size	generateArray, .-generateArray
	.globl	readArray
	.type	readArray, @function
readArray:
	endbr64
	push	r13
	xor	eax, eax
	lea	r13, array_A[rip]
	push	r12
	lea	r12, .LC1[rip]
	push	rbp
	mov	rsi, r12
	mov	rbp, rdi
	push	rbx
	xor	ebx, ebx
	sub	rsp, 24
	lea	rdx, 12[rsp]
	call	__isoc99_fscanf@PLT
.L29:
	mov	eax, DWORD PTR 12[rsp]
	cmp	eax, ebx
	jle	.L32
	lea	rdx, 0[r13+rbx*4]
	mov	rsi, r12
	mov	rdi, rbp
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	inc	rbx
	jmp	.L29
.L32:
	add	rsp, 24
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.size	readArray, .-readArray
	.globl	calculateElapsedTime
	.type	calculateElapsedTime, @function
calculateElapsedTime:
	endbr64
	imul	rdx, rdx, 1000000000
	imul	rdi, rdi, 1000000000
	add	rdx, rcx
	add	rdi, rsi
	mov	rax, rdx
	sub	rax, rdi
	ret
	.size	calculateElapsedTime, .-calculateElapsedTime
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
