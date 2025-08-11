Paradigma Logico

¿Como se programa en Prolog?

Prolog no se basa en dar órdenes paso a paso como en C, Python o Java. En lugar de eso, declarás hechos y reglas que describen el mundo del problema, y luego hacés preguntas sobre ese mundo.

¿Que es un programa logico?
Un programa lógico está formado por:
Hechos: afirmaciones que siempre se consideran verdaderas.
Reglas: definiciones que dicen cuándo algo es verdadero en función de otras cosas.
Consultas: preguntas que hacés al programa para saber si algo es cierto o no, o qué valores hacen verdadera una regla. (Son las que se escriben en consola)
Universo cerrado (Closed World Assumption)
En prolog todo lo que no esta en la base del conocimiento se considera falso
esHumano(socrates).
esHumano(platon).


Si preguntas

?- esHumano(aristoteles).


Prolog responde false, aunque no dijiste explícitamente que NO lo es. Esto se llama universo cerrado: lo que no se sabe, se asume falso.

Unificación: el corazón de Prolog
Unificación: es encontrar los valores que hacen que dos estructuras coincidan
La unificación es el mecanismo por el cual Prolog resuelve consultas.

ama(romeo, julieta).


Si preguntas

?- ama(romeo, X).


Prolog unifica X con Julieta

¿Como se resuelven las consultas?
Con un motor de busqueda prolog:
1- Busca una regla o hecho que haga verdadera la consulta.
2- Si hay variables, trata de unificarlas con lo que hay en la base.
3- Si falla, vuelve atrás (backtracking) y prueba otra posibilidad.

