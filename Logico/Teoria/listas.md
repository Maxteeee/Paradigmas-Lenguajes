Las listas en prolog se escriben entre corchetes []

[1, 2, 3, 4]

Una lista se puede representar recursivamente como

[Head | Tail]

Predicados / Funciones utiles con listas

member(X, Lista) → verdadero si X está en la lista
length(Lista, N) → verdadero si Lista tiene longitud N
append(L1, L2, L3) → L3 es la concatenación de L1 y L2
select(X, Lista, Resto) → elimina una aparición de X

Recursividad sobre listas

Prolog trabaja con listas de forma recursiva, igual que en funciones en Haskell o matemáticas.

Ejemplo contar elementos de una lista:


contar([], 0). % Caso base
contar( [ _ | T ], N) :-
    contar(T, N1),
    N is N1 + 1.

Consultamos
?- contar([a,b,c], N).

Paso a paso
Primera llamada:
 contar([a,b,c], N)
 → [a|[b,c]], así que llama recursivamente a contar([b,c], N1)


Segunda llamada:
 contar([b,c], N1)
 → [b|[c]], llama a contar([c], N2)


Tercera llamada:
 contar([c], N2)
 → [c|[]], llama a contar([], N3)


Cuarta llamada:
 contar([], N3)
 → Usa el caso base: N3 = 0

Ahora vuelve hacia atras (resolviendo la aritmetica de N is N1 + 1)

N2 is N3 + 1 = 0 + 1 → N2 = 1
N1 is N2 + 1 = 1 + 1 → N1 = 2
N is N1 + 1 = 2 + 1 → N = 3


Ejemplo sumar elementos

suma([], 0). % Caso base
suma([H|T], Suma) :-
    suma(T, S1),
    Suma is H + S1.

Agregacion

La agregación significa combinar los elementos de una lista en un único valor:

sum_list/2: suma
max_list/2: máximo
min_list/2: mínimo

Explosion combinatoria

Este es un problema típico en Prolog: cuando hay muchas combinaciones posibles y Prolog trata de probar todas.

Pasa cuando hacer backtracking sobre muchas opciones sin freno o cuando haces una consulta demasiado general

Ejemplo EXTREMO

member(X, [a,b,c,d,e,f,g,h,i,j]),
member(Y, [a,b,c,d,e,f,g,h,i,j]),
X \= Y.

Esto genera muchas combinacion posibles de valores para X e Y. Si no se limita o no cortas el recorrido prolog explota

¿Como se evita?

Usando cortes ! si solo se quiere saber 1 respuesta
Asegurandose que la recursion termine
No dejar consultas muy abietas


