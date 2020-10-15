%{
#include "main.h"

extern "C"
{
    void yyerror(const char *s);
    extern int yylex(void);
}

%}

%union {
int num;
char* str;
}

%token<num> INTEGER
%token<str> IDENTIFIER

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

void yyerror(const char *msg)
{
    cerr << msg << endl;
}

int main(int argc, char *argv[])
{
    if (argc < 2) {
        printf("No input file!\n");
    }
    for (auto i = 1; i < argc; i++) {
        FILE* fp = fopen(argv[i], "r");
        if (fp == nullptr) {
            printf("cannot open %s\n", sFile);
            return -1;
        }
        extern FILE* yyin;
        yyin = fp;

        printf("-----begin parsing %s\n", argv[i]);
        yyparse();
        printf("-----end parsing\n");

        fclose(fp);
    }
    return 0;
}
