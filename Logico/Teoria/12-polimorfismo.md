# Polimorfismo en general

En programación, polimorfismo significa “muchas formas”.

Un mismo método, función o concepto puede trabajar con distintos tipos de datos o estructuras sin cambiar su comportamiento básico.


Ejemplo de objetos: Un método dibujar() funciona para un Circulo, un Cuadrado o un Triangulo. Cada objeto tiene su forma propia, pero todos responden a dibujar().

# Polimorfismo en Prolog

En Prolog no hay objetos, pero sí tenemos predicados que pueden recibir distintos tipos de argumentos y funcionar de manera uniforme.

Ejemplo con objetivos

```prolog
cumpleExpansionista(Jugador, ObjetivoExp) :- ...
cumpleColeccionista(Jugador, ObjetivoCol) :- ...
cumpleDinero(Jugador, ObjetivoDin) :- ...
```

El predicado gana/1 puede trabajar con todos estos objetivos distintos sin modificar su lógica:

```prolog
gana(Jugador) :-
    forall(tieneObjetivoExpansionista(Jugador, ObjExp), cumpleExpansionista(Jugador, ObjExp)),
    forall(tieneObjetivoColeccionista(Jugador, ObjCol), cumpleColeccionista(Jugador, ObjCol)),
    forall(tieneObjetivoDinero(Jugador, ObjDin), cumpleDinero(Jugador, ObjDin)).
```

## Polimorfismo = “una misma regla puede trabajar con muchas formas diferentes de datos”.