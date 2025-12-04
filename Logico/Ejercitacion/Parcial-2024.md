https://docs.google.com/document/d/1xFUxx_4XGdg9TXltWtxY-3zL2E6xEKuEccQDLtEui3c/edit?tab=t.0

Tambien esta subido a mi drive personal la consigna.

# Base de conocimientos

```prolog
% Recorridos en GBA:
recorrido(17, gba(sur), mitre).
recorrido(24, gba(sur), belgrano).
recorrido(247, gba(sur), onsari).
recorrido(60, gba(norte), maipu).
recorrido (152, gba(norte), olivos).

% Recorridos en CABA:
recorrido(17, caba, santaFe).
recorrido(152, caba, santaFe).
recorrido(10, caba, santaFe).
recorrido(160, caba, medrano).
recorrido(24, caba, corrientes).
```

# 1 

```prolog
puedenCombinarse(linea1, linea2):-
    recorrido(Linea1, Zona, Calle),
    recorrido(Linea2, Zona, Calle).
    Linea1 \= Linea2. 
    
% Identidad: Una línea siempre comparte recorrido consigo misma. El predicado debería asegurar que sean dos líneas distintas.
```

# 2

```prolog
% Mi resolucion reciente MAL
cruzaLaGeneralPaz(Linea):-
    recorrido(Linea, Zona, _).
    recorrido(LInea, OtraZona, _),
     Zona \= OTrazona. 


jurisdiccion(Linea, nacional):-
    cruzaLaGeneralPaz(Linea).

jurisdiccion(Linea, Provincia):-
    recorrido(Linea, Provincia, _).
    not(cruzaLaGeneralPaz(Linea)),
 
% Si un bondi va de gba(sur) a gba(norte), para tu código cruzó la General Paz, estaria mal
% Devolvia la zona como gba(sur) y el enunciado pedia devolver BUENOS AIRES si era de gba(_)

% Mi resolucion vieja BIEN

cruzaGralPaz(Linea):-
    recorrido(Linea, caba, _),
    recorrido(Linea, gba(_), _).

perteneceA(caba, caba). % Si es de caba, devuelve caba
perteneceA(gba(_), buenosAires). % Si es de cualquier parte del gba, devuelve Buenos Aires

jurisdiccion(Linea, nacional):-
    cruzaGralPaz(Linea).

jurisdiccion(Linea, provincial(Provincia)):-
    recorrido(Linea, Zona, _),
    perteneceA(Zona, Provincia),
    not(cruzaGralPaz(Linea)).
```

# 3

```prolog
% Resolucion vieja, bien a medias


calleMasTransitada(Calle, Zona):-

    cuantasLineasPasan(Calle, Zona, Cantidad),

    forall(
        (recorrido(_, Zona, OtraCalle), Calle \= OtraCalle), 
        (cuantasLineasPasan(OtraCalle, Zona, CantidadMenor), Cantidad > CantidadMenor)
        ).

cantidadDeColectivosPorCalleEnZona(Calle, Zona, Total) :-
    recorrido(_,Zona, Calle),
    findall(Linea, recorrido(Linea, Zona, Calle), Lineas),
    length(Lineas, Total).

% Usar >= y comparar contra todas (incluida ella misma).
% Agregar predicado generador
% IMPORTANTE, en el forall deberia haberlo puesto en el antecedente.

calleMasTransitada(Zona, Calle):-
   
    recorrido(_, Zona, Calle),
    
    cantidadDeBondis(Zona, Calle, Cantidad),
    
    forall(
        (recorrido(_, Zona, OtraCalle), cantidadDeBondis(Zona, OtraCalle, OtraCant)),
        Cantidad >= OtraCant
    ).


cantidadDeBondis(Zona, Calle, Cantidad):-
    findall(Linea, recorrido(Linea, Zona, Calle), ListaLineas),
    length(ListaLineas, Cantidad).
```

# 4 

```prolog
calleTransbordo(Zona, Calle):-
    recorrido(_ , Zona, Calle),

    cantidadDeBondis(Zona, Calle, Cantidad),
    Cantidad >= 3,

    forall(
        recorrido(Linea, Zona, Calle),
        jurisdiccion(Linea, nacional)
    ).
```

# 5

### A

```prolog
% benficio(persona, condicion)
beneficio(pepito, personal(gba(oeste))).
beneficio(marta, personal(caba)).
beneficio(marta, personal(gba(sur))).
beneficio(juanita, estudiante).
beneficio(marta, jubilada).

% costoConBeneficio(Persona, Linea, Costo). 

costoConBeneficio(Persona, _, 50):-
    beneficio(Persona, estudiantil).

costoConBeneficio(Persona, Linea, 0):-
    beneficio(Persona, personal(Zona)),
    recorrido(Linea, Zona, _). 

costoConBeneficio(Persona, Linea, Costo):-
    beneficio(Persona, jubilado),
    valorNormal(Linea, ValorBase),  
    Costo is ValorBase / 2.

%costoConBeneficio(Persona, Linea, Costo):- % Personas sin beneficio.
    valorNormal(Linea, Costo),
```

### B

```prolog
valorNormal(Linea, 500):-
    jurisdiccion(Linea, nacional).

valorNormal(Linea, 350):-
    jurisdicion(Linea, provincial(caba)).

valorNormal(Linea, Costo):-
     jurisdicion(Linea, provincial(buenosAires)),
    
     cantidadDeCalles(Linea, Cantidad),

     plusPorZona(Linea, Plus),

     Costo is 25 * Cantidad + Plis.

% Auxiliares para B

cantidadDeCalles(Linea, Cant):-
    findall(Calle, recorrido(Linea, _, Calle), Calles),
    length(Calles, Cant).


plusPorZona(Linea, 0):-
    not(pasaPorDistintasZonas(Linea)).

plusPorZona(Linea, 50):-
    pasaPorDistintasZonas(Linea).

pasaPorDistintasZonas(Linea):-
    recorrido(Linea, Zona1, _),
    recorrido(Linea, Zona2, _),
    Zona1 \= Zona2

montoAPagar(Persona, Linea, MontoFinal):-
    beneficio(Persona, _), % Es beneficiario
    findall(Costo, costoConBeneficio(Persona, Linea, Costo), CostosPosibles),
    min_list(CostosPosibles, MontoFinal).

montoAPagar(Persona, Linea, Costo):-
    not(beneficio(Persona, _)),
    costoNormal(Linea, Costo).
```

### C

Conceptos clave: Extensibilidad y el Bajo Acoplamiento.

El impacto es mínimo porque no hace falta modificar el código existente, sino simplemente agregar nuevo conocimiento a la base, gracias al diseño del predicado costoConBeneficio/3 (que es polimórfico), solo necesitamos agregar una nueva cláusula (regla) que contemple el caso de la discapacidad. No hay que tocar ni costoNormal, ni el cálculo de jubilado, ni la lógica de montoAPagar.


















  
