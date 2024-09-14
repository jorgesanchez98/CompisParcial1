%{
#include "y.tab.h"
#include "calc3.h"
%}

%%

"add"            { return ADD; }
"list"           { return LIST; }
"delete"         { return DELETE; }
[0-9]+           { yylval.num = atoi(yytext); return NUMBER; } 
\"[^\"]+\"       { yylval.str = strdup(yytext); return STRING; }  
[ \t\n]+         { /* Ignore whitespace */ }

%%

int yywrap(void) {
    return 1;
}
