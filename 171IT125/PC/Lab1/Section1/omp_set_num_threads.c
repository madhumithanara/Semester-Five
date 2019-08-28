#include "omp.h"
#include<stdio.h>

int main()
{
	omp_set_num_threads(10);
	#pragma omp parallel
	{
		int ID = omp_get_thread_num();
		printf("Hello World (%d) \n", ID);
		// ID = ID + 1;
	}

	return 0;
}