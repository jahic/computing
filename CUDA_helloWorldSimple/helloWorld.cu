/**
*	@Author: https://cuda-tutorial.readthedocs.io/en/latest/tutorials/tutorial01/#tutorial-01-say-hello-to-cuda
*	adjusted by Jahic
*/

#include <stdio.h>

__global__ void cuda_hello(){
    printf("Hello World from GPU!\n");
}

int main() 
{
	// TODO: Try changing grid size (e.g., <<1,6>>) to see what happens. 
    cuda_hello<<<2,4>>>(); 
    return 0;
}