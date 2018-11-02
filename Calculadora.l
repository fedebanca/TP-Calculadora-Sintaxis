%{
#include "Calculadora.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
//#define YY_DECL int yylex()
%}

//Reglas y acciones
%%
    [\+\-]?[0-9]+(\.[0-9]+)?        {yylval = atof(yytext); return NUM;}
    0[0-7]+                         {yylval = deHexaAOctal(yytext); return NUM;}
    0[xX][0-9a-fA-F]+               {yylval = deHexaADecimal(yytext); return NUM;}
    "+"                             {return '+';}
    "-"                             {return '-';}
    "*"                             {return '*';}
    "/"                             {return '/';}
    "^"                             {return '^';}
    "\n"                            {return '\n';}
%%


int deHexaADecimal(char numeroHexa[30]){
   int i;
   int numeroDecimal = 0;
   for (i = 2; numeroHexa[i] != '\0'; i++){
      numeroDecimal *= 16;

      if (isdigit(numeroHexa[i]))
         numeroDecimal += numeroHexa[i] - '0';
      else {
         numeroHexa[i] = tolower(numeroHexa[i]);

         if (numeroHexa[i] >= 'a' && numeroHexa[i] <= 'f')
            numeroDecimal += 10 + numeroHexa[i] - 'a';
      }
   }
   return numeroDecimal;
}

int deOctalADecimal(char numeroOctal[30]){

    int i;
    int numeroDecimal = 0;
    for (i = 1; numeroOctal[i] != '\0'; i++){
        numeroDecimal *= 8;
        numeroDecimal += numeroOctal[i] - '0';
    }

    return numeroDecimal;
}