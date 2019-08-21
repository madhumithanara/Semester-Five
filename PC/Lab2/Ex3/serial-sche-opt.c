// Parallelised version of the previous program
#include <stdio.h>
#include <omp.h>


int prime(int n)
{
    int i,j,prime,total=0;
    #pragma omp parallel shared(n) private(i,j,prime)
    #pragma omp for reduction(+:total)
        for( i = 2; i <= n; i++ ){
            prime = 1;
            for ( j = 2; j < i; j++ ){
                if ( i % j == 0 ){
                    prime = 0;
                    break;
                }
            }
            total = total + prime;
        }
    return total;
}

int main(){
    int n,factor,start,end,primes;
    double time;
    printf("\n");
    printf("  Count the primes from 1 to N using parallel approach.\n" );
    printf("\n");
    printf("  Number of processors available = %d\n", omp_get_num_procs( ));
    printf("  Number of threads = %d\n", omp_get_max_threads( ));
    start = 1;
    end = 1e5;
    factor = 10;
    printf("\n");
    printf("         N     Primes(N)     Time\n");
    printf("\n");
    n = start;
    while (n<=end){
        time = omp_get_wtime ( );
        primes = prime(n);
        time = omp_get_wtime ( ) - time;
        printf ( "  %8d  %8d  %12f\n", n, primes, time);
        n = n * factor;
    }
    return 0;
}