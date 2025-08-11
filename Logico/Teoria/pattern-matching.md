Functor

Un functor es el nombre  de una estructura de datos compuesta, que funciona como un "constructor" o "etiqueta" para agrupar información. Tiene un nombre y una cantidad de argumentos, ya lo vimos es mas repaso

functor(arg1, arg2, ..., argN)

persona(juan, 30, ingeniero).

persona es el functor con 3 argumentos juan 30 ingeniero. Forma una estructura compuesta que representa a una persona con nombre edad y profesion

Estructuras compuestas

Es un termino formado por un functor y sus argumentos donde
Los argumentos pueden ser cual tipo de dato (atomo, numero, variable) o incluso otras estructuras complejas

Eso no spermite representar informacion compleja y jerarquica

Functor anidado
Los argumentos de un functor pueden ser, a su vez, otros términos compuestos con su propio functor.
persona(nombre(juan), direccion(calle, 123)).

Aca el termino principal es perosna/2, que tiene dor argumentos (nombre, direccion)
Pero a su vez cada argumento, es otra estructura compuesta. Esto es anidamiento de functores

Consultar estructuras compuestas

leyo(Persona, libro(_, paidos, _)).

Esto consulta todas las personas que leyeron libros de la editorial paidos, sin importar nombre o cantidad de páginas.
Pattern Matching con functores
Otra forma de consultar estructuras anidadas es con pattern matching para acceder a partes especificas 

tipo(libro(Nombre, Editorial, _)) :- ... .

Aca solo me interesa el nombre y la editorial, el _ es una variable anonima que ignora ese argumento

Aritmetica + pattern matchign

esLibroLargo(libro(_, _, Paginas)) :-
    Paginas > 500.

Con pattern matching reconocemos las Paginas de un libro, el resto de variables no importa y con la condicion arimetica para decir si es largo o no. 

