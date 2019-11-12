ALPHA [A-Za-z]
DIGIT [0-9]
%%
while                return WHILE;
{ALPHA}({ALPHA}|{DIGIT})*    return ID;
{DIGIT}+             {yylval=atoi(yytext); return NUM;}
"<="    return LE;
">="    return GE;
"=="    return EQ;
"!="    return NE;
"begin"	return begin;
"end"	return END;
[ \t\n]+                 ;
.                 return yytext[0];
%%