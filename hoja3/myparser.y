%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#ifndef YYSTYPE
#define YYSTYPE int
#endif
int yylex();
void yyerror(char *msg);
%}


%token TRUE
%token FALSE
%token '|'
%token '&'
%token '~'

%%
line : bexpr '\n' {if($1==1){printf("true(1)");}else{printf("false(0)");}}
     | '\n'       {printf("\n");}
     ;
bexpr : bexpr '&' bterm {if(($1==1)&&($3==1)){$$=1;}else{$$=0;}}
      | bterm
      ;
bterm : bterm '|' bfactor {if(($1==0)&&($3==0)){$$=0;}else{$$=1;}}
      | bfactor
      ;
bfactor : '~' bfactor {if($2==1){$$=0;}else{$$=1;}}
        | '('bexpr')' {$$=$2;}
        | TRUE
        | FALSE
        ;
%%
#pragma comment (lib, "yl.lib")

extern FILE * yyin;
int main(void)
{
    yyin=stdin;
    return yyparse();
}

void yyerror(char *msg){
	printf("Error de sintaxis");
	exit(0);
}
