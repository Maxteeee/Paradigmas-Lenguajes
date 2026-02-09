# TEMAS
COMPOSICION
ACOPLAMIENTO
APLICACION PARCIAL

# Composicion

x --> Aplico funcion F --> F(x) --> Aplico funcion G --> G(F(x))

Sabemos que la composicion en matematica tiene una restriccion, la imagen de F (osea F(x)) tiene que coincidir con el dominio de G, lo mismo ocurre en haskell donde la notacion es con un "."

```haskell
(.) :: (b -> c) -> (a -> b) -> a -> c
```

El primer B C es la funcion G, el segundo A B es la funcion F. Luego dice que dado una entrada A tenemos una salida C 

En haskell se escribe asi.

```haskell
G(F(x)) = (G . F) x
```
Notemos como en haskell lo escribimos al reves, osea leemos de derecha a izquierda, primero se aplica F y luego G.

## Ejemplo 2

El requerimiento dice: “Saber si la longitud del nombre de una persona es una cantidad par”

Ya vamos pensando que vamos a recibir un nombre (String) devolver un Booleano. Podemos dividir la funcion en dos partes

1. Recibo el nombre y veo cuantas letras tiene
2. Eso retorna un numero, y veo si el numero es par o impar
3. Retorno True si es par.

Vamos a seguir este camino usando composicion y funciones de haskell

```haskell
nombrePar :: String -> Bool
nombrePar nombre = (even . length) nombre
nombrePar nombre = (even . length) nombre

-- TIP: Cuando se repite el nombre de la variable de esta forma podemos eliminarlo, no cambia nada pero queda prolijo idk

nombrePar = even . length
```

Explicacion: Recibimos la variable nombre de tipo STRING, recordemos que se aplica de derecha a izquierda, entonces a nombre le calculamos el largo con lenght y luego preguntamos si es par o no

Como vemos, el tipo de retorno/imagen de Length(nombre) --> Numero. Coinicide con el tipo de dato/dominio que espera even un NUMERO, por eso podemos usar composicion

# Ejemplo 3

Queremos saber si una persona es mayor de edad.

Conocemos el NOMBRE, la EDAD de una persona y su domicilio, esto lo podemos modelar como una tupla (String, Int, String)  (Si estas leyendo esto, tranqui que mas adelante explicamos lo que son las tuplas)

Pero no me interesa todo de esa persona solo la edad, por uso usamos la funcion de haskell snd que agarra el segundo elemento de la tupla

entonces el camino queda asi
1. Recibo una Persona y agarro su EDAD
2. Con la Edad veo si es mayor de edad o no y retorno.

```haskell
type Persona = (String, Int, String)

-- Ejemplo de construccion de una persona
laura :: Persona
laura = ("Laura", 41, "Medrano 951 CABA")

edad :: Persona -> Int
edad (_, e, _) = e

mayorDeEdad :: Int -> Bool
mayorDeEdad edad = edad > 18

esMayorEdad :: Persona -> Bool
esMayorEdad = mayorDeEdad . edad
```

Usamos la funcion EDAD que usa paterrn matching para devolver la edad en la tupla de 3 elementos.

**Tip**: Usamos Type persona para no tener que escribir 
esMayorEdad :: (String, Int, String) -> Bool

Simplifica las cosas y la lectura del problema.

# Acomplamiento
El acoplamiento mide cuánto depende una parte del programa de otra.
- Alto; Si cambio una parte rompo todo
- Bajo: Puedo cambiar una cosa sin romper el resto

- ¿Existe acoplamiento entre esMayorEdad y edad? Sí, ya que de lo contrario no podríamos resolver el requerimiento: “Saber si una persona es mayor de edad” PERO es acomplamiento bajo un cambio interno en la codificación de la función edad no afecta a la función esMayorEdad. 

De hecho, la función esMayorEdad solo necesita saber que puede resolver el requerimiento componiendo dos funciones cuya implementación no necesita conocer

# Aplicacion parcial

Aplicación parcial es aplicar una función a algunos de sus parámetros y obtener otra función esperando los que faltan.

```haskell
suma :: Int -> Int -> Int
suma x y = x + y
```

La aplicacion normal seria 

```haskell
suma 3 4
-- resultado: 7
```
Aplicacion parcial

```haskell
suma 3
```

Esto NO CALCULA nada todavia, sino que devuelve una funcion que esperaria un parametro para sumarle 3

```haskell
suma 3 :: Int -> Int

(suma 3) 4
-- resultado: 7
```

**Otro ejemplo**

```haskell
esMayorQue :: Int -> Int -> Bool
esMayorQue x y = y > x

mayorDeEdad :: Int -> Bool
mayorDeEdad = esMayorQue 18
```

Aca queda (esMayorQue 18) a la espera de un segundo parametro para comparar

```haskell
mayorDeEdad 20   -- True
mayorDeEdad 15   -- False
```

Nota: El orden importa para un operador binario 

(op) :: a -> a -> b

- (x op) fija el primer argumento
- (op x) fija el segundo argumento

Para la + * == etc el orden no importa pero para restas, potencias y cosas asi si va a importar como apliquemos parcialemten


# Composicion + Aplicacion parcial

“El costo de estacionamiento es de 50 pesos la hora, con un mínimo de 2 horas”, esto significa que
- si estamos 1 hora, nos cobrarán por 2 horas
- si estamos 3 horas, nos cobrarán por 3 horas

Vamos a recibir el tiempo que dejamos el auto y con eso nos van a devolver el costo, la funcion va de Int a Int

Pensamos como lo podemos solucionar y partimos el problema en problemas mas chicos
1. Recibo el tiempo que se quedo el auto y me quedo con el tiempo total
2. Con el tiempo total veo cuantas horass son para multiplicar por el costo y devuelvo el total

La primera parte deberiamos considerar el maximo entre 2 y el tiempo del auto. Se puede usar la funcion MAX. Por otra parte si el costo es siempre fijo (50) es solo multiplicar por 50 aca podemos usar aplicacion parcial del operador *

costoEstacionamiento :: Int -> Int
costoEstacionamiento horas = ((* 50) . max 2) horas

-- La var horas se puede eliminar
costoEstacionamiento = (* 50) . max 2

**Explicacion**: 
1. Aplicamos parcialmente la funcion max y el operador *
2. Hacemos Max 2 horas --> da las horas
3. A esas horas las multiplicamos por 50, haber hecho (50 *) era lo mismo porque es conmutativa la multiplicacion