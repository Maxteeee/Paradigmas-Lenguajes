# Listas

Las lista en prolog no son muy diferentes a como las vimos en Haskell

```prolog
[elemento, elemento, elemento]
```

Lo que si varia son los predicados(funciones) que usamos sobre ellas, estos estan explicados en predicados.md pero aca veremos un repaso por encima

```prolog
?- nth1(2, [pera, banana, manzana], Alimento).
Alimento = banana

?- nth1(N, [pera, banana, manzana, banana], banana).
N = 2
N = 4
```

Se puede usar de ambas formas. 

NOTA: Si la posicion no importara, es mas adecuado usar member/2

## Recursividad con listas (lenght)

```prolog
length([], 0).
length([_|Cola], N):-
    length(Cola, LongitudCola),
    N is 1 + LongitudCola.
```

**Explicacion**
1. Caso base
2. Separamos la cabeza de la cola y la longitud es N
3. Hacemos el lenghtde la cola, asignado a la variable LongitudCola
4. N (longitud del paso 2) va a ser 1 + LongitudCola

## Recursividad con listas (member)

```prolog
member(X, [X|_]).
member(X, [_|Cola]):-
    member(X, Cola).
```

**Explicacion**
1. Si el elemento buscado, coincide con el primer elemento de mi lista, ya esta.
2. Sino, X esta en la cola 
3. Entonces tiene member(x;cola) y vuelve a arrancar de arriba, si es el primer elemento chau sino de esa cola saca el primero y deja la nuevacola. Va a parar hasta que encuentre el caso base

## Otro ejemplo de recursividad
Contar los elementos de una lista

```prolog
contar([], 0). % Caso base
contar( [ _ | T ], N) :-
    contar(T, N1),
    N is 1 + N1
```

Consultamos
```prolog
?- contar([a,b,c], N).
```

#### Paso a paso
**Primera llamada:**
 contar([a,b,c], N)
 → [a|[b,c]], así que llama recursivamente a contar([b,c], N1)


**Segunda llamada:**
 contar([b,c], N1)
 → [b|[c]], llama a contar([c], N2)


**Tercera llamada:**
 contar([c], N2)
 → [c|[]], llama a contar([], N3)


**Cuarta llamada:**
 contar([], N3)
 → Usa el caso base: N3 = 0

Ahora vuelve hacia atras (resolviendo la aritmetica de N is N1 + 1)

N2 is N3 + 1 = 0 + 1 → N2 = 1
N1 is N2 + 1 = 1 + 1 → N1 = 2
N is N1 + 1 = 2 + 1 → N = 3


