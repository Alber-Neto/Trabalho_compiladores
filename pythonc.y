%{
#include <stdio.h>
#include "lex.yy.c"
%}
%union {
char *str;
};
%token<str> PRINT ABREP FECHAP VIRGULA ID STR NUM FIM_ENTRADA DOISP IF WHILE VEZES MAIS MENOS IGUAL IGUALIGUAL DIFERENTEIGUAL IDENTA FIM_DE_LINHA




%type<str> LOOP CONDICIONAL VALOR COMPARACAO EXPRESSAO ATRIBUICAO 




%%




COMANDOS: COMANDO COMANDOS
    | FIM_ENTRADA {return 0;};




COMANDO: FUNCAO
    | LOOP
    | CONDICIONAL
    | ATRIBUICAO {printf("%s",$1);}
    | EXPRESSAO {printf("%s",$1);} 



FUNCAO: ID ABREP NUM FECHAP FIM_DE_LINHA{
    printf("int %s(int %s);\n", $1, $3);
    }
    | ID ABREP FECHAP FIM_DE_LINHA{
    printf("int %s();\n", $1);
    };




LOOP: WHILE ABREP VALOR COMPARACAO VALOR FECHAP DOISP FIM_DE_LINHA IDENTA EXPRESSAO {
    printf("while (%s%s%s){\n%s}\n",$3, $4, $5, $10);
    }
    | WHILE ABREP VALOR COMPARACAO VALOR FECHAP DOISP FIM_DE_LINHA IDENTA ATRIBUICAO {
    printf("while (%s%s%s){\n%s}\n",$3, $4, $5, $10);
    }




CONDICIONAL: IF ABREP VALOR COMPARACAO VALOR FECHAP DOISP FIM_DE_LINHA IDENTA EXPRESSAO {
    printf("if (%s%s%s){\n%s}\n",$3, $4, $5, $10);
    }
    | IF ABREP VALOR COMPARACAO VALOR FECHAP DOISP FIM_DE_LINHA IDENTA ATRIBUICAO {
    printf("if (%s%s%s){\n%s}\n",$3, $4, $5, $10);
    };


EXPRESSAO: ID IGUAL NUM MAIS NUM FIM_DE_LINHA{
    $$ = malloc(100);  // Aloca espaço suficiente para a string resultante.
    sprintf($$, "int %s = %s + %s;\n", $1, $3, $5);
    }
    | ID IGUAL NUM MENOS NUM FIM_DE_LINHA{
    $$ = malloc(100);  // Aloca espaço suficiente para a string resultante.
    sprintf($$, "int %s = %s + %s;\n", $1, $3, $5);
    }
    | ID IGUAL NUM VEZES NUM FIM_DE_LINHA{
    $$ = malloc(100);  // Aloca espaço suficiente para a string resultante.
    sprintf($$, "int %s = %s + %s;\n", $1, $3, $5);
    };


ATRIBUICAO: ID IGUAL NUM FIM_DE_LINHA {
    $$ = malloc(100);
    sprintf($$, "int %s = %s;\n", $1, $3);
    }
    | ID IGUAL STR FIM_DE_LINHA {
    $$ = malloc(100);
    sprintf($$, "char %s[] = %s;\n", $1, $3);
    };


COMPARACAO: IGUALIGUAL { $$ = "==";}
    | DIFERENTEIGUAL { $$ = "!=";};


VALOR: ID { $$ = $1; }
    | STR { $$ = $1; }
    | NUM { $$ = $1; } ;

%%
int main(int argc, char **argv){
        if(argc!=2)    
            printf("Modo de uso: ./a.out arquivo.print\n");
        else{
                yyin = fopen(argv[1], "r");
                if(!yyin){
                        printf("Arquivo %s não encontrado!\n", argv[1]);
                        return -1;
                }
                if( yyparse() == 0 )
                    printf("PROGRAMA RECONHECIDO!!!\n");
        fclose(yyin);
    }
    return 0;
}
