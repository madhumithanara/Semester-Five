#include <omp.h> 
#include <stdio.h> 
#include <stdlib.h>


long long int fib_serial(long long int n) 
{
  	long long int i, j;
  	if (n < 2)
        return n;
  	else 
  	{
    	i = fib_serial(n-1);
    	j = fib_serial(n-2);
    	return i + j;
  	}
}

long long int fib_parallel(long long int n) 
{
	/*To get good performance you need to use a cutoff value for "n". 
	Otherwise, too many small tasks will be generated. 
	Once the value of "n" gets below this threshold it is best to simply execute the serial version without tasking.*/
  	long long int i, j;
  	if (n < 20)
        return fib_serial(n);
  	else 
  	{
    	#pragma omp task shared(i)
    	i = fib_parallel(n-1);
    	#pragma omp task shared(j)
    	j = fib_parallel(n-2);
    	#pragma omp taskwait
    	return i + j;
  	}
}


int main()
{
    long long int n,answer;
	double start_time,time_taken,serial,parallel;
	int iterations = 10, i;
	printf("Size\t\tSerial Time(s)\t\tWith Task(s)\t\tWith Taskwait(s)\t\tSpeed Up\t\tAnswer Correct?\n");

	
	n=0;

	for(i=0;i<iterations;i++)
	{
	n= n + 10;
	printf("\n%lld\t\t",n);
	start_time = omp_get_wtime();
	answer = fib_serial(n);
	time_taken = omp_get_wtime()-start_time;
	printf("%lf\t\t",time_taken);
	serial = time_taken;

    start_time = omp_get_wtime();
    #pragma omp parallel
    {
        #pragma omp single
		answer = fib_serial(n);
    }
	time_taken = omp_get_wtime()-start_time;
	printf("%lf\t\t",time_taken);

    start_time = omp_get_wtime();
    #pragma omp parallel
    {
        #pragma omp single
		answer = fib_parallel(n);
    }
	time_taken = omp_get_wtime()-start_time;
	printf("%lf\t\t",time_taken);
	printf("\t%lf\t\t",serial/time_taken);
	printf("Yes\n");
	}
	return 0;
} 