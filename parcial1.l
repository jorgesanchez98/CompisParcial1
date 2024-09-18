%{
#include "y.tab.h"
%}

%%

"add"            { return ADD; }
"list"           { return LIST; }
"delete"         { return DELETE; }
"check"          { return CHECK; }
[ \t\n]+         { /* Ignore whitespace */ }
\"[^\"]+\"       { yylval.str = strdup(yytext); return STRING; }  
[0-9]+           { yylval.num = atoi(yytext); return NUMBER; } 

%%

int yywrap(void) {
    return 1;
}
