%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef char* string;

typedef struct {
    char *name;
    int type;  
    union {
        int ival;
        float fval;
        char *sval;  
    } value;
} Var;

#define MAX_VARIABLES 100
Var symbol_table[MAX_VARIABLES];
int var_c = 0;

void yyerror(const char *s);
int yylex(void);
void add_variable(char *name, int type);
Var* find_variable(char *name);
%}

%union {
    int ival;
    float fval;
    char *sval;  
    char *id;
}

%token <ival> INT_VAL
%token <fval> FLOAT_VAL
%token <sval> STR_VAL
%token <id> IDENT
%token INT FLOAT STRING 
%token ASSIGN semic

%%

bloc: 
    instructions
    ;

instructions:
    instruction
    | instructions instruction
    ;

instruction:
    declar
    | assigner
    ;

declar:
    INT IDENT semic {
        add_variable($2, 0);
        printf("Declaration de variable ont : %s\n", $2);
        free($2);
    }
    | FLOAT IDENT semic {
        add_variable($2, 1);
        printf("Declaration de variable float : %s\n", $2);
        free($2);
    }
    | STRING IDENT semic {
        add_variable($2, 2); 
        printf("Declaration de variable string : %s\n", $2);
        free($2);
    }
    ;

assigner:
    IDENT ASSIGN INT_VAL semic {
        Var *var = find_variable($1);
        if (var) {
            if (var->type == 0) {
                var->value.ival = $3;
                printf("Affectation de %d a %s\n", $3, $1);
            } else {
                printf("Erreur de type : %s n'est pas un int\n", $1);
            }
        } else {
            printf("Variable non declaree : %s\n", $1);
        }
        free($1);
    }
    | IDENT ASSIGN FLOAT_VAL semic {
        Var *var = find_variable($1);
        if (var) {
            if (var->type == 1) {
                var->value.fval = $3;
                printf("Affectation de %f a %s\n", $3, $1);
            } else {
                printf("Erreur de type : %s n'est pas un float\n", $1);
            }
        } else {
            printf("Variable non declaree : %s\n", $1);
        }
        free($1);
    }
    | IDENT ASSIGN STR_VAL semic {
        Var *var = find_variable($1);
        if (var) {
            if (var->type == 2) { 
                if (var->value.sval) {
                    free(var->value.sval);  
                }
                var->value.sval = strdup($3);  
                printf("Affectation de \"%s\" a %s\n", $3, $1);
            } else {
                printf("Erreur de type : %s n'est pas un string\n", $1);
            }
        } else {
            printf("Variable non declaree : %s\n", $1);
        }
        free($1);
        free($3);  
    }
    ;

%%

void add_variable(char *name, int type) {
    if (var_c >= MAX_VARIABLES) {
        printf("Erreur : trop de variables\n");
        return;
    }
    if (find_variable(name)) {
        printf("Erreur : variable %s deja declaree\n", name);
        return;
    }
    symbol_table[var_c].name = strdup(name);
    symbol_table[var_c].type = type;
    switch (type) {
        case 0: symbol_table[var_c].value.ival = 0; break;
        case 1: symbol_table[var_c].value.fval = 0.0; break;
        case 2: symbol_table[var_c].value.sval = NULL; break;
    }
    var_c++;
}

Var* find_variable(char *name) {
    for (int i = 0; i < var_c; i++) {
        if (strcmp(symbol_table[i].name, name) == 0) {
            return &symbol_table[i];
        }
    }
    return NULL;
}

void yyerror(const char *s) {
    fprintf(stderr, "Erreur : %s\n", s);
}

int main(void) {
    printf("Donner votre mini programme (votre declarations et affectations) : \n");
    yyparse();
    for (int i = 0; i < var_c; i++) {
        free(symbol_table[i].name);
        if (symbol_table[i].type == 2 && symbol_table[i].value.sval) {
            free(symbol_table[i].value.sval);
        }
    }
    return 0;
}