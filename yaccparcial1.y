%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

void yyerror(char *s);

#define MAX_ITEMS 100

typedef struct {
    int id;
    int check;
    char desc[100];
} Task;

extern FILE *yyin;

Task array[MAX_ITEMS];
int item_count = 0;

int yylex();  

void add(int check, char* desc) {
    if (item_count < MAX_ITEMS) {
        array[item_count].id = item_count;
        array[item_count].check = check;
        strncpy(array[item_count].desc, desc, 100);
        item_count++;
    }
}

void delete(int index) {
    for (int i = index; i < item_count - 1; i++) {
        array[i] = array[i + 1];  
        array[i].id = i;
    }
    item_count--;
}

void check(int index) {
    array[index].check = 1;
}

void list_items() {
    for (int i = 0; i < item_count; i++) {
        printf("ID: %d, Check: %d, Desc: %s\n", array[i].id, array[i].check, array[i].desc);
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
%token CHECK
%token <str> STRING
%token <num> NUMBER

%%

commands:
    commands command
    |
    ;

command:
    ADD NUMBER STRING { add($2, $3); }
    |
    LIST { list_items(); }
    |
    DELETE NUMBER { delete($2); }
    |
    CHECK NUMBER {check($2); }
    ;

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Unable to open file");
            return 1;
        }
        yyin = file; 
    }
    
    yyparse();
    
    if (argc > 1) {
        fclose(yyin); 
    }
    return 0;
}

void yyerror(char *s) { 
   printf("\n%s\n", s); 
}
