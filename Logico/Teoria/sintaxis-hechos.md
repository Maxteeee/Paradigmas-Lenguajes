Sintaxis y Hechos

Como vimos antes prolog es una base de conocimiento y se escriben hechos reglas y consultas
Hechos
Un hecho es una afirmación simple. Se representa como un predicado con uno o más argumentos y siempre terminan con un punto

Sintaxis:

predicado(argumento1, argumento2, ..., argumentoN).


Ejemplos:

ama(romeo, julieta).
viveEn(homero, springfield).
esPerro(firulais).


El orden SI IMPORTA, si ponemos padre(juan, maria). El primero sera el padre y el segundo el hijo porque asi lo edcidimos al nombrar el predicado.

TIPOS DE TERMINOS

Atomo: Comienzan en minuscula → juan pizza firulais
Numero: Numeros enteros o decimales → 5 3.14
Variable: Comienzan con mayuscula o _ → X Nombre 
Estructura: un functor con argumentos → padre(juan, maria)

En el ejemplo viveEn(homero, springfield).

El FUNCTOR seria vivenEN y los argumentos de ese functor son homero, springfield)
Reglas
Una regla dice cuando algo es verdadero en base a otros hechos o reglas

Sintaxis:

cabeza :- cuerpo.


Se lee como: “La cabeza es verdadera si el cuerpo es verdadero”

Ejemplo:

hijo(X, Y) :- padre(Y, X).


Se lee como: “X es hijo de Y si Y es padre de X
:-  se llama “implicacion inversa” y se lee como si

Basicamente cuando usamos el :- es un “la izquierda es Verdadero si la derecha es Verdadero”
Consultas
Son unicamente las consultas que haces por consola al abrir el interprete, prolog responde true/false o valores que unifican una consulta

Ejemplos de consultas:

?- esPerro(firulais).     % true
?- ama(romeo, X).         % X = julieta
?- padre(juan, X).        % Prolog devuelve todos los hijos de Juan








