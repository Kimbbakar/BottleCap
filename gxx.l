%option noyywrap

%{
#include <stdio.h>
#include <string.h>

#define YY_DECL int yylex()

#include "y.tab.h"

%}

%%


[ \t]   ; // ignore all whitespace
[0-9][0-9]*             {printf("INT = %s\n",yytext);yylval.INT = atoi(yytext) ; return T_INT;}
"+"                     {printf("OP = %s\n",yytext); return T_PLUS;}
"-"                     {printf("OP = %s\n",yytext); return T_MINUS;}
"*"                     {printf("OP = %s\n",yytext); return T_MULTIPLY;}
"/"                     {printf("OP = %s\n",yytext); return T_DIVIDE;}
"SAY:"					{return SAY;}
"%"                     {printf("OP = %s\n",yytext); return T_MOD;}

\n                      {return T_NEWLINE;}
[a-zA-Z][a-zA-Z0-9]*    {strcpy(yylval.str , yytext) ;printf("ID = %s\n",yytext); return T_ID;}
.						{yyerror("Invalid Syntex!") ;}
%%