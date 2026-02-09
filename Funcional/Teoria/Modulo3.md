# TEMAS
LISTAS
TUPLAS
DATAS

# Listas

Una lista es una serie de elementos del mismo tipo. En esa serie puede no haber elementos, en ese caso la lista es vacía

La forma más sencilla de generar una lista es enumerar los elementos encerrados entre corchetes y separar cada elemento mediante una coma

[1, 2, 3]
["Hola", "mundo"]

los strings son una lista de caracteres

"Hola" ==> lista de caracteres ≣ ['H', 'o', 'l', 'a']

### Generador de numeros

Con ".." luego del numero podemos generar el resto de numeros
[1..10] = [1,2,3,4,5,6,7,8,9,10]

E incluso podemos definir una lista infinita:
[1..] = [1,2,3,4,5,6,7...........

## Pattern matching en listas

Existen varios patrones para trabajar las listas:

- (x:xs) --> El operador : separa cabeza y cola de una lista. Lista que tiene al menos un elemento, donde la cabeza es un elemento x, y la cola es una lista (son muchos x, por eso la convención es xs). 

- (x:y:ys) --> Lista de al menos 2 elementos

### Ejemplos rebuscados

- [1, 4] --> Cabeza 1 y cola [4], no el 4 sino la lista de 4
- [[1, 7], [8, 7, 5], []] --> Cabeza [1, 7] y cola [8, 7, 5], []

# Tuplas

Las tuplas permiten representar un tipo de dato compuesto, pero con elementos que pueden ser de distinto tipo.

(23, 02, 1973) => tupla de 3 elementos para representar una fecha
("Juan", 23)   => tupla de 2 elementos para representar una persona

## Diferencia entre tuplas y listas 

Vamos a repetirlos pero tiene que quedar bien en claro
1. Las listas requieren que todos los elementos sean homogéneos: no podemos mezclar en una misma lista números y strings. Las tuplas pueden ser heterogéneas.
2. El número de elementos de una lista es variable, puede ser infinito. En una tupla el número de elementos es fijo.
3. La lista es un tipo de dato recursivo, la tupla no, aunque ambos son compuestos.

# Datas

Los datas son basicamente structs de C, sirve para crear tus propios tipos de datos.

Se usa asi:

```haskell
data NombreDelTipo = Constructor

data Persona = UnaPersona String Int
```

Esto se lee como: “el tipo de dato Persona  utiliza un constructor –UnaPersona- que recibe un String y un Int”.

## Pattern matching sobre data

No lo vamos a usar porque queda obsoleto con el item de abajo, pero es bueno saberlo

```haskell
nombre (Persona _nombre _edad) = _nombre
edad (Persona _nombre _edad) = _edad
```
## Record syntax

Volviendo a la construccion de la persona, era muy simple si ahora nos piden guardarmas datos se volveria todo menos expresivo

data Persona = Persona String Int String String (Int, Int, Int) Bool Float

Sin contar que ahora necesitariamos funciones que sean como nombre y edad

```haskell
domicilio :: Persona -> String
domicilio (Persona _ _ dom _ _ _ _) = dom
```

Para sumar expresividad y evitar definiciones que podríamos considerar “redundantes”, tenemos la notación record syntax que consiste en definir Persona de la siguiente manera:

```haskell
data Persona = UnaPersona {
	nombre :: String,
	edad :: Int,
	domicilio :: String,
	telefono :: String,
	fechaNacimiento :: (Int, Int, Int),
	buenaPersona :: Bool,
	plata :: Float
}
```
### Construir valores

```haskell
juan :: Persona
juan = UnaPersona "Juan" 29 "Ayacucho 554" "45232598" (17,7,1988) True 30.0
```

Pero como el tipo de dato Persona está definido con record syntax, tenemos una alternativa para modelar a Juan:

```haskell
juan = Persona {
    nombre = "Juan",
    edad = 29,
    domicilio = "Ayacucho 554",
    telefono = "45232598",
    fechaNacimiento = (17,7,1988),
    buenaPersona = True,
    plata = 30.0
}
```

No solo es más expresiva la forma de definir la información, sino que también podemos alterar el orden en el que definimos los valores de juan:

```haskell
juan = Persona {
    nombre = "Juan",
    telefono = "45232598",
    domicilio = "Ayacucho 554",
    fechaNacimiento = (17,7,1988),
    buenaPersona = True,
    edad = 29,
    plata = 30.0
}
```
## Acceder a valores

Ahora tampoco es necesario escribir funciones como edad (Persona _nombre _edad) = _edad  Éstas están implícitas por la definición del tipo de dato Persona

```haskell
ghc> telefono juan
"45232598"
ghc> domicilio juan
"Ayacucho 554"
```

## Tipos con multiples opciones

Estos son muy parecidos a los enum en otros lenguajes como Java o C.

```haskell
data Luz = Verde | Amarillo | Rojo
```
Esto significa: el tipo Luz puede ser una de tres cosas: Verde, Amarillo o Rojo

```haskell
proximaLuz :: Luz -> Luz
proximaLuz Verde    = Amarillo
proximaLuz Amarillo = Rojo
proximaLuz Rojo     = Verde
```

### Crear un nuevo data con algun campo modificado
Se puede crear desde 0 y escribir todo a mano, pero sino la forma mas directa es

juan2 :: Persona
juan2 = juan { domicilio = "av caseros 204" }

Creamos una persona igual a juan pero con un campo cambiado
