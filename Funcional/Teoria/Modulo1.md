# TEMAS
INTRO A PARADIGMA FUNCIONAL
FUNCIONES BASICAS
GUARDAS

# Paradigma funcional

Un programa segun el paradigma funcional es una FUNCION justamente, osea una transformacion de una entrada en una salida

La salida depende de las entradas

Se respetan conceptos de las funciones:
- Existencia: Todo elemento del codominio (imagen) debe de tener una imagen
- Unicidad: Cada elemetno del dominio tiene una sola imagen, no pueden haber dos Y para un mismo X

Por eso muchos conceptos matematicos van a ser usados en este paradigma

## Transparencia referencial

Una expresión es referencialmente transparente si siempre vale lo mismo y la podés reemplazar por su resultado sin que cambie el programa.

Supongamos que tengo la funcion

F(x) = x + 1 entonces F(1) siempre da 2.

Ahora si en el programa escribo F(1) + F(1) seria lo mismo que decir 2 + 2

Esto es importante porque en haskell puedo hacer literalmente funciones

```haskell
doble x = x * 2

doble (1+2) = doble 3 = 6 
```

## Variables

Mientras que una variable en el paradigma imperativo representa  una posición de memoria donde almaceno valores, en el paradigma funcional respeta la definicion matematica de variable, osea es una INCOGNITA. Un valor que todavia no fue calculado

Y = log (x)

X e Y son dos variables matematicas, X la variable independiente e Y la variable dependiente.

# Introduccion a Haskell

## Primeras funciones

Vamos a ir con un ejemplo para que se entienda, nos piden una funcion para saber si un alumno aprobo, es decir recibimos un entero sin decimales del 1 al 10 y luego devolvemos un booleano.

Definimos la funcion:

```haskell
aproboAlumno :: Int -> Bool
```

Y luego definimos la funcion, como criterio para que apruebe la nota tiene que ser mayor a 6

```haskell
aproboAlumno nota = nota >= 6
```
nota es una varibale porque en el momento de DEFINIR la funcion no conozco su valor, es una incognita. Ademas el signo = no define una igualdad matematica, nos sirve a la hora de reducir expresiones

## Chequeos de tipos de Haskell

Haskell es un lenguaje con chequeo estatico de tipos, tener chequeo de tipos estático o dinámico es una característica del lenguaje y no del paradigma. 

## Guardas

Vamos a ver el uso de guardar con la funcion MAX. En matematica podemos definir una función por partes . Para ciertos valores del dominio mi conjunto imagen era uno y para otros valores mi conjunto imagen era otro, en haskell se escribe asi

```haskell
max x y | x > y     = x
        | otherwise = y
```

**Tips:**
- Como otherwise siempre se cumple, se debe escribir como última condición

Nota: No aclaramos de que tipo es max. Podemos recibiri cualquier X Y mientras sepamos cual es MAYOR que el otro. Esto quiere decir que puedo hacer consultas por número, pero también por caracteres, o Strings

Ejemplos en consola

```haskell
λ max 3 7
7
:: (Num a, Ord a) => a

λ max "francia" "tailandia"
"tailandia"
:: [Char]

λ max 'd' 'a'
'd'
:: Char

λ max False True
True  -- la verdad es más grande que la mentira
:: Bool
```

## Uso innecesario de guardas

Queremos modelar la función que nos dice si podemos avanzar nuestro auto en base a la indicación del semáforo

```haskell
puedoAvanzar :: String -> Bool
puedoAvanzar color | color == "verde" = True
                   | otherwise        = False
```

Esta bien definida pero tiene un uso inadecuado de guardas,  si entendemos que color == "verde" es una expresión booleana que podemos utilizar perfectamente como valor de retorno de nuestra función. Si eliminamos redundancias, simplificamos nuestra definición a

```haskell
puedoAvanzar :: String -> Bool
puedoAvanzar color = color == "verde"
```
