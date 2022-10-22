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
	.p2align 4
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
	push	rbx
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
	mov	eax, DWORD PTR 12[rsp]
	test	eax, eax
	jle	.L1
	lea	rbp, array_A[rip]
	xor	ebx, ebx
	.p2align 4,,10
	.p2align 3
.L3:
	mov	rsi, rbp
	mov	rdi, r12
	xor	eax, eax
	add	ebx, 1
	call	__isoc99_scanf@PLT
	mov	eax, DWORD PTR 12[rsp]
	add	rbp, 4
	cmp	eax, ebx
	jg	.L3
.L1:
	add	rsp, 16
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.size	inputArray, .-inputArray
	.p2align 4
	.globl	processArray
	.type	processArray, @function
processArray:
	endbr64
	xor	r8d, r8d
	test	edi, edi
	je	.L7
	mov	ecx, DWORD PTR array_A[rip]
	mov	DWORD PTR array_B[rip], ecx
	cmp	edi, 1
	jle	.L12
	lea	rax, array_A[rip+4]
	lea	esi, -2[rdi]
	mov	r8d, 1
	lea	rdx, 4[rax]
	lea	rdi, array_B[rip]
	lea	rsi, [rdx+rsi*4]
	.p2align 4,,10
	.p2align 3
.L10:
	mov	edx, DWORD PTR [rax]
	cmp	edx, ecx
	jl	.L9
	movsx	rcx, r8d
	add	r8d, 1
	mov	DWORD PTR [rdi+rcx*4], edx
	mov	ecx, edx
.L9:
	add	rax, 4
	cmp	rax, rsi
	jne	.L10
.L7:
	mov	eax, r8d
	ret
	.p2align 4,,10
	.p2align 3
.L12:
	mov	r8d, 1
	jmp	.L7
	.size	processArray, .-processArray
	.section	.rodata.str1.1
.LC3:
	.string	"Resulting B: "
.LC4:
	.string	"%d "
	.text
	.p2align 4
	.globl	outputArray
	.type	outputArray, @function
outputArray:
	endbr64
	push	r12
	xor	eax, eax
	lea	rsi, .LC3[rip]
	push	rbp
	mov	ebp, edi
	mov	edi, 1
	push	rbx
	call	__printf_chk@PLT
	test	ebp, ebp
	jle	.L15
	lea	rbx, array_B[rip]
	lea	edx, -1[rbp]
	lea	rax, 4[rbx]
	lea	rbp, .LC4[rip]
	lea	r12, [rax+rdx*4]
	.p2align 4,,10
	.p2align 3
.L17:
	mov	edx, DWORD PTR [rbx]
	mov	rsi, rbp
	mov	edi, 1
	xor	eax, eax
	add	rbx, 4
	call	__printf_chk@PLT
	cmp	rbx, r12
	jne	.L17
.L15:
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.size	outputArray, .-outputArray
	.p2align 4
	.globl	writeArray
	.type	writeArray, @function
writeArray:
	endbr64
	test	edi, edi
	jle	.L25
	push	r13
	lea	edx, -1[rdi]
	push	r12
	lea	r12, .LC4[rip]
	push	rbp
	mov	rbp, rsi
	push	rbx
	lea	rbx, array_B[rip]
	lea	rax, 4[rbx]
	lea	r13, [rax+rdx*4]
	sub	rsp, 8
	.p2align 4,,10
	.p2align 3
.L22:
	mov	ecx, DWORD PTR [rbx]
	mov	rdx, r12
	mov	esi, 1
	mov	rdi, rbp
	xor	eax, eax
	add	rbx, 4
	call	__fprintf_chk@PLT
	cmp	rbx, r13
	jne	.L22
	add	rsp, 8
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.p2align 4,,10
	.p2align 3
.L25:
	ret
	.size	writeArray, .-writeArray
	.p2align 4
	.globl	generateArray
	.type	generateArray, @function
generateArray:
	endbr64
	push	r12
	push	rbp
	push	rbx
	call	srand@PLT
	call	rand@PLT
	movsx	r12, eax
	cdq
	imul	r12, r12, 1717986919
	sar	r12, 35
	sub	r12d, edx
	lea	edx, [r12+r12*4]
	sal	edx, 2
	sub	eax, edx
	mov	r12d, eax
	test	eax, eax
	jle	.L28
	lea	rbp, array_A[rip]
	lea	eax, -1[rax]
	lea	rdx, 4[rbp]
	lea	rbx, [rdx+rax*4]
	.p2align 4,,10
	.p2align 3
.L30:
	call	rand@PLT
	add	rbp, 4
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1098413215
	sar	ecx, 31
	sar	rdx, 40
	sub	edx, ecx
	imul	edx, edx, 1001
	sub	eax, edx
	sub	eax, 500
	mov	DWORD PTR -4[rbp], eax
	cmp	rbp, rbx
	jne	.L30
.L28:
	mov	eax, r12d
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.size	generateArray, .-generateArray
	.p2align 4
	.globl	readArray
	.type	readArray, @function
readArray:
	endbr64
	push	r13
	xor	eax, eax
	push	r12
	lea	r12, .LC1[rip]
	push	rbp
	mov	rsi, r12
	mov	rbp, rdi
	push	rbx
	sub	rsp, 24
	lea	rdx, 12[rsp]
	call	__isoc99_fscanf@PLT
	mov	eax, DWORD PTR 12[rsp]
	test	eax, eax
	jle	.L33
	xor	ebx, ebx
	lea	r13, array_A[rip]
	.p2align 4,,10
	.p2align 3
.L35:
	lea	rdx, 0[r13+rbx*4]
	mov	rsi, r12
	mov	rdi, rbp
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	mov	eax, DWORD PTR 12[rsp]
	add	rbx, 1
	cmp	eax, ebx
	jg	.L35
.L33:
	add	rsp, 24
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.size	readArray, .-readArray
	.p2align 4
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
