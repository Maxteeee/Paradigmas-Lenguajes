```prolog
%progreso(jugador, casilla, dinero)
progreso(ana, 0, 0).
progreso(beto, 24, 10).
progreso(cari, 31, 3100).
progreso(dani, 38, 50).

ganasDeJugar(ana, 0.6).
ganasDeJugar(beto, 0.8).
ganasDeJugar(Persona, 0.4) :-
    jugador(Persona, Posicion, _),
    Posicion > 25.
```

# PARTE A
1) Se pide escribir las consultars que se harian en la consola de prolog para que respondan las siguientes preguntas, indicando las respuestas de cada una
- En que casilla esta dani?
- Hay alguine en la casillas 31?
- Las ganas de jugar de Ana es 0.7?
- Quienes tienen 0.4 ganas de jugar?
- Cuales son las ganas de jugar de pepita?

2) Responder, Que diferencias hay entre una funcion y un predicado, mencionar al menos 2

## Respuestas 1

```prolog
?- progreso(dani, Casilla, _).
Casilla = 38.

?- progreso(Persona, 31, _).
Persona = cari.

?- ganasDeJugar(ana, 0.7).
true.

?- ganasDeJugar(Persona, 0.4)
Persona = cari ; 
Persona = dani.

?- ganasDeJugar(pepita, Ganas).
false
```

## Respuestas 2
Las diferencias son varias, las funciones reciben parametros y devuelven un valor concreto. Siempre hay un unico resultado por cada conjunto de entradas (en la mayoria de lenguajes)

Em cambio los predicados no devuelven un valor como tal, sino que "responden" True or falso si la relacion se cumple.

Ademas de poder generar multiples soluciones mediante el backtracking dependiendo de los datos y de como este planteado el predicado.

# Parte B

## 1) Queremos saber

- Si dos jugadores estan EMPATADOS, osea si tienen la misma cantiad de dinero. Un jugador no puede estar empatadocon el mismo

- Si un jugador TIENE VENTAJA sobre otro, osea que tiene mayor o igual cantidad de dinero

- Quien va MEJOR, que es un jugdaor que tiene ventaja sobre todos los jugadores. Puede haber mas de un jugador que vaya mejor

- Todos los jugadores que ESTAN MOTIVADOS. Un jugador esta motivado cuando va mejor o si todos los jugadores sobre los que tiene ventaja tienen pocas ganas de jugar (menos de 0.5)

Ya tenemos las solcuones a estos problemas, y funciona, pero se pide encontrar por lo menos 3 mejores relacionadas a buenas practicas. Justiifcar brevemente cada cambio.

```prolog
estanEmpatados(Jugador1, Jugador2) :-
    progreso(Jugador1, _, Dinero1),
    progreso(Jugador2, _, Dinero2),
    Dinero1 is Dinero2
    Jugador1 \= Jugador2

tieneVentaja(Ventajoso, Jugador) :-
    progreso(Ventajoso, _, DineroSuperior),
    progreso(Jugador, _, DineroInferior),
    DineroSuperior >= DineroInferior

vaMejor(Jugador) :-
    progreso(Jugador, _, _),
    findall(OtroJugador, progreso(OtroJugador, _, _), Jugadores),
    forall(
        member(JugadorNoVentajoso, Jugadores),
        tieneVentaja(Jugador, JugadorNoVentajoso)
    ).

estaMotivado(Jugador) :-
    progreso(Jugador, _, _),
    vaMejor(Jugador).

estaMotivado(Jugadir) :-
    progreso(Jugador, _, _),
    forall(
        tieneVentaja(Jugador, JugadorNoVentajoso),
        (ganasDeJugar(JugadorNoVentajoso, Ganas), Ganas < 0.5)
    ).
```

### Correciones 1

- MEJORA 1 y 2: Dinero1 is Dinero2 esta mal. is para evaluar expresiones. Ademas la verificacion de que son personas diferentes deberia ir apenas instanciamos las variables asi nos evitamos sino hacer operaciones mas complejas luego

