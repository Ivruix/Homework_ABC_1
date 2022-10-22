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
