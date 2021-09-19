#include <stdio.h>
/*

   This program computes the max number of inversion for a permutation of length n
   max permutations is (n^2 - n)/2

*/

__global__ void inversionPairs(int* row, int* inversions) {
    if (blockIdx.x < threadIdx.x) {
        if (row[blockIdx.x] > row[threadIdx.x]) {
            inversions[blockIdx.x*blockDim.x + threadIdx.x] = 1;
        }
    }
}

__global__ void countInversions(int* inversions, int width) {
    int sum = 0;
    for (int i = 0; i < width; i++) {
        sum += inversions[width*threadIdx.x+i];
        inversions[width*threadIdx.x+i] = 0;
    }
    inversions[width*threadIdx.x] = sum;

}

int main() {
    int n = 1<<10;

    // Allocate row
    int* host_row = (int*) malloc(sizeof(int)*n);
    for (int i = 0; i < n; i++) {
        host_row[n-1-i] = i;
    }
    int* dev_row;
    cudaMalloc((void**)&dev_row, sizeof(int)*n);
    cudaMemcpy(dev_row, host_row, sizeof(int)*n, cudaMemcpyHostToDevice);

    // Allocate Inversions
    int* dev_inversions;
    cudaMalloc((void**)&dev_inversions, sizeof(int)*n*n);
    int* host_inversions = (int*) malloc(sizeof(int)*n*n);

    // GPU funcs
    inversionPairs<<<n,n>>>(dev_row, dev_inversions);
    for (int i = 1; i <= n*n; i *= 2) {
        countInversions<<<1,(n*n)/i>>>(dev_inversions, i);
    }

    // Copy memory to host
    cudaMemcpy(host_inversions, dev_inversions, sizeof(int)*n*n, cudaMemcpyDeviceToHost);

    // Print
    /*
    for (int i = 0; i < n*n; i++) {
        if (host_inversions[i] == 1) {
            printf("(%d, %d)\n", i/n, i%n);
        }
    }
    */
    printf("Inversions: %d\n", host_inversions[0]);


    // Free memory
    free(host_row);
    free(host_inversions);
    cudaFree(dev_row);
    cudaFree(dev_inversions);


    return 0;
}
