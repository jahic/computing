/**
*	@Author: https://cuda-tutorial.readthedocs.io/en/latest/tutorials/tutorial01/#tutorial-01-say-hello-to-cuda
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>

#define N 1000000
#define MAX_ERR 1e-6

void vector_add(float *out, float *a, float *b, int n) {
	for(int j=0; j<(N/1000); j++)
	{
		for(int i = 0; i < n; i++)
		{
			out[i] = a[i] + b[i];
			if(out[i]>1)
				out[i] = out[i] * (b[i] + a[i]);
		}
	}
}

int main(){
    float *a, *b, *out; 

    // Allocate memory
    a   = (float*)malloc(sizeof(float) * N);
    b   = (float*)malloc(sizeof(float) * N);
    out = (float*)malloc(sizeof(float) * N);
	//printf("Memory allocated.\n");
    // Initialize array
    for(int i = 0; i < N; i++){
        a[i] = 2.0f;
        b[i] = 3.0f;
    }

    // Main function
	//printf("Call vector_add.\n");
    vector_add(out, a, b, N);
	//printf("Return vector_add.\n");
    // Verification
    /*for(int i = 0; i < N; i++){
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
	
	free(a);
	free(b);
	free(out);
}