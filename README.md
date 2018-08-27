<h1 align = "center">Flex And Bison</h1>


<h3 align = "center">Token and Regular Expression</h3>

```
- [ \t]   			; // ignore all whitespace
- [0-9][0-9]*               	{return T_INT;}
- "+"                       	{return T_PLUS;}
- "-"                       	{return T_MINUS;}
- "*"                       	{return T_MULTIPLY;}
- "/"                       	{return T_DIVIDE;}
- "Print"			{return PRINT;}
- "%"                       	{return T_MOD;}
- "Add"	                 	{return ADD;}
- "Assign"			{return ASSIGN;}
- "Subtract"			{return SUB;}
- "Multiply"			{return MUL;}
- "Divide"			{return DIV;}
- "by"				{return BY;}
- "from"			{return FROM;}
- "to"				{return TO;}
- "with"			{return WITH;}
- \n                        	{return T_NEWLINE;}
- [a-zA-Z][a-zA-Z0-9]*      	{return T_ID;}
- .				{yyerror("Invalid Syntex!") ;}
```

<h3 align = "center">Grammer</h3>

~~~
PROG: STMTS	

STMTS:					   
	| STMT T_NEWLINE STMTS 
	| T_NEWLINE STMTS
	| STMT 					
;

STMT: EXPR
	| PRINT EXPR			 
	| ASSIGN T_ID TO EXPR 	 
;

EXPR: ADD EXPR WITH EXPR 	 
	| SUB EXPR FROM EXPR 	 
	| MUL EXPR BY EXPR 		 
	| DIV EXPR BY EXPR 		 	
	| RPN					 
	| TERM 					 
;

RPN:  TERM RPN				 
	| OP RPN				 
	| OP					 
;
 

TERM: T_INT					 
	| T_ID 					 
;

OP:   T_PLUS				 
    | T_MINUS				 
    | T_MULTIPLY			 
    | T_DIVIDE				 
    | T_MOD					 
;

~~~

<h3 align = "center">Compile Process</h3>

```
flex BottleCap.l
bison -dyv BottleCap.y
gcc lex.yy.c y.tab.c -o BottleCap.exe
BottleCap.exe < sample.txt
```

<h3 align = "center">Sample Program</h3>
<b>Input:</b>

```
Assign a to 10
Assign b to Add a a * with a a +
Print b
Assign b to 10
Print b
Print Divide a by b
Print 10 a b * * 2 +
```

<b>Output:</b>
```
120
10
1
1002
Program End
```

<h3 align = "center">Limitation </h3>

- It only takes <i>Reverse Polish Notation</i>  expression.
- Arithmetic operations only allowed for integer.

