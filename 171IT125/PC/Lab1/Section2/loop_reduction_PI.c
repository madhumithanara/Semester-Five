#include <omp.h>
#include <stdio.h>

static long num_steps= 1000000000;         
double step;
void main ()
{    
	double start_time = omp_get_wtime();
	int i; 
	double x, pi, sum = 0.0; 
	step = 1.0/(double) num_steps;
	#pragma omp parallel 
	{
		double x;
		#pragma omp for reduction(+:sum)

		for (i=0;i< num_steps; i++)
			{
				x = (i+0.5)*step;
				sum = sum + 4.0/(1.0+x*x);
			}
	}
	pi = step * sum;
	printf("PI is: %lf\n",pi);

	double time = omp_get_wtime() - start_time;

    printf("Total time = %lf seconds\n",time);
}