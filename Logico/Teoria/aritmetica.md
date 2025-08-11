Prolog no resuelve ecuaciones algebraicas simbólicas como en álgebra.
En cambio, evalúa expresiones aritméticas explícitas con el predicado is/2.

A la derecha tiene que haber una expresión numérica concreta que pueda ser evaluada.

?- X is 2 + 3.
X = 5.

Error comun

?- 5 is X + 2.

X no esta instanciada → Prolog no resuelve ecuaciones al reves solo evalua expresiones ya instanciadas

Comparadores aritmeticos

=:= → Igualdad 
=\= → Distinto 
>= → Mayor igual
<= → Menor igual

