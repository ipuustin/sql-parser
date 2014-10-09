%{

/*
 * lexer.l file
 * To generate the lexical analyzer run: "flex lexer.l"
 */

#include "Statement.h"
#include "List.h"
#include "lex_parser.h"

#include <stdio.h>
#include <iostream>
using namespace std;

#define TOK(name) { return name; }

%}


%option outfile="lex_lexer.c" header-file="lex_lexer.h"
%option warn nodefault
%option reentrant noyywrap never-interactive nounistd
%option bison-bridge
%option case-insensitive

%%

[ \t\n]+	;

SELECT	TOK(SELECT)
FROM	TOK(FROM)
GROUP	TOK(GROUP)
BY	TOK(BY)

[-+*/(),.;]	TOK(yytext[0])

[0-9]+	|
[0-9]+"."[0-9]* |
"."[0-9]*	TOK(INTNUM)

[A-Za-z][A-Za-z0-9_]* {
	yylval->sval = strdup(yytext);
	return STRING;
}

%%

int yyerror(const char *msg) {
    fprintf(stderr,"Error:%s\n",msg); return 0;
}