```prolog
estanEmpatados(Jugador1, Jugador2) :-
    progreso(Jugador1, _, Dinero1),
    progreso(Jugador2, _, Dinero2),
    Jugador1 \= Jugador2 %% Movido
    Dinero1 =:= Dinero2 %% Modificado
```

- MEJORA 3: En tiene ventaja, decir que no sean la misma persona para que no se compare consigo mismo y pueda generar respuestas repetidas o no esperadas

```prolog
tieneVentaja(Ventajoso, Jugador) :-
    progreso(Ventajoso, _, DineroSuperior),
    progreso(Jugador, _, DineroInferior),
    Ventajoso \= Jugador %% Agregado
    DineroSuperior >= DineroInferior
```

- MEJORA 4: Eliminamos el findall, no es necesario crear una LISTA de todas las personas ya el forall se encarga de recorrer a cada una de las personas.

```prolog
vaMejor(Jugador) :-
    progreso(Jugador, _, _),
    forall(
        progreso(OtroJugador, _, _),
        tieneVentaja(Jugador, OtroJugador)
    ).
```

- El ultimo esta bien.

## Punto 2

Desarrollas los predicados que resuelvan estos problemas, deben ser inversibles y justificar porque lo son

a. jugadores provinciales, relaciona un jugador con una provincia de manera tal que todas sus propiedades estan en dicha provincia

b. provincia completa, relaciona una provincia con un jugador cuando dicho jugador posee a todas las propiedades de la provincia

### Correciones 2

```prolog
% propiedades(Casa, Provincia)
% tienePropiedad(Jugador, Casa)


jugadorProvincial(Jugador, Provincia) :-
    tienePropiedad(Jugador, _),          
    propiedades(_, Provincia),           
    forall(
        tienePropiedad(Jugador, Casa),
        propiedades(Casa, Provincia)
    ).
```

Es inversible ya que antes de entrar al forall instanciamos las variables libres, esto hace que en caso de cumplir una condicion en el forall prolog sepa a que valor corresponda. Sabe que valores esta evaluando
Entonces si nos llegaran las 2 varaibles libres prolog mientras hace el backtracking sabria con que variables esta provando

```prolog
provinciaCompleta(Jugador, Provincia) :-
    propiedades(_, Provinicia),
    tienePropiedad(Jugador, _),
    forall (
        propiedades(Casa, Provincia),
        tienePropiedad(Jugador, Casa)
    ).
```

Estas líneas permiten producir valores posibles para Jugador y Provincia si están libres.
Prolog hace backtracking sobre todos los jugadores y provincias que existan en la base de hechos.

Jugador libre, Provincia instanciada: Prolog probará todos los jugadores y devolverá los que poseen todas las propiedades de la provincia.

Provincia libre, Jugador instanciado: Prolog probará todas las provincias y devolverá las que cumplan la condición para ese jugador.

Ambos libres: Prolog generará combinaciones de jugadores y provincias y filtrará las que cumplen la condición del forall.

# Punto 3 

saber quien es el ganador del juego, que ez quien cumplio con todos sus objetivos. Para ello se tiene infromacion de ciertso objetivos que los jugadores tienen que cumplir que pueden ser
- Expansionista, se cumple cuando el jugador tiene cierta cantidad de propiedades
- Coleccioniasta, se cumple cuando un jugador logra tener todas las propiedades de una provincia

Ej: Ana  tiene el objetivo de expansionsita por 5 propiedades, Beto tiene dos objetivos, uno ser coleccionista de BS AS y de coleccionista de cordoba.
dani tiene tambien 2 objetios, uno ser colecionaste de bs as y ser expansionsita con 3 propiedades

Ya se cuenta con las soluciones

```prolog
gana(Jugador) :-
    progreso(Jugador, _, _),
    forall(
        tieneObjetivoExpansionista(Jugador, ObjetivoExpansionista),
        cumpleExpansionista(Jugador, ObjetivoExpansionista)
    ).

gana(Jugador) :-
    progreso(Jugador, _, _), 
    forall(
        tieneObjetivoColeccionista(Jugador, ObjetivoColeccionista),
        cumpleColeccionista(Jugador, ObjetivoColeccionista)
    ).
```

