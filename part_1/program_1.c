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
