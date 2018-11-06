/* Calculadora de notaci�n infija (usual) */

%{
#include <math.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
%}

%union
{
 float real;
}

%token <real> NUM
%token '\n' '+' '-' '*' '/' '^' '(' ')'
%left '+' '-'
%left '*' '/'
%right '^'
%right '(' ')'
%type <real> exp
%type <real> term
%type <real> pot
%type <real> fact


%% /* A continuaci�n las reglas gramaticales y las acciones */

input:    /* vac�o */
        | input line
;

line:     '\n'
        | exp '\n'  { printf ("\t %f\n", $1); }
;

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
  yyparse ();
}
