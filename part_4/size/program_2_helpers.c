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
