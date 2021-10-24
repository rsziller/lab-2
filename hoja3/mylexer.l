%{
#include "y.tab.h"
extern int yylval;
#include <stdlib.h>
#include <stdio.h>
%}

%%
[ \t]		 { /* Espacios en blanco */ }
true {yytext, yylval = 1; return TRUE;}
false {yytext, yylval= 0; return FALSE;}
or {yytext, yylval = 1; return '|';}
and {yytext, yylval= 0; return '&';}
not {yytext, yylval = 1; return '~';}
.|\n {return yytext[0];}

%%

int yywrap(void)
{
	return 0;
}
