%{
#include "main.h"
#include "yacc.tab.h"

extern "C"
{
    int yywrap(void);  
    int yylex(void);
}  
%}  

%x COMMENT  

nondigit    ([_A-Za-z])
digit       ([0-9])
integer     ({digit}+)
identifier  ({nondigit}({nondigit}|{digit})*)
whitespace  ([ \f\r\t\v]+)
newline     (\n)
comment     (\/\/)

%% 

{identifier}    {
                    yylval.m_sId = yytext;
                    return IDENTIFIER;
                }

{integer}       {
                    yylval.m_nInt = atoi(yytext);
                    return INTEGER;
                }

{whitespace}    {}  

{newline}       {}  
{comment}       {
                    cout << "(comment)" << endl;
                    BEGIN COMMENT;
                }  

.               {
                    yylval.m_cOp = yytext[0];
                    return OPERATOR;
                }  

<COMMENT>\n     {
                    BEGIN INITIAL;
                }  

<COMMENT>.      {}  

%%  

int yywrap(void)  
{  
    puts("-----the file is end");  
    return 1;
}
