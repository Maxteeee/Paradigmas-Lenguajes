Que es la inversibilidad 

En prolog, un predicado es inversible si funciona en todas las direcciones. Es decir podes usarlo para:


Preguntar que cumple una condicion (consulta con variables).
Preguntar Si algo cumple una condicion (consulta con valores concretos).
En algunos casos, generar valores que cumplen una condicion

Importancia de la invertibilidad

Si tu predicado no es inversible, puede funcionar en un sentido (por ejemplo, dar respuestas correctas para una consulta), pero fallar o comportarse mal cuando se usa de otra forma.

Para lograrla hay que

Usá variables y no hagas suposiciones de instanciación: Evitá hacer que un argumento siempre tenga que ser una constante o que una variable tenga que estar instanciada para que funcione.
Evitar cortes (!) y negaciones problemáticas que limiten cómo se puede usar el predicado.
Escribí reglas que funcionen para todos los casos posibles de variables y valores.

Ejemplo NO inversible

mayorQue10(X) :- X > 10.

Esto funciona si consultás con un número concreto:

?- mayorQue10(15). % true
?- mayorQue10(5).  % false


Pero no funciona para generar números mayores que 10:

?- mayorQue10(X).  % ERROR o fallo, porque X no está instanciado para comparar




