En este archivo vamos a resolver el parcial de 2020 para FUNCIONAL. Voy a hacer mi resolucion primero y luego la que aparece en los videos

Consigna: https://docs.google.com/document/d/1LeWBI6pg_7uNFN_yzS2DVuVHvD0M6PTlG1yK0lCvQVE/edit?tab=t.0#heading=h.wn9wma8e1ale

# Datos base

```haskell

-- Modelo inicial
data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)

mayorSegun f a b
  | f a > f b = a
  | otherwise = b

```

# 1 A

```haskell
type Palo = Habilidad -> Tiro

-- Dos formas de construir, constructor record syntax (putter) o posicional (el resto)
putter :: Palo
putter habilidad = UnTiro {
    velocidad = 10,
    precision = precisionJugador habilidad * 2,
    altura = 0
}

madera :: Palo
madera habilidad = UnTiro 100 (precisionJugador habilidad `div` 2) 5

hierro :: Int -> Palo
hierro n habilidad = UnTiro
  (fuerzaJugador habilidad * n)
  (precisionJugador habilidad `div` n)
  (max 0 (n - 3))
```

# B

```haskell
palos :: [Palo]
palos = [putter , madera] ++ map hierro [1..10]
```

# 2

```haskell
golpe :: Jugador -> Palo -> Tiro
golpe jugador palo = palo (habilidad jugador) 

-- Con composicion
golpe jugador palo = (palo . habilidad ) jugador
```

# 3

## Mi resolcuion

```haskell
data Obstaculo = Tunel | Laguna Int | Hoyo

puedeSuperar :: Obstaculo -> Tiro -> Bool
puedeSuperar Tunel tiro = 
    precision tiro > 90 && altura tiro == 0

puedeSuperar (Laguna _) tiro = 
    velocidad tiro > 80 && between 1 5 (altura tiro)

puedeSuperar Hoyo tiro = 
    between 5 20 (velocidad tiro) && altura tiro == 0 && precision tiro > 95

efectoTiro :: Obstaculo -> Tiro -> Tiro
efectoTiro obstaculo tiro 
    | puedeSuperar obstaculo tiro = efectoSiSupera obstaculo tiro
    | otherwise = UnTiro 0 0 0

-- Funx Aux
efectoSiSupera :: Obstaculo -> Tiro -> Tiro
efectoSiSupera Tunel tiro =
  tiro { velocidad = velocidad tiro * 2, precision = 100, altura = 0 }

efectoSiSupera (Laguna largo) tiro =
  tiro { altura = altura tiro `div` largo }

efectoSiSupera Hoyo _ = UnTiro 0 0 0
```


# 4 A

```haskell
palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles jugador obstaculo = 
    filter (sirveParaSuperar jugador obstaculo) palos

-- sirveParaSuperar jugador obstaculo devuelve una función de tipo: Palo -> Bool
-- filter espera justamente eso: filter :: (a -> Bool) -> [a] -> [a]
-- Basicamente es aplicacion parcial para que los tipos encajen

sirveParaSuperar :: Jugador -> Obstaculo -> Palo -> Bool
sirveParaSuperar jugador obstaculo palo =
  puedeSuperar obstaculo (golpe jugador palo)

```

# B 
En este punto se puede usar una funcion Auxiliar takewhile para evitar la recursividad

```haskell
-- Sin usar TAKEWHILE es mas facil sinceramente
superarConsecutivos :: [Obstaculo] -> Tiro -> Int
superarConsecutivos [] _ = 0

superarConsecutivos (obstaculo : restoObstaculos) tiro 
    | puedeSuperar obstaculo tiro =
         1 + superarConsecutivos restoObstaculos (efectoTiro obstaculo tiro)
    | otherwise = 0
```

# C

```haskell
paloMasUtil :: Jugador -> [Obstaculo] -> Palo
paloMasUtil jugador obstaculos =
  maximoSegun (cuantosSupera jugador obstaculos) palos

cuantosSupera :: Jugador -> [Obstaculo] -> Palo -> Int
cuantosSupera jugador obstaculos palo =
  superarConsecutivos obstaculos (golpe jugador palo)
```

# 5 

```haskell

pierdenLaApuesta :: [(Jugador, Puntos)] -> [String]
pierdenLaApuesta snd = 
    (map (padre.fst) . filter (not . gano puntosDeTorneo)) puntosDeTorneo

gano :: [(Jugador, Puntos)] -> (Jugador, Puntos) -> Bool
gano puntosDeTorneo puntosDeUnJugador
  = (all ((< snd puntosDeUnJugador).snd)
      . filter (/= puntosDeUnJugador)) puntosDeTorneo

```

Explicacion:
- El map agarra cada tupla de jugador puntos y devuelve el padre.
- Me rendi es un re choclo.