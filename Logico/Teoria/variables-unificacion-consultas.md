Variables, Unificación y Consultas Existenciales

Variables

En Prolog, una variable es cualquier nombre que empieza con mayúscula o con un guion bajo (_).

X
Persona
Hijo
_
_Alguien


Las variables se usan en REGLAS o CONSULTAS para decir 
	“Quiero saber QUIEN cumple con esta condicion”

Una variable esta instanciada cuando ya tiene un valor concreto asignado

Unificacion

La unificacion, como se vio, es el proceso clave de Prolog.

Es cuando Prolog intenta hacer que dos cosas sean IGUALES, asignando valores a las variables si es necesario

padre(juan, maria).


Y consultas

?- padre(juan, maria). % True 


Ahora si consultas

?- padre(juan, Hija). % Hija = maria


Por que? porque Prolog busca si hay un padre(juan, Algo) en la base de conocimientos. Como lo encontro lo UNIFICA. (Darse cuenta que Hija esta con H mayuscula por lo tanto es una variable?

Consultas existenciales

Las consultas existenciales son preguntas del estilo:
	“¿Existe algún individuo que cumpla esta condición?”

Usamos variables para esto

padre(juan, maria).
padre(juan, pedro).


Consulta

?- padre(juan, Hijo).


Prolog va a responder

Hijo = maria ;
Hijo = pedro.


Esto nos dice “Sí, existen personas que son hijos de Juan: María y Pedro.”

el ; permite pedir mas respuestas

Si por ejemplo hicieramos

?- padre(X, X). % False, ya que no se cumple en ningun caso que el padre sea la misma persona que su propio hijo.


