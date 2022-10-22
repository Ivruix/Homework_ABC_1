	.file	"program_2_main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
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
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	endbr64
	push	r14
	push	r13
	push	r12
	mov	r12, rsi
	push	rbp
	push	rbx
	mov	ebx, edi
	sub	rsp, 32
	dec	edi
	jne	.L2
	xor	eax, eax
	call	inputArray@PLT
	jmp	.L12
.L2:
	cmp	ebx, 2
	jne	.L4
	mov	rdi, QWORD PTR 8[rsi]
	xor	r13d, r13d
	lea	r14, array_A[rip]
	call	atoi@PLT
	mov	edi, eax
	call	generateArray@PLT
	lea	rsi, .LC0[rip]
	mov	edi, 1
	mov	ebp, eax
	xor	eax, eax
	call	__printf_chk@PLT
.L5:
	cmp	ebp, r13d
	jle	.L14
	mov	edx, DWORD PTR [r14+r13*4]
	lea	rsi, .LC1[rip]
	mov	edi, 1
	xor	eax, eax
	inc	r13
	call	__printf_chk@PLT
	jmp	.L5
.L14:
	mov	edi, 10
	call	putchar@PLT
	jmp	.L3
.L4:
	or	eax, -1
	cmp	ebx, 3
	jne	.L1
	mov	rdi, QWORD PTR 8[rsi]
	lea	rsi, .LC2[rip]
	call	fopen@PLT
	mov	rdi, rax
	call	readArray@PLT
.L12:
	mov	ebp, eax
.L3:
	mov	rsi, rsp
	mov	edi, 1
	call	clock_gettime@PLT
	mov	edi, ebp
	call	processArray@PLT
	lea	rsi, 16[rsp]
	mov	edi, 1
	mov	ebp, eax
	call	clock_gettime@PLT
	mov	rdx, QWORD PTR 16[rsp]
	mov	rdi, QWORD PTR [rsp]
	mov	rsi, QWORD PTR 8[rsp]
	mov	rcx, QWORD PTR 24[rsp]
	call	calculateElapsedTime@PLT
	lea	rsi, .LC3[rip]
	mov	edi, 1
	mov	rdx, rax
	xor	eax, eax
	call	__printf_chk@PLT
	cmp	ebx, 3
	jne	.L8
	mov	rdi, QWORD PTR 16[r12]
	lea	rsi, .LC4[rip]
	call	fopen@PLT
	mov	edi, ebp
	mov	rsi, rax
	call	writeArray@PLT
	jmp	.L9
.L8:
	mov	edi, ebp
	call	outputArray@PLT
	mov	edi, 10
	call	putchar@PLT
.L9:
	xor	eax, eax
.L1:
	add	rsp, 32
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
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
