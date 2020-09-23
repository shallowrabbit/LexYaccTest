#pragma once

#include <iostream>
#include <string>
#include <stdio.h>

using namespace std;

struct Type
{
    string m_sId;
    int m_nInt;
    char m_cOp;
};

#define YYSTYPE Type
