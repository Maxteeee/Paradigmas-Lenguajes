Reglas y relaciones derivadas

Hasta ahora vimos en detalle los HECHOS, que son cosas que simplemente se saben pero Prolog no puede deducir cosas nuevas si no se las enseñamos

Para eso estan las reglas, que no spermiten definir relaciones nuevas derivadas de otras
Definición de una regla
Estructura general

conclusion :- condicion1, condicion2, ..., condicionN.

Se lee “La conclusion es verdadera si se cumplen todas las condiciones”

Ejemplo 1: Definir progenitor

Queremos definir que alguien es progenitor de otro si es su padre o su madre.

progenitor(X, Y) :- padre(X, Y).
progenitor(X, Y) :- madre(X, Y).

Como vimos en la seccion pasada, se puede unificar usando el ;

progenitor(X, Y) :- padre(X, Y) ; madre(X, Y).

Se lee "X es progenitor de Y si X es padre de Y o X es madre de Y".

Ejemplo 2: Relación de abuelo

Queremos definir que alguien es abuelo si es padre de alguien que a su vez es padre o madre.

abuelo(X, Y) :- padre(X, Z), progenitor(Z, Y).

Se lee "X es abuelo de Y si X es padre de Z y Z es progenitor de Y".



 Ejemplo 3: Hermano

Queremos decir que dos personas son hermanos si tienen al mismo padre o madre.

hermano(X, Y) :-
    progenitor(P, X),
    progenitor(P, Y),
    X \= Y.

Se lee "X es hermano de Y si hay un progenitor P que es padre o madre de ambos, y no son la misma persona".

NOTAS FINALES:

Si despues de un :- hay un ; (simboliza al operador O) si usamos una , (simbolizaria un Y)

El \= es para indicar que dos variables son distintas 
