/* Calculadora de notacion normal */

%{
#include <math.h>
#include <stdio.h>
#include <ctype.h>
%}

%token NUM

%% /* A continuacion las reglas gramaticales y las acciones */

input:    /* vacio */
        | input line
;

line:     '\n'
        | exp '\n'  { printf ("\t %d\n", $1); }
;

exp:      term            { $$ = $1;         }
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
        | '(' exp ')'     { $$ = ( $2 )      }
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