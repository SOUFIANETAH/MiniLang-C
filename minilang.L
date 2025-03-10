%option noyywrap
%{
#include <stdio.h>
#include <string.h>
#include "minilangy.h"

void yyerror(const char *s);
%}

%%
[ \t\n]         ;
"int"           { return INT; }
"float"         { return FLOAT; }
"string"         { return STRING; }
"="             { return ASSIGN; }
";"             { return semic; }
[0-9]+\.[0-9]+  { yylval.fval = atof(yytext); return FLOAT_VAL; }
[0-9]+          { yylval.ival = atoi(yytext); return INT_VAL; }
[a-zA-Z][a-zA-Z0-9_]* { 
    yylval.id = strdup(yytext);
    return IDENT; 
}
.               { printf("Caractere non reconnu : %s\n", yytext); }
%%
