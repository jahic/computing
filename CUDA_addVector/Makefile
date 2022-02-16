# To test time difference on Windows: timer.bat add OR timer.bat addVector
# # To test time difference on Linux: time add OR time addVector
all:
	nvcc addVector.cu -o add
	nvcc addVectorMultipleThreads.cu -o addVectorCuda
	gcc addVectorWithoutCuda.c -o addWithoutCuda
	
clean:
	rm add.* addWithoutCuda.* addVectorCuda.*