%{
#include "Calculadora.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>
//#define YY_DECL int yylex()

int deHexaAOctal(char numeroHexa[30]);
int deHexaADecimal(char numeroHexa[30]);
int deOctalADecimal(char numeroOctal[30]);
%}

	//Reglas y acciones
%%
0[0-7]+                         {yylval.intValue = deHexaAOctal(yytext); return NUM;}
[\+\-]?[0-9]+(\.[0-9]+)?        {yylval.intValue = atof(yytext); return NUM;}
0[xX][0-9a-fA-F]+               {yylval.intValue = deHexaADecimal(yytext); return NUM;}
"+"                             {return '+';}
"-"                             {return '-';}
"*"                             {return '*';}
"/"                             {return '/';}
"^"                             {return '^';}
"\n"                            {return '\n';}
%%

int deHexaAOctal(char numeroHexa[30]){
    int i;
    int tamanio;
    int numeroDecimal = 0;
    int numeroOctal = 0;

    for(tamanio=0; numeroHexa[tamanio]!='\0'; tamanio++);

    for(i=0; numeroHexa[i] != '\0'; i++,tamanio--) {
        if(numeroHexa[i]>='0' && numeroHexa[i]<='9')
		{
			numeroDecimal = numeroDecimal + (numeroHexa[i]-'0')*pow(16, tamanio-1);
		}
		if(numeroHexa[i]>='A' && numeroHexa[i]<='F')
		{
			numeroDecimal = numeroDecimal + (numeroHexa[i]-55)*pow(16, tamanio-1);
		}
		if(numeroHexa[i]>='a' && numeroHexa[i]<='f')
		{
			numeroDecimal = numeroDecimal + (numeroHexa[i]-87)*pow(16,tamanio-1);
		}
	}
    
    i=1;

    while(numeroDecimal!=0)
	{
		numeroOctal = numeroOctal + (numeroDecimal%8)*i;
		numeroDecimal = numeroDecimal/8;
		i = i*10;
	}
	return numeroOctal;
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

int deOctalADecimal(char numeroOctal[30]){

    int i;
    int numeroDecimal = 0;
    for (i = 1; numeroOctal[i] != '\0'; i++){
        numeroDecimal *= 8;
        numeroDecimal += numeroOctal[i] - '0';
    }

    return numeroDecimal;
}
