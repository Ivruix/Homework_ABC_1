
# Отчёт по ИДЗ 1

## Об отчёте

**Вариант:** 28

**Задание:** Сформировать массив B из элементов массива A, которые образуют неубывающую последовательность. Неубывающей последовательностью считать элементы идущие подряд, которые равны между собой или каждый последующий больше предыдущего.

Данный отчёт разбит на блоки по оценкам для удобства проверки. Были выполнены все задания до оценки 9 включительно.

## На 4 и 5

> Все файлы к этому этапу находятся в папке **part_1**

Для решения задачи был написан файл **program_1.c**:

```c
#include <stdio.h>

int array_A[100000];
int array_B[100000];

int inputArray() {
    int array_A_size;
    
    printf("Input A size: ");
    scanf("%d", &array_A_size);
    
    printf("Input A: ");
    for (int i = 0; i < array_A_size; i++) {
        scanf("%d", &array_A[i]);
    }
    
    return array_A_size;
}

int processArray(int array_A_size) {
    int array_B_size = 0;
    
    if (array_A_size == 0) {
        return 0;
    }
    
    array_B[0] = array_A[0];
    array_B_size++;
    
    for (int i = 1; i < array_A_size; i++) {
        if (array_A[i] >= array_B[array_B_size - 1]) {
            array_B[array_B_size] = array_A[i];
            array_B_size++;
        }
    }
    
    return array_B_size;
}

void outputArray(int array_B_size) {
    printf("Resulting B: ");
    for (int i = 0; i < array_B_size; i++) {
        printf("%d ", array_B[i]);
    }
}

int main() {
    int array_A_size, array_B_size;
    
    array_A_size = inputArray();
    array_B_size = processArray(array_A_size);
    outputArray(array_B_size);
}
```

После компиляции и комментирования кода получился файл **program_1.s**:

```gas
	.file	"program_1.c"			# Название файла 
	.intel_syntax noprefix			# Использование синтаксиса Intel
	.text
	.globl	array_A
	.bss
	.align 32
	.type	array_A, @object
	.size	array_A, 400000
array_A:					# Массив A
	.zero	400000
	.globl	array_B
	.align 32
	.type	array_B, @object
	.size	array_B, 400000
array_B:					# Массив B
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
	.type	inputArray, @function
inputArray:					# Функция inputArray
	endbr64
	
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
	
	cdqe
	
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

	.size	inputArray, .-inputArray
	.globl	processArray
	.type	processArray, @function
processArray:					# Функция processArray
	endbr64
	
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
	
	cdqe
	
	lea	rdx, 0[0+rax*4]			# Если array_A[i] < array_B[array_B_size - 1], то прыжок на .L9
	lea	rax, array_A[rip]
	mov	edx, DWORD PTR [rdx+rax]
	mov	eax, DWORD PTR -4[rbp]
	sub	eax, 1
	cdqe
	lea	rcx, 0[0+rax*4]
	lea	rax, array_B[rip]
	mov	eax, DWORD PTR [rcx+rax]
	cmp	edx, eax
	jl	.L9
	
	mov	eax, DWORD PTR -8[rbp]		# array_B[array_B_size] = array_A[i]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, array_A[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
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
	.type	outputArray, @function
outputArray:					# Функция outputArray
	endbr64
	
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
	
	cdqe
	
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
	
	nop					# Ничего не делает
	nop
	
	leave					# Эпилог функции
	ret

	.size	outputArray, .-outputArray
	.globl	main
	.type	main, @function
main:						# Функция main
	endbr64
	
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
	.size	main, .-main
```

После этого были убраны лишние макросы (по типу endbr64, nop, cdqe, movsx). Получился файл **program_1_modified.s**:

```gas
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
```

Оба файла были ассемблированы и скомпонованы. Получились файлы **program_1.out** и **program_1_modified.out**. 

Исполняемые файлы были проверены на тестах из папки **tests**. Результаты обоих программ во всех случаях одинаковые и верные.

## На оценку 6

> Все файлы к этому этапу находятся в папке **part_2**

Был произведен рефакторинг файла **program_1_modified.s** для максимизирования использования регистров процессора. Изменены соответствующие комментарии. Также были оптимизированы конструкции, в которых запись в регистр происходит через предварительную запись в другой регистр. Получился файл **program_1_refactored.s**:

```gas
	.file	"program_1.c"			# Название файла 
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

	.globl	main
main:						# Функция main
	push	rbp				# Пролог функции
	mov	rbp, rsp

	mov	eax, 0				# Вызов inputArray
	call	inputArray
	
	mov	ebx, eax			# Запись резлультата inputArray в array_A_size (array_A_size в ebx)
	
	mov	edi, ebx			# Запись array_A_size в edi для передачи в processArray
	
	call	processArray			# Вызов processArray(array_A_size)
	
	mov	r12d, eax			# Запись резлультата processArray в array_B_size (array_B_size в r12d)
	
	mov	edi, r12d			# Запись array_B_size в edi для передачи в processArray
	
	call	outputArray			# Вызов outputArray(array_B_size)
	
	mov	eax, 0				# Возврат 0
	
	leave					# Эпилог функции
	ret
```

Файл был ассемблирован и скомпонован. Получился файл **program_1_refactored.out**.

Исполняемый файл был проверен на тестах из папки **tests**. Результаты программы оказались верными.

## На оценку 7, 8

> Все файлы к этому этапу находятся в папке **part_3**

Был добавлен следующий функционал:

