https://docs.google.com/document/d/1xFUxx_4XGdg9TXltWtxY-3zL2E6xEKuEccQDLtEui3c/edit?tab=t.0

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

puedenCombinarse(linea1, linea2)

cruzaGralPaz(Linea):-
    recorrido(Linea, caba, _),
    recorrido(Linea, gba(_), _).

perteneceA(caba, caba).
perteneceA(gba(_), buenosAires).

jurisdiccion(Linea, nacional):-
    cruzaGralPaz(Linea).

jurisdiccion(Linea, provincial(Provincia)):-
    recorrido(Linea, Zona, _),
    perteneceA(Zona, Provincia),
    not(cruzaGralPaz(Linea)).

calleMasTransitada(Zona, Calle):-
    recorrido(_, Zona, Calle),
    
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

calleTransbordo(Linea, Calle, Zona):-
    recorrido(_, Zona, Calle)
    cantidadDeColectivosPorCalleEnZona(Calle, Zona, Total),
    Total >= 3,
    forall(
        recorrido(Linea, Zona, Calle),
        jurisdiccion(Linea, nacional).
    ).


beneficio(pepito, personal(gba(oeste))).
beneficio(juanita, estudiantil).
beneficio(marta, jubilado).
benficio(marta, personal(caba)).
beneficio(marta, personal(gba(sur))).

subsidio(estudiantil, _, 50).

subsidio(personal(Zona), Linea, 0):-
    pasaPorZona(Linea, Zona):-

subsidio(jubilado, Linea, ValorConBeneficio):-
    valorNormal(Linea, ValorNormal),
    ValorConBeneficio is ValorNormal // 2.

pasaPorZona(Linea, Zona):-
    recorrido(Linea, Zona, _),

valorNormal(Linea, 500)












  
