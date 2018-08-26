%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s); 
%}

%union {
	int INT; 
	char str[100]; 
}



%token PRINT T_NEWLINE ASSIGN ADD TO
%token<INT> T_INT 
%token<str> T_ID
%type<INT> TERM RPN


%left T_MINUS 
%left T_PLUS
%left T_MULTIPLY 
%left T_DIVIDE    
%left T_MOD    


%start PROG

%%
PROG: STMTS
	
;

STMTS:						{ printf("Program End\n"); exit(0) ;}
	| STMT T_NEWLINE STMTS 
	| T_NEWLINE STMTS
;
 
STMT: PRINT TERM			{printf("%d\n",$2);}

;

EXPR: ADD RPN with RPN
;

RPN:
;
TERM: T_INT					{$$=$1;}
;


%%
int main() {
	yyin = stdin;
	do { 
		yyparse();
	} while(!feof(yyin));
	return 0;
}
void yyerror(const char* s) { 
	fprintf(stderr, "%s\n", s); 
	exit(1);
}

int stack[10003],idx = 0;



 