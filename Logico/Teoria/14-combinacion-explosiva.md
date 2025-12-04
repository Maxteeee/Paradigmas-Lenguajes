La explosión combinatoria es lo que sucede cuando un problema requiere generar todas las posibles combinaciones de un conjunto, lo que lleva a un crecimiento exponencial en el número de soluciones

Sucede típicamente en predicados recursivos que tienen dos caminos abiertos para cada elemento de una lista, como al construir subconjuntos.

# Ejemplo: actividadesPosibles/3
Este predicado genera todas las combinaciones de actividades que caben en un presupuesto

```prolog
actividad(cine).
actividad(arjona).
actividad(princesas_on_ice).
actividad(pool).
actividad(bowling).

costo(cine, 400).
costo(arjona, 1750).
costo(princesas_on_ice, 2500).
costo(pool, 350).
costo(bowling, 300).
```

### actividades(Plata, ActividadesPosibles) 
relaciona una determinada cantidad de plata con la combinación de actividades que podemos hacer.

```prolog
?- actividades(2350, Actividades).
Actividades = [cine, arjona] ;
Actividades = [cine, pool, bowling] ;
Actividades = [cine, pool] ;
Actividades = [cine, bowling] ;
Actividades = [cine] ;
Actividades = [arjona, pool] ;
Actividades = [arjona, bowling] ;
Actividades = [arjona] ;
Actividades = [pool, bowling] ;
Actividades = [pool] ;
Actividades = [bowling] ;
Actividades = []  % me quedo en casa y no gasto nada
```

Cada actividad está definida en predicados individuales, para poder trabajar la lista de actividades posibles necesitamos utilizar el predicado findall/3:

```prolog
actividades(Plata, ActividadesPosibles):-
   findall(Actividad, actividad(Actividad), Actividades),
   actividadesPosibles(Actividades, Plata, ActividadesPosibles).
```

Nota: Los parametros de actividadesPosibles son
- Una lista de todas las actividades que hay en la base
- La plata que tenemos de presupuesto
- La lista resultante con las actividades que pude hacer

# Ahora para el predicado actividadesṔosibles tenemos 3 alternativas

- Caso 1 base: No tengo actividades, no hay actividades posibles, no importa cuanta plata tenga

```prolog
actividadesPosibles([] , _ , []).
```

- Caso 2 Recursivo: Una actividad posible va a formar parte del conjunto solución si tengo plata suficiente. El resto de las actividades posibles se relacionará con la plata que me quede tras hacer esa actividad:

```prolog
actividadesPosibles([Actividad|Actividades], Plata, [Actividad|Posibles]):-
    costo(Actividad, Costo), 
    Plata > Costo, 
    PlataRestante is Plata - Costo,
     actividadesPosibles(Actividades, PlataRestante, Posibles).
     
```
Se llama a si mismo con la lista que quedo, la plata que me quedo despues de hacer la actividad, y la cola posibles, para las actividades posibles.

- Caso 3 Recursivo: Si decido no hacer esa actividad, tendré la misma plata para las actividades restantes:

```prolog
actividadesPosibles([_|Actividades], Plata, Posibles):-
      actividadesPosibles(Actividades, Plata, Posibles).
```

En la última cláusula puede pasar que no haga la actividad porque:
1. no tengo plata para hacer esa actividad, o bien
2. tengo plata para hacer esa actividad pero no me interesa. 


# SEGUIR VIENDO EL DOCUMETNO ETC






Consecuencia: Como Prolog considera ambos patrones coincidentes  (Caso 2 y Caso 3 en la recursión) , explora simultáneamente los dos caminos por cada actividad, resultando en la explosión combinatoria de todas las posibles soluciones (incluyendo "quedarme en casa" o "ir solo al cine").