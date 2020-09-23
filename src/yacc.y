%{
#include "main.h"

extern "C"
{
    void yyerror(const char *s);
    extern int yylex(void);
}

%}

%token<m_nInt>INTEGER
%token<m_sId>IDENTIFIER
%token<m_cOp>OPERATOR
%type<m_sId>file
%type<m_sId>tokenlist

%%

file:
    tokenlist
    {
        cout << "all id:" << $1 << endl;
    };
    tokenlist:
    {
    }
    | tokenlist INTEGER
    {
        cout << "int: " << $2 << endl;
    }
    | tokenlist IDENTIFIER
    {
        $$ += " " + $2;
        cout << "id: " << $2 << endl;
    }
    | tokenlist OPERATOR
    {
        cout << "op: " << $2 << endl;
    };

%%  

void yyerror(const char *s)
{
    cerr << s << endl;
}

int main()
{
    const char* sFile = "examples/file.txt";
    FILE* fp = fopen(sFile, "r");
    if (fp == nullptr) {
        printf("cannot open %s\n", sFile);
        return -1;
    }
    extern FILE* yyin;
    yyin = fp;

    printf("-----begin parsing %s\n", sFile);
    yyparse();
    printf("-----end parsing\n");

    fclose(fp);

    return 0;
}
