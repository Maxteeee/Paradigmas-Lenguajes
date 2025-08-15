Como vimos antes prolog es una base de conocimiento y se escriben hechos reglas y consultas

# Hechos
Un hecho es una afirmación simple. Se representa como un predicado con uno o más argumentos y siempre terminan con un punto

```prolog
predicado(argumento1, argumento2, ..., argumentoN).
```

**Ejemplos:**

```prolog
ama(romeo, julieta).
viveEn(homero, springfield).
esPerro(firulais).
```

El orden SI IMPORTA, si ponemos:

```prolog
padre(juan, maria).
```

El primero sera el padre y el segundo el hijo porque asi lo edcidimos al nombrar el predicado.

## TIPOS DE TERMINOS

- Atomo: Comienzan en minuscula → juan pizza firulais
- Numero: Numeros enteros o decimales → 5 3.14
- Variable: Comienzan con mayuscula o _ → X Nombre 
- Estructura: un functor con argumentos → padre(juan, maria)

# Reglas
Una regla dice cuando algo es verdadero en base a otros hechos o reglas

```prolog
conclusion :- condicion1, condicion2, ..., condicionN.
```

Se lee como: “La conclusion es verdadera si el las condiciones son verdaderas”

**Ejemplo:**

```prolog
hijo(X, Y) :- padre(Y, X).
```

Se lee como: “X es hijo de Y si Y es padre de X

> :-  se llama “implicacion inversa” y se lee como si

Basicamente cuando usamos el :- es un “la izquierda es Verdadero si la derecha es Verdadero”

**Otro ejemplo**

Queremos decir que dos personas son hermanos si tienen al mismo padre o madre.

```prolog
hermano(X, Y) :-
    progenitor(P, X),
    progenitor(P, Y),
    X \= Y.
```

Se lee "X es hermano de Y si hay un progenitor P que es padre o madre de ambos, y no son la misma persona".

## Cosas de la catedra.

Nosotros si queremos definir que alguien es progenitor de otro si es su padre o su madre, se haria como

```prolog
progenitor(X, Y) :- padre(X, Y) ; madre(X, Y).
```

Se lee "X es progenitor de Y si X es padre de Y o X es madre de Y". Como vemos usamos el ; como "y" pero no deberiamos hacer esto porque segun la docente es confunso. Entonces lo correcto seria

```prolog
progenitor(X, Y) :- padre(X, Y).
progenitor(X, Y) :- madre(X, Y).
```

## Propiedades d prolog

simetrica: xRy entonces yRx

irreflexive: x no se relaciona consigo mismo

## conjuncion
Es con el ","

colegas (Persona, Colega):=
 ProgramaEn(Persona, Lenguaje),
 ProgramaEn(Colega, Lenguaje),
 Persona \= Colega.

## Disyuncion
ProgramaEn(mateo, java).
ProgramaEn(maru, ruby).
ProgramaEn(mateo, go).

