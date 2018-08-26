DEL BottleCap.exe, lex.yy.c, y.output, y.tab.h, y.tab.c
flex BottleCap.l
bison -dyv BottleCap.y
gcc lex.yy.c y.tab.c -o BottleCap.exe