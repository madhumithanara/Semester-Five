
%{ 
    /* Definition section */
    #include <stdio.h> 
    #include <stdlib.h> 
    #include "calc3.tab.h" 
%} 
  
/* %option noyywrap */
  
/* Rule Section */
%% 
  
[0-9a-zA-Z]+   {yylval.f = yytext; return STR;} 
[-+()*/]    {return yytext[0];} 
[ \t\n]      {;} 
  
%% 
  
 int yywrap() 
 {  
  return -1;  
 }   
