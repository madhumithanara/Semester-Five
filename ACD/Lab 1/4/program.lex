
%{ 
int count = 0; 
%} 

alpha    [a-zA-Z]
digit      [0-9]
space    [ \t\n]



%% 
"//"({alpha}|{digit}|[ \t])*"\n" {count++;}
"/*"({alpha}|{digit}|{space})*"*/" {count++;}
%% 

int yywrap(){} 
int main(){ 

yyin=fopen("abc.c","r");
yyout=fopen("output.c", "w");
yylex();
printf("\n-------------------\nNo. of comment lines : %d\n\n",count);
printf("Find file as output.c\n\n");
return 0; 
} 

