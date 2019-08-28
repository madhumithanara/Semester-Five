#include "omp.h"
#include<stdio.h>

int main()
{
	#pragma omp parallel num_threads(10)
	{
		int ID = omp_get_thread_num();
		printf("Hello World (%d) \n", ID);
		// ID = ID + 1;
	}

	return 0;
}