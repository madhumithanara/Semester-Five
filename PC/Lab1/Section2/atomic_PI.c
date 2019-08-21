#include <omp.h>
#include <stdio.h>
static long num_steps= 1000000000;         
double step;
#define NUM_THREADS 10
void main ()
{
	double  pi; 
	double start_time = omp_get_wtime();
	double step = 1.0/(double) num_steps;
	omp_set_num_threads(NUM_THREADS);
	#pragma omp parallel
	{
		int i, id,nthrds;    
		double x, sum;
		id = omp_get_thread_num();
		nthrds= omp_get_num_threads();
		for (i=id, sum=0.0;i< num_steps; i=i+nthrds)
			{
				x = (i+0.5)*step;
				sum += 4.0/(1.0+x*x);
			}

		sum = sum*step;

		#pragma atomic
		pi += sum ;
	}

	printf("PI is: %lf\n",pi);
	double time = omp_get_wtime() - start_time;

    printf("Total time = %lf seconds\n",time);
}