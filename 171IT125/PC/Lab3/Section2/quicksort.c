/* Serial QuickSort */
#include <stdio.h> 
#include <stdlib.h> 
#include <omp.h>

#define MAXSIZE 100

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

// void quickSortParallel(int arr[], int low, int high) 
// { 
// 	if (low < high) 
// 	{ 
// 		int pi;
		
// 		// #pragma omp task shared(pi)
// 		pi = partition(arr, low, high); 

// 		#pragma omp task
// 		quickSortParallel(arr, low, pi - 1); 

// 		#pragma omp task
// 		quickSortParallel(arr, pi + 1, high); 

// 		#pragma omp taskwait
// 	} 
// } 

void quickSort_parallel(int* array, int lenArray, int numThreads){

	int cutoff = 100;

	#pragma omp parallel num_threads(numThreads)
	{	
		#pragma omp single nowait
		{
			quickSort_parallel_internal(array, 0, lenArray-1, cutoff);	
		}
	}	

}



void quickSort_parallel_internal(int* array, int left, int right, int cutoff) 
{
	
	int i = left, j = right;
	int tmp;
	int pivot = array[(left + right) / 2];

	
	{
	  	/* PARTITION PART */
		while (i <= j) {
			while (array[i] < pivot)
				i++;
			while (array[j] > pivot)
				j--;
			if (i <= j) {
				tmp = array[i];
				array[i] = array[j];
				array[j] = tmp;
				i++;
				j--;
			}
		}

	}


	if ( ((right-left)<cutoff) ){
		if (left < j){ quickSort_parallel_internal(array, left, j, cutoff); }			
		if (i < right){ quickSort_parallel_internal(array, i, right, cutoff); }

	}else{
		#pragma omp task 	
		{ quickSort_parallel_internal(array, left, j, cutoff); }
		#pragma omp task 	
		{ quickSort_parallel_internal(array, i, right, cutoff); }		
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
	int loop;
	int n  = 0;
	int iterations = 10;
	printf("Size\t\tSerial\t\tParallel\t\tSpeed Up\n");

	for(loop=0;loop<iterations;loop++)
	{
	n += 10000;
	
	printf("\n%d\t\t",n);

	int arr_serial[n],arr_parallel[n],i,temp;
	double time,serial,parallel;

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
    printf ( "%12f\t\t", time);
    serial = time;

    time = omp_get_wtime();

	quickSort_parallel(arr_parallel, n, 10); 
	// printf("Sorted array: \n\n\n"); 
	// printArray(arr_parallel, n); 
	time = omp_get_wtime() - time;
    printf ( "%12f\t\t", time);
    parallel = time;

    printf ( "%12f\n", serial/parallel);


	}
	return 0; 
} 
