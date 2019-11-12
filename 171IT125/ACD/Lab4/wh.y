%token ID NUM WHILE begin END
%right '='
%left '+' '-'
%left '*' '/' LE GE EQ NE
%left UMINUS
%%

S : WHILE{lab1();} '(' E ')'{lab2();} E ';'{lab3();}
  ;
E :V '='{push();} E{codegen_assign();}
  | E '+'{push();} E{codegen();}
  | E '-'{push();} E{codegen();}
  | E '*'{push();} E{codegen();}
  | E '/'{push();} E{codegen();}
  | E LE {push();} E{codegen();}
  | E GE {push();} E{codegen();}
  | E EQ {push();} E{codegen();}
  | E NE {push();} E{codegen();}
  | '(' E ')'
  | '-'{push();} E{codegen_umin();} %prec UMINUS
  | V
  | NUM{push();}
  ;
V : ID {push();}
  ;
%%

#include "lex.yy.c"
#include<ctype.h>
char st[100][10];
int top=0;
char i_[2]="0";
char temp[2]="t";

int lnum=1;
int start=1;
main()
 {
 printf("Enter the expression : ");
 yyparse();
 }

push()
 {
  strcpy(st[++top],yytext);
 }

codegen()
 {
 strcpy(temp,"t");
 strcat(temp,i_);
  printf("%s = %s %s %s\n",temp,st[top-2],st[top-1],st[top]);
  top-=2;
 strcpy(st[top],temp);
 i_[0]++;
 }

codegen_umin()
 {
 strcpy(temp,"t");
 strcat(temp,i_);
 printf("%s = -%s\n",temp,st[top]);
 top--;
 strcpy(st[top],temp);
 i_[0]++;
 }

codegen_assign()
 {
 printf("%s = %s\n",st[top-2],st[top]);
 top-=2;
 }

lab1()
{
printf("L%d: \n",lnum++);
}

lab2()
{
 strcpy(temp,"t");
 strcat(temp,i_);
 printf("%s = not %s\n",temp,st[top]);
 printf("if %s goto L%d\n",temp,lnum);
 i_[0]++;
 }

lab3()
{
printf("goto L%d \n",start);
printf("L%d: \n",lnum);
}
/* output
lab7@ubuntu:~/Desktop/ic/while final$ lex while.l
lab7@ubuntu:~/Desktop/ic/while final$ yacc while.y
lab7@ubuntu:~/Desktop/ic/while final$ gcc y.tab.c -ll -ly
lab7@ubuntu:~/Desktop/ic/while final$ ./a.out
Enter the expression : while(k=c/s)k=k*c+d;
L1: 
t0 = c / s
k = t0
t1 = not k
if t1 goto L0
t2 = k * c
t3 = t2 + d
k = t3
goto L1 
L0: 
*/