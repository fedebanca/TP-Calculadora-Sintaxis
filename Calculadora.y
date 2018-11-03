/* Calculadora de notacion normal */

%{
#include <math.h>
#include <stdio.h>
#include <ctype.h>
extern int yylex();
extern int yyparse();
extern FILE* yyin;
%}

%union{
  float flotante;
  int intValue;
}
%token <flotante> NUM
%token '\n' '+' '-' '*' '/' '^' '(' ')'
%left '+' '-'
%left '*' '/'
%right '^'
%right '(' ')'
%type <flotante> exp
%type <flotante> term
%type <flotante> pot
%type <flotante> fact

%% /* A continuacion las reglas gramaticales y las acciones */

input:    /* vacio */
        | input line
;

line:     '\n'
        | exp '\n'  { printf ("\t %d\n", $1); }
;

// si los terminos signados no funcionan, agregarles un cero a la izquierda del signo
exp:      term            { $$ = $1;         }
        | '+' term        { $$ = + $2        }
        | '-' term        { $$ = - $2        }
        | exp '+' term    { $$ = $1 + $3;    }
        | exp '-' term    { $$ = $1 - $3;    }
;

term:     pot             { $$ = $1;         }
        | term '*' fact   { $$ = $1 * $3     }
        | term '/' fact   { $$ = $1 / $3     }
;

pot:      fact            { $$ = $1          }
        | pot '^' fact    { $$ = pow ($1,$3) }

;

fact:     NUM             { $$ = $1          }
        | '(' exp ')'     { $$ = $2        }
;


%%

yyerror (s)  /* Llamada por yyparse ante un error */
     char *s;
{
  printf ("%s\n", s);
}

main ()
{
   if (!(yyin = fopen("calcular.txt", "r"))
   printf("\nNo se puede abrir el archivo");
   else 
   yyparse();

   fclose(yyin);
   return 0;
  yyparse ();
}
