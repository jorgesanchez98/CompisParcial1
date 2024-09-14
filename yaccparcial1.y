%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char *s);

#define MAX_ITEMS 100

char *array[MAX_ITEMS];
int item_count = 0;

int yylex();  


void add_to_array(char* str) {
    if (item_count < MAX_ITEMS) {
        array[item_count++] = strdup(str);
    }
}

void delete_from_array(int index) {
    free(array[index]); 
    for (int i = index; i < item_count - 1; i++) {
        array[i] = array[i + 1];  
    }
    item_count--;
}

void list_items() {
    for (int i = 0; i < item_count; i++) {
        printf("%d: %s\n", i, array[i]);
    }
}

%}

%union {
    int num;
    char* str;
}

%token ADD 
%token LIST 
%token DELETE
%token <str> STRING
%token <num> NUMBER

%%

commands:
    commands command
    |
    ;

command:
    ADD STRING  { add_to_array($2); }
    |
    LIST        { list_items(); }
    |
    DELETE NUMBER { delete_from_array($2); }
    ;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(char *s) { 
   printf("\n%s\n", s); 
}
