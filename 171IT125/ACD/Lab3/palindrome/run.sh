flex -o calc3.lex.c -l pal.l
bison -o calc3.tab.c -vd pal.y
gcc -o calc3 calc3.lex.c calc3.tab.c -lm -ll