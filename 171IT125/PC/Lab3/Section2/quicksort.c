/* Serial QuickSort */
#include <stdio.h> 
#include <stdlib.h> 
#include <omp.h>

#define n 10000
#define MAXSIZE 100000

void swap(int* a, int* b) 
{ 
	int t = *a; 
	*a = *b; 
	*b = t; 
} 

int partition (int arr[], int low, int high) 
{ 
	int pivot = arr[high]; 
	int i = (low - 1);

	for (int j = low; j <= high- 1; j++) 
	{ 
		if (arr[j] < pivot) 
		{ 
			i++;
			swap(&arr[i], &arr[j]); 
		} 
	} 
	swap(&arr[i + 1], &arr[high]); 
	return (i + 1); 
} 

void quickSort(int arr[], int low, int high) 
{ 
	if (low < high) 
	{ 
		int pi = partition(arr, low, high); 
		quickSort(arr, low, pi - 1); 
		quickSort(arr, pi + 1, high); 
	} 
} 

void quickSortParallel(int arr[], int low, int high) 
{ 
	if (low < high) 
	{ 
		int pi;
		
		#pragma omp task shared(pi)
		pi = partition(arr, low, high); 

		#pragma omp taskwait
		quickSortParallel(arr, low, pi - 1); 

		#pragma omp taskwait
		quickSortParallel(arr, pi + 1, high); 
	} 
} 


void printArray(int arr[], int size) 
{ 
	int i; 
	for (i=0; i < size; i++) 
		printf("%d ", arr[i]); 
} 


int main() 
{ 
	int arr_serial[n],arr_parallel[n],i,temp;
	double time;

	for(i=0;i<n;i++)
	{
		temp = random() % MAXSIZE;
		arr_serial[i] = temp;
		arr_parallel[i] = temp;
	} 

	time = omp_get_wtime();
	quickSort(arr_serial, 0, n-1); 
	// printf("Sorted array: \n\n\n"); 
	// printArray(arr_serial, n); 
	time = omp_get_wtime() - time;
    printf ( "\n\n\nTime taken in seconds for serial: %12f\n", time);

    time = omp_get_wtime();
	quickSort(arr_parallel, 0, n-1); 
	// printf("Sorted array: \n\n\n"); 
	// printArray(arr_parallel, n); 
	time = omp_get_wtime() - time;
    printf ( "\n\n\nTime taken in seconds for parallel: %12f\n", time);


	return 0; 
} 
