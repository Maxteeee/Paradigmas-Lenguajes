# Operadores logicos y matematicos

## is/2

Evalúa una expresión y unifica con el resultado.

NOTA: el lado DERECHO debe ser evaluable, osea una expresion numerica concreta

```prolog
?- X is 2+3.
X = 5.
```

**Error:**

```prolog
?- 5 is X + 2.
```

X no esta instanciada → Prolog no resuelve ecuaciones al reves solo evalua expresiones ya instanciadas

**Comparadores aritmeticos**
>= → Mayor igual
<= → Menor igual
=:= → Igualdad 
=\= → Distinto 

Estos 2 ultimos, los explicaremos abajo

## =/= y =:=

- =:= → igualdad numérica (evalúa ambos lados).
- =\= → desigualdad numérica.

```prolog
?- 5 =:= 2+3.
true.

?- 5 =\= 2+2.
true.
```

## Between/3 -> (Min,Max,Nro)

Genera o verifica un número entre dos valores.

```prolog
?- between(1, 3, X).
X = 1 ;
X = 2 ;
X = 3.
```

## not( Consulta )

Evalua la consulta
- Si falla = True
- Si tiene exito = False

```prolog
es_hombre(juan).
es_hombre(pedro).

?- not(es_hombre(maria)).
true.

?- not(es_hombre(juan)).
false.
```

## dividendo // divisor

Retorna la parte entera del cociente, descartando decimales.

No redondea, solo trunca hacia abajo.

```prolog
?- X is 7 // 3.
X = 2.

?- X is 10 // 5.
X = 2.
```

## dividendo mod divisor

Devuelve el resto de la divison entera

```prolog
?- R is 7 mod 3.
R = 1.

?- R is 10 mod 5.
R = 0.
```

## abs(Nro)

El valor absoluto

```prolog
?- X is abs(-5).
X = 5
```

## sqrt/2 -> (Nro)

Es la raiz cuadrada

```prolog
?- sqrt(9, R).
R = 3.0.
```

# Operaciones simples sin efecto sobre listas

## length/2

Obtiene o verifica la longitud de una lista.

```prolog
?- length([a,b,c], N).
N = 3.
```

## append/3

Concatena o divide listas.

```prolog
?- append([1,2], [3,4], R).
R = [1,2,3,4].

?- append(X, Y, [1,2,3]).
X = []  , Y = [1,2,3] ;
X = [1], Y = [2,3] ;
...
```

## union/3

Une dos conjuntos

```prolog
?- union([a,b], [b,c], R).
R = [a,b,c].
```

## intersection/3

Intersecta dos conjuntos

```prolog
?- intersection([a,b], [b,c], R).
R = [b].
```

## nth0/3 (base  0)

Indice desde 0 

```prolog
?- nth0(1, [a,b,c], E).
E = b.
```

Se busca el elemento 1 de la lista arrancando a contar desde 0

- a = 0
- b = 1
- c = 2

## nth1/3 (base  1)

Indice desde 1

```prolog
?- nth1(2, [a,b,c], E).
E = b.
```

Es decir aca se busca el elemento 2 de la lista arrancando a contar desde 1

- a = 1 (arranca en 1)
- b = 2
- c = 3

## member/2

Verifica o genera elementos de una lista.

```prolog
?- member(b, [a,b,c]).
true.

?- member(X, [a,b,c]).
X = a ;
X = b ;
X = c.
```

Si la lista que le pasamos es vacia, como no tiene elementos para comprar member tira falso siempre. Poruqe no hay elementos para unificar con X
## max_member/2

- max_member(+Lista, -Max).

Devuelve el maximo de una lista

```prolog
?- max_member([3,7,2,9], M).
M = 9.
```

## min_member/2

- min_member(+Lista, -Min).

Devuelve el minimo de una lista

```prolog
?- min_member([3,7,2,9], m).
M = 2.
```

## sumlist/2

Suma todos los elementos de una lista

```prolog
?- sum_list([1,2,3], S).
S = 6.
```

## flatten/2

Aplana listas anidadas.

```prolog
?- flatten([1,[2,3],[[4]]], R).
R = [1,2,3,4].
```

## list_to_set/2

Convierte lista a conjunto (elimina duplicados)

```prolog
?- list_to_set([a,b,a,c], R).
R = [a,b,c].
```

## reverse/2

Invierte una lista

```prolog
?- reverse([1,2,3], R).
R = [3,2,1].
```

# Predicados de orden superior

## forall(Antecedente, Consecuente)

Esta mejor explicado en su propio archivo.md pero aca lo resumiremos

Se lee como **"Para todo ANTECEDENTE, el CONSECUENTE es cierto"**

Internamente prolog intenta todas las soluciones posibles de ANTECEDENTE y en cada una verifica que el CONSECUENTE sea verdadero

Si alguna no cumple, falla. Porque es un PARA TODO

```prolog
es_hombre(juan).
es_hombre(pedro).

tiene_bigote(juan).
tiene_bigote(pedro).

?- forall(es_hombre(X), tiene_bigote(X)).
true. % todos los hombres tienen bigote

?- tiene_bigote(pedro), retract(tiene_bigote(pedro)),
   forall(es_hombre(X), tiene_bigote(X)).
false. % Pedro rompió la regla
```

A diferencia del member, si el forall en la condicion ponemos una lista vacia o un predicado donde NINGUNO cumple. Como no hay elementos que contradigan la condicion sera siempre verdadero.
Recordar la tabla de valores, si el antecedente era falso el condicional era verdadero.

## findall(QueQuieroJuntar, ConsultaParaConseguirlo, ListaResultado).

Ejecuta la CONSULTA y recolecta todas las solcuiones de la variable/estructura dada en FORMATO en una LISTA

Incluso si hay variables/estructuras repetidas en las soluciones, se repiten en la lista

### Hay soluciones

```prolog
es_hombre(juan).
es_hombre(pedro).
es_hombre(carlos).

?- findall(X, es_hombre(X), Lista).
Lista = [juan, pedro, carlos].
```

### Si no hay soluciones -> lista vacia

```prolog
?- findall(X, es_mujer(X), Lista).
Lista = [].
```