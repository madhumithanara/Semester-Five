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
	double start_time,time_taken;
	
	printf("Enter the nth fibonacci number to print\n");
	scanf("%lld",&n);
	
	start_time = omp_get_wtime();
	answer = fib_serial(n);
	time_taken = omp_get_wtime()-start_time;
    printf("nth fibonacci number is %lld\n",answer);
	printf("Time taken for serial approach is %lf s\n",time_taken);

    start_time = omp_get_wtime();
    #pragma omp parallel
    {
        #pragma omp single
		answer = fib_serial(n);
    }
	time_taken = omp_get_wtime()-start_time;
    printf("The nth fibonacci number is %lld\n",answer);
	printf("Time taken for parallel approach is %lf s\n",time_taken);

    start_time = omp_get_wtime();
    #pragma omp parallel
    {
        #pragma omp single
		answer = fib_parallel(n);
    }
	time_taken = omp_get_wtime()-start_time;
    printf("The nth fibonacci number is %lld\n",answer);
	printf("Time taken for parallel approach with taskwait is %lf s\n",time_taken);

	return 0;
} 