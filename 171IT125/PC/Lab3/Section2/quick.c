#include<omp.h>
#include<stdio.h>
#include<stdlib.h>
#include<time.h>

void quickSort_parallel(int* array, int lenArray, int numThreads);
void quickSort_parallel_internal(int* array, int left, int right, int cutoff);

void checksort(int* a,int size){
	for(int i=1;i<size;i++){
		if(a[i]<a[i-1]){
			printf("Not Sorted!!\n");
			return;
		}
	}
	printf("Sorted!!\n");
}

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


int main()
{
    int size=500000;
    int array[size];
    srand((unsigned)time(0)); 
     
    for(int i=0; i<size; i++){ 
        array[i] = (rand()%10000000)+1; 
    }
	checksort(array,size);
	double start=omp_get_wtime();
	printf("Sorting...\n");
	quickSort_parallel(array,size,10);
    double end=omp_get_wtime();
	checksort(array,size);
	printf("Time taken for parallel : %lf\n",end-start);
	printf("-----------------------------------------------------------------\n");
}