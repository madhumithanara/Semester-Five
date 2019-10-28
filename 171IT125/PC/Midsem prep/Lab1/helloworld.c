#include<stdio.h>
#include<omp.h>


int main()
{
	omp_set_num_threads(10);
	#pragma omp parallel 
	{
	
	int i  = omp_get_thread_num();
	printf("Hello World %d!\n",i);
	}
	return 0;
}