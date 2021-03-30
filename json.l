%{
#include "token.h"
%}

%x EXPECT_STRING 

DIGIT    [0-9]
META     [{}:\[\],]

QUOTE    ["]
NOTQUOTE [^"]
%%

{QUOTE}       { BEGIN(EXPECT_STRING); return META;}

<EXPECT_STRING>{NOTQUOTE}*    return STRING_LITERAL;
<EXPECT_STRING>{QUOTE}        {BEGIN(INITIAL); return META;}  

{DIGIT}+|{DIGIT}*\.{DIGIT}*      return NUMBER_LITERAL;
true|false    return BOOLEAN_LITERAL;
null          return NULL_LITERAL;

"\n"          return NEWLINE;
{META}        return META;

. return UNDEFINED;