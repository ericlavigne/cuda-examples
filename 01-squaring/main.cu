#include <stdio.h>

__global__ void square(float* d_out, float* d_in) {
  int idx = threadIdx.x;
  float f = d_in[idx];
  d_out[idx] = f * f;
}

int main(int argc, char** argv) {
  const int ARRAY_SIZE = 64;
  const int ARRAY_BYTES = ARRAY_SIZE * sizeof(float);

  // Generate input array on host
  float h_in[ARRAY_SIZE];
  for(int i = 0; i < ARRAY_SIZE; i++) {
    h_in[i] = float(i);
  }
  // Generate output array on host
  float h_out[ARRAY_SIZE];

  // Declare GPU (device) memory pointers
  float * d_in;
  float * d_out;

  // Allocate GPU memory
  cudaMalloc((void**) &d_in, ARRAY_BYTES);
  cudaMalloc((void**) &d_out, ARRAY_BYTES);

  // Transfer input array to GPU
  cudaMemcpy(d_in, h_in, ARRAY_BYTES, cudaMemcpyHostToDevice);

  // Launch the kernel with one block of ARRAY_SIZE threads
  square<<<1, ARRAY_SIZE>>>(d_out, d_in);

  // Copy result back to the CPU
  cudaMemcpy(h_out, d_out, ARRAY_BYTES, cudaMemcpyDeviceToHost);

  // Print out the result
  for(int i = 0; i < ARRAY_SIZE; i++) {
    printf("%f", h_out[i]);
    printf(((i % 4) == 3) ? "\n" : "\t");
  }

  // Free GPU memory allocation
  cudaFree(d_in);
  cudaFree(d_out);

  return 0;
}

