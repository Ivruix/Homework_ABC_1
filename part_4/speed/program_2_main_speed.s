	.file	"program_2_main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Elapsed: %ld ns\n"
.LC1:
	.string	"Generated A: "
.LC2:
	.string	"%d "
.LC3:
	.string	"r"
.LC4:
	.string	"w"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	endbr64
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 40
	cmp	edi, 1
	je	.L14
	mov	rbx, rsi
	cmp	edi, 2
	je	.L15
	cmp	edi, 3
	jne	.L9
	mov	rdi, QWORD PTR 8[rsi]
	lea	rsi, .LC3[rip]
	call	fopen@PLT
	mov	rdi, rax
	call	readArray@PLT
	mov	rsi, rsp
	mov	edi, 1
	mov	ebp, eax
	call	clock_gettime@PLT
	mov	edi, ebp
	call	processArray@PLT
	lea	rsi, 16[rsp]
	mov	edi, 1
	mov	ebp, eax
	call	clock_gettime@PLT
	mov	rcx, QWORD PTR 24[rsp]
	mov	rdx, QWORD PTR 16[rsp]
	mov	rdi, QWORD PTR [rsp]
	mov	rsi, QWORD PTR 8[rsp]
	call	calculateElapsedTime@PLT
	lea	rsi, .LC0[rip]
	mov	edi, 1
	mov	rdx, rax
	xor	eax, eax
	call	__printf_chk@PLT
	mov	rdi, QWORD PTR 16[rbx]
	lea	rsi, .LC4[rip]
	call	fopen@PLT
	mov	edi, ebp
	mov	rsi, rax
	call	writeArray@PLT
.L8:
	xor	eax, eax
.L1:
	add	rsp, 40
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L14:
	xor	eax, eax
	call	inputArray@PLT
	mov	edi, 1
	mov	rsi, rsp
	mov	ebp, eax
	call	clock_gettime@PLT
	mov	edi, ebp
.L12:
	call	processArray@PLT
	lea	rsi, 16[rsp]
	mov	edi, 1
	mov	ebp, eax
	call	clock_gettime@PLT
	mov	rcx, QWORD PTR 24[rsp]
	mov	rdx, QWORD PTR 16[rsp]
	mov	rdi, QWORD PTR [rsp]
	mov	rsi, QWORD PTR 8[rsp]
	call	calculateElapsedTime@PLT
	lea	rsi, .LC0[rip]
	mov	edi, 1
	mov	rdx, rax
	xor	eax, eax
	call	__printf_chk@PLT
	mov	edi, ebp
	call	outputArray@PLT
	mov	edi, 10
	call	putchar@PLT
	jmp	.L8
.L15:
	mov	rdi, QWORD PTR 8[rsi]
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	edi, eax
	call	generateArray@PLT
	lea	rsi, .LC1[rip]
	mov	edi, 1
	mov	r13d, eax
	xor	eax, eax
	call	__printf_chk@PLT
	test	r13d, r13d
	jle	.L5
	lea	rbx, array_A[rip]
	lea	eax, -1[r13]
	lea	rdx, 4[rbx]
	lea	rbp, .LC2[rip]
	lea	r12, [rdx+rax*4]
	.p2align 4,,10
	.p2align 3
.L6:
	mov	edx, DWORD PTR [rbx]
	mov	rsi, rbp
	mov	edi, 1
	xor	eax, eax
	add	rbx, 4
	call	__printf_chk@PLT
	cmp	r12, rbx
	jne	.L6
.L5:
	mov	edi, 10
	call	putchar@PLT
	mov	edi, 1
	mov	rsi, rsp
	call	clock_gettime@PLT
	mov	edi, r13d
	jmp	.L12
.L9:
	or	eax, -1
	jmp	.L1
	.size	main, .-main
	.globl	array_B
	.bss
	.align 32
	.type	array_B, @object
	.size	array_B, 400000
array_B:
	.zero	400000
	.globl	array_A
	.align 32
	.type	array_A, @object
	.size	array_A, 400000
array_A:
	.zero	400000
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
