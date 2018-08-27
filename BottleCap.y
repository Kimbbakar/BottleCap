%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s); 
void PutInStack(int val);
int stack[10003],idx = 10001;
%}

%union {
	int INT; 
	char str[100]; 
}



%token PRINT T_NEWLINE ASSIGN ADD TO WITH
%token<INT> T_INT 
%token<str> T_ID
%type<INT> TERM RPN EXPR


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
 
STMT: PRINT EXPR			{printf("%d\n",$2);}
	| EXPR
;

EXPR: ADD EXPR WITH EXPR 	{$$ = $2 + $4;}
	| RPN					{$$ = $1;}
;

RPN:  VALUE  				{$$=stack[idx++];}
	| VALUE RPN				{$$=$2;}
	| OP RPN				{$$=$2;}
	| OP					{$$=stack[idx++];}
;

VALUE: TERM					{PutInStack($1);}
;

TERM: T_INT					{$$=$1;}
;

OP:   T_PLUS				{ if(10001-idx>=2){stack[idx+1] =stack[idx+1] + stack[idx];idx++; } else{yyerror("Wrong Expression!");}  }
    | T_MINUS				{ if(10001-idx>=2){stack[idx+1] =stack[idx+1] - stack[idx];idx++; } else{yyerror("Wrong Expression!");}}
    | T_MULTIPLY			{ if(10001-idx>=2){stack[idx+1] =stack[idx+1] * stack[idx];idx++; } else{yyerror("Wrong Expression!");}}
    | T_DIVIDE				{ if(10001-idx>=2 || stack[idx] ==0 ){stack[idx+1] =stack[idx+1] / stack[idx];idx++; } else{yyerror("Wrong Expression!");}}
    | T_MOD				{ if(10001-idx>=2 || stack[idx] ==0 ){stack[idx+1] =stack[idx+1] % stack[idx];idx++; } else{yyerror("Wrong Expression!");}}
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



void PutInStack(int val){
	stack[--idx] = val;
}

 