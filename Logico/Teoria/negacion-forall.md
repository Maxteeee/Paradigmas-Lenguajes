# Esta mal la negacion se usa el NOT

Negación
La negacion no es una negacion logica clasica, no funciona como en logica matematica, sinpo que esta basada en la idea de: Negacion como falla (Negacion por refutacion)

Es decir

\+ P

Significa: "No puedo probar que P sea cierto" o "P falla".

¿Por que?

Ya que como vimos, prolog usa el principio del universo cerrado que dice “Todo lo que no esta probado como cierto, se considera falso” Entonces, si no hay evidencia para P, Prolog asume \+ P

Ejemplo:

padre(juan, maria).

?- padre(juan, maria).   % True, porque está declarado
?- padre(juan, pedro).   % False, no está declarado
?- \+ padre(juan, pedro). % True, porque padre(juan, pedro) falla

Limitaciones de la negacion

No funciona con variables no instanciadas

?- \+ padre(juan, X).

Aquí Prolog no puede decir si es cierto o no porque X es variable y hay soluciones para padre(juan, X) (maria), entonces no puede afirmar la negación.}

Para que la negación funcione correctamente, las consultas deberían estar instanciadas (sin variables libres).
Forall/2
En palabras simples antes de la explicaicon tencnica es un PARA TODO.
Para todo X (solucion) que cumple Y (condicion), tambien se cumple Z (consecuencia)

El predicado forall(Condicion, Accion) se interpreta como

	“Para todas las soluciones que cumplen Cond, se cumple Accion.”

Es decir, no basta que alguna solución cumpla Accion, sino que todas las soluciones de Cond deben cumplir Accion.

Funcionamiento interno

forall(Cond, Accion)  

Es igual a

 \+ (Cond, \+ Accion)

Ejemplo para entender

persona(juan).
persona(maria).
persona(ana).

tieneLicencia(juan).
tieneLicencia(maria).

Queremos consultar si todas las personas tienen lincencial con forall

?- forall(persona(X), tieneLicencia(X)).

Esta consulta será false porque ana no tiene licencia.

Forall + Negacion

Muchas veces queremos expresar 
"Para todo X que cumple Y, Z se cumple".
Podemos usar 
forall(P, Q)
o lo mismo
\+ (P, \+ Q)
Es decir, no existe ningun X que cumpla P y no cumpla Q
No usar forall
Si escribimos algo como
predicado(X) :- condicion(X), accion(X).
“ X es verdadero y condicion X y Accion X se cumplen”
Esto no garantiza que para todos los casos de condicion se cumpla accion, porque es un Y, con que una sea verdadera todo sera verdadero
Si existe un X que cumple condicion pero no cumple accion, la regla no falla pero no expresa el "para todo".



