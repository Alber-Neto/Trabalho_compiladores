%{
#include <string.h>
#include "pythonc.tab.h"
int yyerror(char* erro){
 printf("Erro na linha %d: %s\nEm %s\n", yylineno, erro, yytext);
}
%}

%option noyywrap
BRANCO [ ]
ESPACO {BRANCO}+
DIGITO [0-9]
NUMERO {DIGITO}+
LETRA [A-Za-z]
STRING \"[^"]*\"
IDENTIFICADOR {LETRA}+
IDENTACAO {BRANCO}{BRANCO}{BRANCO}{BRANCO}

%%
"print" { return PRINT;}
"==" { return IGUALIGUAL;}
"!=" { return DIFERENTEIGUAL;}
"if" {return IF;}
"while" {return WHILE;}
"*" {return VEZES;}
"+" {return MAIS;}
"-" {return MENOS;}
"=" {return IGUAL;}
"(" { return ABREP; }
")" { return FECHAP; }
"," {return VIRGULA;}
":" {return DOISP;}
{IDENTIFICADOR} { yylval.str = strdup(yytext); return ID;}
{STRING} { yylval.str = strdup(yytext); return STR;}
{NUMERO} { yylval.str = strdup(yytext); return NUM; }
{IDENTACAO} { return IDENTA; }
<<EOF>> { return FIM_ENTRADA; }
. { yyerror("Token desconhecido."); }
"\n" { yylineno++; return FIM_DE_LINHA; }
%%