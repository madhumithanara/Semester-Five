#include "omp.h"
#include<stdio.h>

int main()
{
	#pragma omp parallel
	{
		int ID = 0;
		printf("Hello(%d) ", ID);
		printf(" World(%d) \n", ID);
		// ID = ID + 1;
	}

	return 0;
}