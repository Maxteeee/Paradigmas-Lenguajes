# Forall/2

Es un predicado de orden superior, ya que recibe dos consultas. Verifica que todos los que cumplen la primera consulta, tambien cumplen la segunda

Es basicamente el PARA TODO de logica.

Es importante, vincular siempre las 2 consultas por medio de una varibable libre, asi podemos decir el **"Para todo X, tal que X"**

antecedente -> consecuente (if)

**Ejemplo:**

```prolog
limitrofe(Pais, Limitrofe). % relaciona un pais con su limitrofe

ocupa(Jugador, Pais, Ejercitos). % Un jugador ocupa cierto pais, con cierta cantidad de ejercito
```

**Queremos saber si un pais limitrofe a donde esamos parados esta ocupado por un rival**

```prolog
ocupadoPorRival(Pais, Jugador) :=
    ocupa(Rival, Pais; _),
    Rival \= Jugador.

estaRodeado(Pais):=
    ocupa(Jugador, Pais, _),
    forall(limitrofes(Pais,OtroPais),
        ocupadoPorRival(OtroPais, Jugador)).
```

## Explicacion

**ocupadoPorRival**
- Recibe un pais X y un jugador
- nos dice si un pais X esta ocupado por un RIVAL (distinto de Jugador)

**estaRodeado**
- Si un jugador ocupa X pais y
- Para todo OTROPAIS limitrofe a X, se cumple que OTROPAIS esta ocupado por un RIVAL. 

# Antecedente y consecuente

V -> V = V
V -> F = F
F -> V = V 
F -> F = V

Si nadie cumple el antecedente, el forall devuelte TRUE. Esto es por la tabla de verdad del IF

# Inversibilidad

El forall por si solo falla en la inversibiilidad, si queremos que funcione tendriamos que generarlos previamente.

Para eso usamos los predicados GENERADORES que ya vimos

