
#include <omp.h>
#include <stdio.h>


static long num_steps= 100000000;    
double step;
void main ()
{

	double begin;
	begin = omp_get_wtime();
	int i;   
	double x, pi, sum = 0.0;
	step = 1.0/(double) num_steps;

	#pragma omp parallel 
	{
	double x;
	#pragma omp for 
	for (i=0;i< num_steps; i++)
		{
			x = (i+0.5)*step;
			sum = sum + 4.0/(1.0+x*x);
			#pragma omp critical
			pi = sum * step;
		}

	
	
	}

	printf("PI is: %lf\n",pi);

	printf("Time is: %lf\n", omp_get_wtime() - begin);
}