1. Задание файлов ввода и вывода (происходит, если в командной строке два параметра, это пути до файла ввода и вывода соответственно)
2. Задание массива A случайными числами (происходит, если в командной строке один параметр, это seed)
3. Измерение времени выполнения программы

Код был разбит на 2 файла. Первый из них это **program_2_main.c**:

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern int inputArray();
extern int generateArray(int seed);
extern int readArray(FILE *input);
extern int processArray(int array_A_size);
extern void outputArray(int array_B_size);
extern void writeArray(int array_B_size, FILE *output);
extern int64_t calculateElapsedTime(struct timespec t1, struct timespec t2);

int array_A[100000];
int array_B[100000];

int main(int argc, char** argv) {
    int array_A_size, array_B_size;
    FILE *input, *output;
    struct timespec t1;
    struct timespec t2;
    int64_t elapsed_time;
    
    if (argc == 1) {
        array_A_size = inputArray();
    } else if (argc == 2) {
        array_A_size = generateArray(atoi(argv[1]));
        printf("Generated A: ");
        for (int i = 0; i < array_A_size; i++) {
            printf("%d ", array_A[i]);
    	}
    	printf("\n");
    } else if (argc == 3) {
        input = fopen(argv[1], "r");
        array_A_size = readArray(input);
    } else {
        return -1;
    }
    
    clock_gettime(CLOCK_MONOTONIC, &t1);
    
    array_B_size = processArray(array_A_size);
    
    clock_gettime(CLOCK_MONOTONIC, &t2);
    elapsed_time = calculateElapsedTime(t1, t2);
    printf("Elapsed: %ld ns\n", elapsed_time);
    
    
    if (argc == 3) {
        output = fopen(argv[2], "w");
        writeArray(array_B_size, output);
    } else {
        outputArray(array_B_size);
        printf("\n");
    }
}
```

Второй это **program_2_helpers.c**:

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern int array_A[];
extern int array_B[];

int inputArray() {
    int array_A_size;
    
    printf("Input A size: ");
    scanf("%d", &array_A_size);
    
    printf("Input A: ");
    for (int i = 0; i < array_A_size; i++) {
        scanf("%d", &array_A[i]);
    }
    
    return array_A_size;
}

int processArray(int array_A_size) {
    int array_B_size = 0;
    
    if (array_A_size == 0) {
        return 0;
    }
    
    array_B[0] = array_A[0];
    array_B_size++;
    
    for (int i = 1; i < array_A_size; i++) {
        if (array_A[i] >= array_B[array_B_size - 1]) {
            array_B[array_B_size] = array_A[i];
            array_B_size++;
        }
    }
    
    return array_B_size;
}

void outputArray(int array_B_size) {
    printf("Resulting B: ");
    for (int i = 0; i < array_B_size; i++) {
        printf("%d ", array_B[i]);
    }
}

void writeArray(int array_B_size, FILE *output) {
    for (int i = 0; i < array_B_size; i++) {
        fprintf(output, "%d ", array_B[i]);
    }
}

int generateArray(int seed) {
    srand(seed);
    int array_A_size = rand() % 20;

    for (int i = 0; i < array_A_size; i++) {
    	array_A[i] = rand() % 1001 - 500;
    }
    
    return array_A_size;
}

int readArray(FILE *input) {
    int array_A_size;
    
    fscanf(input, "%d", &array_A_size);
    
    for (int i = 0; i < array_A_size; i++) {
        fscanf(input, "%d", &array_A[i]);
    }
    
    return array_A_size;
}

extern int64_t calculateElapsedTime(struct timespec t1, struct timespec t2) {
    int64_t ns1, ns2;

    ns1 = t1.tv_sec;
    ns1 *= 1000000000;
    ns1 += t1.tv_nsec;


    ns2 = t2.tv_sec;
    ns2 *= 1000000000;
    ns2 += t2.tv_nsec;

    return ns2 - ns1;
}
```
После компиляции, оптимизации и оптимизирования получились 2 файла.
Файл **program_2_main.o**:
```gas
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
```

И файл **program_2_helpers.o**:

```gas
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
```
Файлы были ассемблированы и скомпонованы. Получился файл **program_2.out**.
Программа была проверена на тестовых данных, результаты верные.
Также программа была проверена по времени:

| Количество элементов | Время выполнения |
|----------------------|------------------|
|          1           |      1352 ns     |
|          6           |      1623 ns     |
|          15          |      3767 ns     |
|          4e6         |      0.976 s     |

## На оценку 9

> Все файлы к этому этапу находятся в папке **part_4**

### Оптимизация по скорости

Из файлов **program_2_main.c** и **program_2_helpers.c** был сформирован код на ассемблере  (**program_2_main_speed.s** и **program_2_helpers_speed.s**) используя флаг оптимизации по скорости. Полученные файлы были ассемблированы и скомпонованы, получился файл **program_2_speed.out**.

### Оптимизация по размеру

Из файлов **program_2_main.c** и **program_2_helpers.c** был сформирован код на ассемблере  (**program_2_main_size.s** и **program_2_helpers_size.s**) используя флаг оптимизации по размеру. Полученные файлы были ассемблированы и скомпонованы, получился файл **program_2_size.out**.

Сравнение полученных программ:

|                                      | program_1 | program_2 | program_2_speed | program_2_size |
|--------------------------------------|-----------|-----------|-----------------|----------------|
|       Размер ассемблерного кода      |   4540 B  |  10487 B  |     7380 B      |     5992 B     |
|       Размер исполняемого файла      |  16104 B  |  16536 B  |     16728 B     |     16728 B    |
| Производительность (на 10 элементах) |     ?     |  2176 ns  |     110 ns      |     150 ns     |
