/**
*	@AUTHOR: https://cuda-tutorial.readthedocs.io/en/latest/tutorials/tutorial01/#tutorial-01-say-hello-to-cuda
*/


#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>

#define N 1000000
#define MAX_ERR 1e-6

__global__ void vector_add(float *out, float *a, float *b, int n) {
	//printf("Cuda thread here\n");
	//int index=blockIdx.x*blockDim.x+threadIdx.x;
	//printf("	Global thread ID = %d.\n", index);
	for(int j=0; j<(N/5000); j++)
	{
	    for(int i = 0; i < n; i ++)
		{
			out[i] = a[i] + b[i];
			if(out[i]>1)
				out[i] = out[i] * (b[i] + a[i]);
		}
	}
}

int main()
{
    float *a, *b, *out;
    float *d_a, *d_b, *d_out; 

    // Allocate host memory
    a   = (float*)malloc(sizeof(float) * N);
    b   = (float*)malloc(sizeof(float) * N);
    out = (float*)malloc(sizeof(float) * N);

    // Initialize host arrays
    for(int i = 0; i < N; i++)
	{
        a[i] = 2.0f;
        b[i] = 3.0f;
    }

    // Allocate device memory
    cudaMalloc((void**)&d_a, sizeof(float) * N);
    cudaMalloc((void**)&d_b, sizeof(float) * N);
    cudaMalloc((void**)&d_out, sizeof(float) * N);

    // Transfer data from host to device memory
    cudaMemcpy(d_a, a, sizeof(float) * N, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, sizeof(float) * N, cudaMemcpyHostToDevice);

    // Executing kernel 
    vector_add<<<1,1>>>(d_out, d_a, d_b, N);
    
    // Transfer data back to host memory
    cudaMemcpy(out, d_out, sizeof(float) * N, cudaMemcpyDeviceToHost);

    // Verification
    /*for(int i = 0; i < N; i++)
	{
        assert(fabs(out[i] - a[i] - b[i]) < MAX_ERR);
    }*/
	// Sum
	double doubleSum=0;
	for(int i = 0; i < N; i++)
	{
        doubleSum = doubleSum+out[i];
    }
	
    printf("out[0] = %f\n", out[0]);
	printf("doubleSum = %f\n", doubleSum);
    printf("PASSED\n");

    // Deallocate device memory
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_out);

    // Deallocate host memory
    free(a); 
    free(b); 
    free(out);
}
