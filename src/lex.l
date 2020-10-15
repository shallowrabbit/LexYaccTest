%{
// c code inside %{ %} will be copied
#include "main.h"
#include "yacc.tab.h"

extern "C"
{
    // yywrap will be called afer yylex()
    int yywrap(void);  
    // yylex is lexical analysis entrance
    int yylex(void);
}  
%}  

%x COMMENT LINECOMMENT

nondigit    ([_A-Za-z])
digit       ([0-9])
integer     ({digit}+)
identifier  ({nondigit}({nondigit}|{digit})*)
whitespace  ([ \f\r\t\v]+)
newline     (\n)

%% 

"//"            { BEGIN LINE_COMMENT; }  

<LINE_COMMENT>{
\n              { BEGIN INITIAL; }
.               {}
}


"/*"            { BEGIN COMMENT; }  

<COMMENT>{
"*/"            { BEGIN INITIAL; }  
.               {}
"\n"            { yylineno++; }
}

{identifier}    {
                    yylval.str = strdup(yytext);
                    return IDENTIFIER;
                }

{integer}       {
                    yylval.num = atoi(yytext);
                    return INTEGER;
                }

{whitespace}    {}  

%%  

int yywrap(void)  
{  
    puts("-----the file is end");  
    return 1;
}
