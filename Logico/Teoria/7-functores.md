# Functores

**functor(argumento1, argumento2, etc....)**

Vamos a explicar functores con un ejemplo, las CARTAS DEL TRUCO.

Tenemos el predicado mata/2 que recibe 2 cartas y dice si la primera mata a la segunda

En vez de declarar cada carta a mano

```prolog
carta(asDeBasto).
carta(sieteDeEspada).
carta(tresDeOro).
% etc
```

podemos armar un functor "carta(numero, palo)."

```prolog
carta(3, oro).
carta(7, espada).
% etc
```

Carta es el FUNCTOR, 3 y oro serian los argumentos

Este carta/2 no es un predicado, es tomado como un individuo, pero en vez de ser tomado como uno individual "carta(tresDeOro)." es uno compuesto.

## Inversibiliadad + Transitividad

Si tendriamos en la base de conocimiento

```prolog
mata(carta(3, _), carta(2, _)).

% Consultamos
?- mata( carta(3, oro), CartaMenor).
CartaMenor = carta(2, _algo).
```

Los hechos con variables son problematicos. Tranquilamente si ponia "carta(2, pescado)." seria true porque el _ de mi base de conocimientos matchea con cualquier cosa.

### ¿Como arreglarlo?

1. Definir algo que me de cartas validas para que no pasen cosas como pescado.

```prolog
cartaDeTruco(carta(Numero, Palo)) :=
    palo(Palo),
    numero(Numero).

palo(basto).
palo(copa).
%etc

numero(Numero) :=
    betwenn(1, 12, Numero),
    not (netwemm(8, 9, Numero)).
```

Palo y Numero son inversibles, entonces cartaDeTruco tambien lo sera.

2. Renombramos al mata como valeMas (no inversible), y declaramos el mata nuevo

```prolog
valeMas(carta(3, _), carta(2, _)).

mata(MasValiosa, MenosValiosa):=
    cartaDeTruco(MasValiosa),
    cartaDeTruco(MenosValiosa),
    valeMas(MasValiosa, MenosValiosa)
```

Con esto arreglamos la inversibilidad, pero y la transitividad?

3. Para que sea transivita, podemos agregar una regla al predicado mata hablando de una carta del medio

```prolog
mata(MasValiosa, MenosValiosa):=
    cartaDeTruco(MasValiosa),
    cartaDeTruco(OtraCarta),
    valeMas(MasValiosa, OtraCarta)
    mata(OtraCarta, MenosValiosa)
```

Como es recursiva, se llama tantas veces para llegar de una punta a la otra. Cuando llegue a la carta mas baja ahi se frena.

