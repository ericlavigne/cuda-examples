# Squares

This program demonstrates a few of the most basic CUDA operations:

* Defining a kernel - code that will run on a GPU
* Allocating memory in CPU and GPU
* Copying input data from the CPU to the GPU
* Invoking a kernel to perform GPU computation
* Copying output data from the GPU to the CPU

This example is copied almost exactly from Udacity's
[Intro to Parallel Programming course.](https://eu.udacity.com/course/intro-to-parallel-programming--cs344)

## Usage

```bash
nvcc -o main main.cu
./main
```
