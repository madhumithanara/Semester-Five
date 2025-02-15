#include <time.h>
#include <stdio.h>


static long num_steps= 1000000000;    
double step;
void main ()
{

	struct timespec begin, end;
    clock_gettime(CLOCK_MONOTONIC_RAW, &begin);


	int i;   
	double x, pi, sum = 0.0;
	step = 1.0/(double) num_steps;
	for (i=0;i< num_steps; i++)
		{
			x = (i+0.5)*step;
			sum = sum + 4.0/(1.0+x*x);
		}
	pi = step * sum;
	printf("PI is: %lf\n",pi);

	clock_gettime(CLOCK_MONOTONIC_RAW, &end);

    printf ("Total time = %f seconds\n",
            (end.tv_nsec - begin.tv_nsec) / 1000000000.0 +
            (end.tv_sec  - begin.tv_sec));

}
