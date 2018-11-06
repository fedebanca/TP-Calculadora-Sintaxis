
%{
#include "Calculadora.tab.h"
#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>
#include <math.h>

int OctalADecimal(char numero[30]);
%}


%%

0[0-7]+             {yylval.real = OctalADecimal(yytext); return NUM;}
[0-9]+("."[0-9]+)?  {yylval.real = atof(yytext); return NUM;}
0[xX][0-9a-fA-F]+   {yylval.real = deHexaADecimal(yytext); return NUM;}
"+"     {return '+';}
"-"     {return '-';}
"*"     {return '*';}
"/"     {return '/';}
"^"     {return '^';}
"("     {return '(';}
")"     {return ')';}
"\n"    {return '\n';}

%%
int OctalADecimal(char numero[30]){
	int numeroOctal, numeroDecimal = 0, i , rem;
	numeroOctal= atoi(numero); 
    for (i = 0; numeroOctal != 0; i++)
    {
        rem = numeroOctal % 10;
        numeroOctal /= 10;
        numeroDecimal += rem * pow(8, i);
    }
    return numeroDecimal;
}

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