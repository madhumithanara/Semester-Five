// serial program that has two independent jobs
// - find average of every two consecutive elements of an array
// - find inverse of evenry element in an array 

#include <omp.h>
#include <stdio.h>
int main(){
    int i;
    int n=100000;
    int a[100000];
    int c[100000];
    double b[100000],d[100000];
    
    for(i=0; i<n-1;i++)
    {
        a[i] = i;
        c[i] = i;
    }
    

    double start_time = omp_get_wtime();
    for(i=0; i<n-1;i++)
    {
        b[i]=(a[i]+a[i+1])/2.0;
    }

    for(i=0;i<n;i++)
    {
        d[i]=1.0/c[i];
    }

    
    printf("Time taken for serial two independent jobs = %lfsec\n",omp_get_wtime()-start_time);
}