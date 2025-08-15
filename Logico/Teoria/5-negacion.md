# Negacion

El not recibe una consulta, en vez de un individuio, es por eso que es un predicado de ORDEN SUPERIOR

Para entenderlo mas facil, se puede decir que cambia el signo de la consulta de adentro, es decir:

si la consulta es true -> da false el not
si la consulta es false -> da true el not

## Negacion de consultas

Seguimos con el ejemplo de programaEn

```prolog
programaEn(mateo, go).
programaEn(mateo, java).
programaEn(vicky, go).
programaEn(maru, c++).
```

### Consulta individual
```prolog
?- not(programaEn(mateo, python)).
True.
```

### Consulta existencial
```prolog
?- not(programaEn(_, python)).
True.
```

## Inversibilidad
El not no es inversible, no es capaz de decirme quienes NO CUMMPLEN. Porque basicamente el conjunto de quienes no cumplen algo es infinito.

```prolog
?- not(programaEn(Persona, python)).
True.
```
