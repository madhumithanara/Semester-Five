%{
#include<stdio.h>
#include<stdlib.h>
int c,d,bo=0,bc=0;
int l = 0, operand = 0;
%}
operand [a-zA-Z0-9]+
operator [+\-\/*]
%%

{operator} {d++;printf("%s is an operator \n",yytext);
			if(operand==0)
				{printf("Invalid");exit(0);}
			else
				{operand = 0;}
				
				} 

{operand} {c++;printf("%s is an operand \n",yytext);
			if(operand==1)
				{printf("Invalid");exit(0);}
			else
				{operand = 1;}	
		  }

"(" {if(bc<=bo)bo++; if(l==1)
						{printf("Invalid");
						exit(0);}
					 else
						{ l = 1; }					 
						
						
						}

")" {bc++;if(l==0)
			{printf("Invalid");exit(0);}
		  else
		  	{l=0;}
			
			}

\n {if(bo==bc&&((c-d)==1))
	{printf("Valid\n");}
	else 
	{printf("Invalid\n");}
	exit(0);}
%%
void main(){
yylex();
}