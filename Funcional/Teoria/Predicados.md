# Funciones basicas sobre listas

## Lenght

Devuelve la cantidad de elementos de una lista.

```haskell
cantidadDeLetras :: String -> Int
cantidadDeLetras palabra = length palabra
```

## null

Dice si una lista está vacía.

```haskell
estaVacia :: [a] -> Bool
estaVacia lista = null lista
```

# Operaciones entre listas
## (++)

Concatena dos listas.

```haskell
juntarListas :: [Int] -> [Int] -> [Int]
juntarListas xs ys = xs ++ ys
```

## union

Une dos listas sin repetir elementos (requiere Eq).

```haskell
unirSinRepetidos :: [Int] -> [Int] -> [Int]
unirSinRepetidos a b = union a b
```

## intersect

Devuelve los elementos comunes entre dos listas.

```haskell
enComun :: [Int] -> [Int] -> [Int]
enComun a b = intersect a b
```

# Acceso a elementos

## (!!)

Accede a un elemento por índice (empieza en 0).

```haskell
tercerElemento :: [a] -> a
tercerElemento lista = lista !! 2
```

## elem

Pregunta si un elemento está en la lista.

```haskell
contieneP :: String -> Bool
contieneP palabra = elem 'p' palabra
```

# Valores extremos y agregados

## maximum / minimum

maximum: devuelve el mayor elemento de una lista.
minimum: devuelve el menor elemento de una lista.

```haskell
mayor :: [Int] -> Int
mayor numeros = maximum numeros

menor :: [Int] -> Int
menor numeros = minimum numeros
```

## sum

suma todos los elementos de una lista.

```haskell
total :: [Int] -> Int
total numeros = sum numeros
```

## concat

Aplana una lista de listas en una sola.

```haskell
aplanar :: [[Int]] -> [Int]
aplanar listas = concat listas
```

# Sublistas

## take

Toma los primeros n elementos.

```haskell
primerosTres :: [a] -> [a]
primerosTres lista = take 3 lista
```

## drop

Descarta los primeros n elementos.

```haskell
sinLosDosPrimeros :: [a] -> [a]
sinLosDosPrimeros lista = drop 2 lista
```

# Cabeza y cola

## head

devuelve el primer elemento. 

```haskell
primero :: [a] -> a
primero lista = head lista
```

## last

devuelve el último elemento

```haskell
ultimo :: [a] -> a
ultimo lista = last lista
```

## tail

devuelve la lista sin el primer elemento.

```haskell
sinPrimero :: [a] -> [a]
sinPrimero lista = tail lista
```

## init

devuelve la lista sin el último elemento

```haskell
sinUltimo :: [a] -> [a]
sinUltimo lista = init lista
```

# Relación entre listas

## zip

Une dos listas en pares.

```haskell
emparejar :: [a] -> [b] -> [(a,b)]
emparejar xs ys = zip xs ys
```

# Orden y transformación

## reverse

invierte el orden de una lista.

```haskell
invertir :: [a] -> [a]
invertir lista = reverse lista
```

## sort

ordena una lista

```haskell
ordenar :: [Int] -> [Int]
ordenar lista = sort lista
```

# Filtrado y mapeo

## filter

devuelve los elementos que cumplen una condición.

```haskell
soloPares :: [Int] -> [Int]
soloPares numeros = filter even numeros
```

## map

aplica una función a cada elemento de una lista.

```haskell
dobles :: [Int] -> [Int]
dobles numeros = map (*2) numeros
```

## all

devuelve True si todos los elementos cumplen una condición.

```haskell
todosPositivos :: [Int] -> Bool
todosPositivos numeros = all (> 0) numeros
```

## any

devuelve True si algún elemento cumple una condición.

```haskell
hayNegativo :: [Int] -> Bool
hayNegativo numeros = any (< 0) numeros
```

## concatMap

Mapea y concatena al mismo tiempo.

```haskell
duplicarYSacar :: [Int] -> [Int]
duplicarYSacar numeros = concatMap (\n -> [n, n]) numeros
```

# Plegados (folds)

## foldl

recorre la lista de izquierda a derecha acumulando un resultado.

```haskell
sumaFoldl :: [Int] -> Int
sumaFoldl numeros = foldl (+) 0 numeros
```

## foldr

recorre la lista de derecha a izquierda acumulando un resultado.

```haskell
productoFoldr :: [Int] -> Int
productoFoldr numeros = foldr (*) 1 numeros
```

Ambas reducen la lista a un solo valor usando una funcion y un acumulador inicial. Recibe
1. Una funcion 
2. El valor inicial (acumulador)
3. La lista

# Búsqueda

## find

devuelve el primer elemento que cumple una condición (o nada)

```haskell
primerPar :: [Int] -> Maybe Int
primerPar numeros = find even numeros
```

# Generadores de listas

## iterate
```haskell
potenciasDeDos :: [Int]
potenciasDeDos = iterate (*2) 1
```

## replicate
```haskell
cincoCeros :: [Int]
cincoCeros = replicate 5 0
```

## cycle
```haskell
repetirPatron :: [Int]
repetirPatron = cycle [1,2,3]
```

## repeat
```haskell
infinitosUnos :: [Int]
infinitosUnos = repeat 1
```

# Función de orden superior útil

## flip

Invierte los parámetros de una función.

```haskell
dividirAlReves :: Int -> Int -> Int
dividirAlReves = flip div
```