A) Pareciara andar a que ana y beto funcionan,pero dani empezo a fallar porque?

B) Hay otro requerimienoto, crear un nuevo objetivo que tenga en cuenta el dinero obtenido por el jugador y que incluya dos valores adicionales.
Se debe permitir que cualquier jugador combiene este nuevo tipo de objetivo con los anteriores.
Ej: Carl tiene el objetivo de ser coleccionista de bs as y uno inventnado de 3 y 97.
Implementar ua solucion que contemple los problemas anteriores y contemple el nuevo caso

C) Que concpeto permite entender el objetivo inventado sin tener una consigna que lo explique? jusitifcar

D) Que conceptos del paradigma logico permitieron que agregar un nuevo tipo de objetivo sea relativamente sensillo, justificar


### Respuestas 3

A) Una regla se fija SOLO en los obejtivos expancionistas y otra SOLO en los colecionistas, entonces como dani tiene 2 objetivos de 2 tipos diferentes ninguna regla le exige cumplir los dos a la vez
Osea con que dani cumpla un objetivo ya ganaria cuando no deberia pasar

B) cumpleObjetivoDinero(Jugador, Dinero) :-
    tieneObjetivoDinero(progreso(Jugador, _, Dinero),    )

Para arreglar lo del punto A basta con meter todo dentro del mismo GANA ya que si una condicion del forall es 0, osea no matchea con ninguna, es verdadero siempre. Antecedente faslo, condicional verdadero

```prolog
gana(Jugador) :-
    forall(
        tieneObjetivoExpansionista(Jugador, ObjExp),
        cumpleExpansionista(Jugador, ObjExp)
    ),
    forall(
        tieneObjetivoColeccionista(Jugador, ObjCol),
        cumpleColeccionista(Jugador, ObjCol)
    ),
    forall(
        tieneObjetivoDinero(Jugador, ObjDin),
        cumpleDinero(Jugador, ObjDin)
    ).
```

C) Concepto que permite entender el objetivo inventado sin consigna

Respuesta:
El concepto clave es abstracción mediante predicados parametrizados.

Justificación:

Cada objetivo, aunque sea inventado, se representa como un predicado que indica si se cumple o no (por ejemplo: cumpleDinero/2).

No hace falta que haya una consigna explícita; basta con que exista un predicado que pueda evaluar el objetivo.

La abstracción separa los datos del objetivo (por ejemplo, dinero mínimo y valores extra) de la lógica de verificación.

En otras palabras: podemos “entender” el objetivo inventado porque Prolog solo necesita verificar si se cumple, sin importar su forma interna.

Ejemplo conceptual:

tieneObjetivoDinero(carl, dinero(1000, 3, 97)).
cumpleDinero(carl, dinero(1000, 3, 97)).  % devuelve true si cumple


El sistema entiende que este es un objetivo válido aunque no haya una consigna textual que lo explique.

D) Conceptos del paradigma lógico que facilitan agregar un nuevo objetivo

Respuesta:
Los conceptos son predicados parametrizados, inversibilidad y polimorfismo lógico.

Justificación:

Predicados parametrizados:

Cada objetivo se define como un predicado independiente (cumpleExpansionista/2, cumpleColeccionista/2, cumpleDinero/2).

Permite agregar objetivos nuevos sin modificar la lógica general de gana/1.

Polimorfismo lógico:

gana/1 puede tratar distintos tipos de objetivos de forma uniforme usando forall.

No importa si el objetivo es de dinero, expansión o colección; todos se verifican de la misma manera.

Inversibilidad:

Prolog puede generar jugadores o objetivos libres y comprobar combinaciones durante el backtracking.

Esto hace que agregar un tipo de objetivo no rompa la capacidad de Prolog de encontrar todos los ganadores posibles.
