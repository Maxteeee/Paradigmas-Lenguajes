# TEMAS
LAZY EVALUATION
RECURSIVIDAD CON INDUCCION
RECURSIVIDAD CON LISTAS (infinitas tambien)

# Lazy evaluation

En Haskell, las expresiones no se evalúan inmediatamente. Solo se evalúan a medida que se van necesitando. Esto se llama evaluación diferida o perezosa.

```haskell
-- Lista infinita de números naturales
naturales :: [Int]
naturales = [1..]

-- Solo tomamos los primeros 5
primerosCinco = take 5 naturales  -- [1,2,3,4,5]
```

Haskell no genera la lista infinita, solo calcula los primeros 5 elementos porque take 5 lo exige. Si intentaramos evaluar toda la lista, el programa no termina nunca

Para trabajar con listas infinitas sin colgarnos, hay que usar funciones que usan la evaluacion perezosa para extraer, transformar o filtrar una parte finita sin colgar el programa.
 
take n → toma los primeros n elementos
drop n → se salta los primeros n elementos
!! n → devuelve el elemento en la posicion n
head → devuelve el primer elemento
tail → devuelve la lista sin el primer elemento

**Ventajas de lazy evaluation**

- Con la evaluación diferida sólo se evalúa aquello que realmente se necesita. 

# Recursividad con induccion

El concepto de recursividad viene atado al de inducción: verifico P(0), y defino P(N + 1) en base a P(N). Como P(N) se cumple P(N+1) tambien lo hara por induccion

Si queremos representar un factorial, primero definimos el caso base

```haskell
factorial 0  =  1
```

El factorial de un número positivo mayor a 0 se calcula como el mismo numero por el factorial de numero-1 y aca esta el caso recursivo

```haskell
factorial n  =  n * factorial (n - 1)
```

todo junto queda

```haskell
factorial 0  =  1
factorial n  =  n * factorial (n - 1)

-- Tambien sepueden usar guardas como solucion, es lo mismo

factorial n 
  | n == 0     = 1
  | n > 0      = n * factorial (n - 1)
```

Entonces recordemos: todo algoritmo recursivo SIEMPRE SIN IMPORTAR EL LENGUAJE TIENE
- un caso base para cortar la recursividad
- un caso recursivo para que verdaderamente exista recursividad

## Ejercicio

Definir una función que me devuelva si un número es primo o no. Esto se puede plantear asi

“Un número es primo si no es divisible por todos los números que lo preceden”. 
- 1 no es primo
- 2 es primo
- todo numero mayor a 2 es primo si no encuentro numeros divisores de n desde 2 hasta n-1

```haskell
primo 1 = False
primo 2 = True
primo n = noHayDivisores 2 (n - 1) n
```

Para saber si no hay divisores de un número en un rango
- si alguno de los números del rango es divisor, entonces pude probar que no se cumple (que no haya divisores)
- si llegué a cubrir todo el rango de números, pude probar que se cumple
- en caso contrario, tengo que continuar con el siguiente número en el rango y repetir la verificación.

```haskell
noHayDivisores minimo maximo n 
    | mod n minimo == 0  = False
    | minimo == maximo   = True
    | otherwise          = noHayDivisores (minimo + 1) maximo n
```

Nota: La funcion mod calcula el resto de hacer parametro1/parametro2

# Recursividad con listas

Aca el caso de la recursion es asi:
- el caso base es la lista vacía
- el caso recursivo es una lista de 1 ó más elementos, cuya cabeza es el primer elemento y cuya cola es una lista con los restantes

Ejemplo sumar una lista

```haskell
sumarLista :: [Int] -> Int
sumarLista [] = 0
sumarLista (x:xs) = x + sumarLista xs
```

- Caso base: Si la lista esta vacia [], la suma es 0 
- Caso recursivo: Si la lista tiene al menos un elemento (x:xs), separamos al primer elemento X y el resto XS. Entonces esto va a sumar X a la suma total que den todos los elementos XS

## Recursividad con listas infinitas

Hay que tener cuidado con los casos base, ya que las listas infinitas no tienen un final, por eso la recursión tradicional (que baja hasta el caso base) no puede recorrer toda la lista, porque el caso base nunca llega.

- No intentar consumir toda la lista (porque no termina).
- Procesar solo una parte finita, usando funciones como take.
- Usar la evaluación perezosa que Haskell ofrece para “detener” la recursión cuando ya se obtuvo lo que se necesita.

**Ejemplo: tomar los primeros N elementos de una lista infinita y duplicarlos**

```haskell
duplicarPrimerosN :: Int -> [Int] -> [Int]
duplicarPrimerosN 0 _ = []
duplicarPrimerosN n (x:xs) = (2 * x) : duplicarPrimerosN (n - 1) xs
```

- El caso base seria que si N = 0, devuelve la lista vacia.
- Si  N > 0 y la lista tiene al menos un elemento, la lista se separa en cabeza X y cola XS.
    - Hace Hace 2 * X y lo ponemos al frente con el operador ( : ) de la lista que resulta de llamar otra vez a la funcion con ( N - 1) porque ya llamamos al primer elemento de la cola de la lista XS.
