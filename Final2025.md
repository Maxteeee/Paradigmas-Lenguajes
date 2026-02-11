La consigna esta en mi drive no rompan la pija jijo

# Haskell

## 1 A

### Codigo dado

```haskell
sanar (Pollo peso _ descripcion) = 
    Pollo peso true descripcion

aumentarPeso incremento  (Pollo peso salud descripcion) =
    Pollo (peso + incremento) salud descripcion

agregarDescripcion agregado (Pollo peso salud descripcion) =
    Pollo peso salud (agregado ++ descripcion)
```

### Codigo para completar la solucion

```haskell
data Pollo = Pollo {
    peso :: Int,
    salud :: Bool,
    descripcion :: String
}

type Medicamento = Pollo -> Pollo 

-- Composicion
vacuna :: Medicamento
vacuna pollo = (sanar . aumentarPeso 10) pollo

vacunaPointFree :: Medicamento
vacunaPointFree = sanar . aumentarPeso 10

-- Mi resolucion (Mal, no uso las funciones dadas y no aprovecho el funcional)
antibioticoMio :: Int -> Medicamento
antibioticoMio unidades pollo = Pollo (peso - unidades) True descripcion

-- Correcion(es) // Aplicacion parcial y composicion
antibioticoCorregido :: Int -> Medicamento
antibioticoCorregido unidades pollo = (sanar . aumentarPeso (-unidades)) pollo

antibioticoCorregidoPointFree :: Int -> Medicamento
antibioticoCorregidoPointFree unidades = sanar . aumentarPeso (-unidades)

pastillasDeColores :: String -> Medicamento
pastillasDeColores color pollo = agregarDescripcion color pollo

-- Point free // Aunq la IA dice aplicacion parcial
pastillasDeColores :: String -> Medicamento
pastillasDeColores = agregarDescripcion

-- A todos por igual
suminstracionGeneral :: Medicamento -> [Pollo] -> [Pollo]
suministracionGeneral medicamento pollos = map medicamento pollos

-- Point free // Aunq la IA dice aplicacion parcial
suministracionGeneral :: Medicamento -> [Pollo] -> [Pollo]
suministracionGeneral = map
```

# 1 B

1. Suministrar a todos los pollos una vacuna
- suministracionGeneral vacuna [Pollo1, Pollo2, Pollo3]

2. Suministrar a todos los pollos una pastilla verde
- suministracionGeneral (pastillasDeColores "Verde") [Pollo1, Pollo2, Pollo3]

3. Suministrar a todos los pollos un antibiotico con dosis 5
- suministracionGeneral (antibiotico 5) [Pollo1, Pollo2, Pollo3]

Nota: La lista de poollos asi no existe, deberia poner ejemplos con valores reales como **[Pollo 10 False "Blanco", Pollo 8 True "Grande", Pollo 12 False "Joven"]** pero es valido para el examen no creo que rompan la pija

## 2

1. **APLICACION PARCIAL:** Es la capacidad de llamar a una función con menos argumentos de los que espera. En Haskell, esto no genera un error, sino que devuelve una nueva función que espera los argumentos restantes. Esto es posible gracias a que todas las funciones en Haskell están currificadas (técnicamente solo reciben un argumento a la vez).

Se uso en algunas partes del codigo como 
- **aumentarPeso 10:** aumentarPeso espera un entero y un pollo. Al pasarle solo el 10, creamos una función nueva de tipo Pollo -> Pollo.

- **pastillasDeColores "Verde":** Genera una función que ya tiene prefijado el color y solo espera al pollo para aplicarlo.

Las ventajas de utilizar aplicacion parcial son que permite crear funciones específicas a partir de funciones generales sin escribir código nuevo. Y es la base para poder pasar funciones como argumentos a otras funciones (como hicimos con el map en el ultimo punto)

2. **COMPOSICION:** Es la combinación de dos o más funciones para generar una nueva función.

Se uso en algunas partes del codigo como
- **vacuna = sanar . aumentarPeso 10:** Aquí combinamos el efecto de subir de peso con el de sanar. El pollo entra en aumentarPeso, sale un "pollo gordo" y ese entra en sanar.

- **antibiotico dosis = sanar . aumentarPeso (negate dosis):** Combinamos la sanación con la pérdida de peso en una sola línea lógica.

Las ventajas de utilizar composicion son que nos permiten ser mas declarativos, es decir, enfocarnos en el qué hace el sistema (una vacuna es sanar y aumentar peso) y no en el cómo (paso a paso imperativo). Ademas, permite definir funciones sin mencionar explícitamente los argumentos (como en vacuna), lo que hace el código más limpio y abstracto (Point free).

3. Otros conceptos usados fueron la **Abstracción mediante Alias de Tipo**. Definimos **type Medicamento = Pollo -> Pollo**, establecemos un contrato, esto implica que un medicamento no es un dato ni un identificador simbólico, sino una función que transforma un pollo en otro pollo.

La ventaja es que esto permite modelar el dominio de manera declarativa. Un medicamento es literalmente una transformación sobre el estado del pollo. No hay condicionales que pregunten “qué medicamento es”, sino que cada medicamento encapsula su comportamiento y vuelve mas facil incorporar nuevos medicamentos como eliminarlos.

4. Por ultimo otro concepto son las funciones de orden superior, osea funciones que pueden recibir otras funciones como parámetros o devolver funciones como resultado.

Se uso en **En suministracionGeneral = map.** La función map es de orden superior porque recibe un Medicamento (que es una función) y la aplica a toda la lista. 

5. Extra: Podemos mencionar a la inmutabilidad, los pollos no van cambiando sino que cada funcion medicamento devuelve un pollo totalmente nuevo con valores modificados, esto evita el "efecto de lado" y hace que el programa sea más predecible.

# Wollok

## 3 A

### Codigo dado

```java 
class Pollo {
    var peso = 100
    var estaSano = false
    var descripcion = "coco"

    method sanar() {
        estaSano = true
    }

    method aumentarPeso(incremento) {
        peso += incremento
    }

    method agregarDescripcion(agregar){
        descripcion = agregado + descripcion
    }
}
```

### Codigo para completar la solucion

```java 

class Medicamento {
    method aplicar(pollo) {

    }
}
class Vacuna inherits Medicamento {
 
    override method aplicar(pollo){
        pollo.sanar()
        pollo.aumentarPeso(10)
    }
}

class Antibiotico inherits Medicamento {
    var property dosis // El parametro vive aca no se pasa por parametro como pense

    override method aplicar(pollo){
        pollo.sanar()
        pollo.aumentarPeso(-dosis)
    }
}

class PastillaDeColor inherits Medicamento {
    var property color

     override method aplicar(pollo){
       pollo.agregarDescripcion(color)
    }
}

// Aplicar a todos
object Granja {
    var pollos = #{}

    method suministrarATodos(medicamento) {
        pollos.forEach({ pollo => medicamento.aplicar(pollo) })
    }
}
``` 

## 3 B

1. Suministrar a todos los pollos una vacuna
- var vacuna = new Vacuna()
- Granja.suministrarATodos(vacuna)

2. Suministrar a todos los pollos una pastilla verde
- var pastilla = new PastillaDeColor()
- pastilla.color = "Verde"
- Granja.suministrarATodos(pastilla)

3. Suministrar a todos los pollos un antibiotico con dosis 5
- var antibiotico = new Antibiotico()
- antibiotico.dosis = 5
- Granja.suministrarATodos(antibiotico)

## 4

1. **POLIMORFISMO:** Este se aplica en el metodo suministrarATodos(medicamento) de la Granja, este le envía el mensaje aplicar(pollo) al objeto medicamento sin saber (ni importarle) si este es una instancia de Vacuna, Antibiotico o PastillaDeColor.

Las ventajas del polimorfismo es la flexibilidad y extensibilidad que te ofrecen, Podés agregar un Jarabe mañana mismo; mientras ese jarabe entienda el mensaje aplicar(pollo), la Granja seguirá funcionando sin cambiar una sola línea de código. Ademas hay desacoplamiento porque la granja no sabe, ni le interesa saber los detalles internos de cada elemento

2. **HERENCIA:** Las diferentes clases vacuna, antibiotico y pastilla de color. EStan herendo el comportamiento definido en Medicamento.

La ventaja es que permite reutilizar la interfaz común y especializar el comportamiento en cada subclase. Se evita duplicación de código y se mantiene una jerarquía conceptual clara.

3. **ENCAPSULAMIENTO:** Se puede observar el uso de este concepto en las clases antibiotico y pastilla de color, cada clase tiene atributos que definen su estado interno y solo ellos saben como modificarlo

Las ventajas son que, se proteje el estado del objeto, el mundo exterior no puede modificar la dosis de un antibiótico a menos que el objeto lo permita.
Ademas, sirve para que los objetos de afuera como la granja, aplicar un antibiótico es igual de simple que aplicar una vacuna, aunque el antibiótico necesite internamente una dosis para trabajar.

# Prolog

## 5 

### Codigo dado

```prolog
pollo(Descripcion, Peso, Salud).  % Todos los pollos, inversible
saludPosible(Salud). % Todos los esatados de salud, inversible

% La salud del pollo no es Bool, puede asumir valores como saludable, debil, maso, indefinido
``` 
## Solucion

```prolog
promedioPeso(Salud, Promedio):-   
    saludPosible(Salud),

    findall(Peso, pollo(_, Peso, Salud), Pesos )

    sumlist(Pesos, Suma),
    length(Pesos, Cantidad),

    Cantidad > 0,
    Promedio is Suma / Cantidad.

mayorPromedio(Salud, Promedio) :-
    pollo(_, _, Salud),
    promedioPeso(Salud, Promedio),

    forall(
        promedioPeso(OtraSalud, OtroPromedio),
        Promedio >= OtroPromedio
    ).
```

Analizando la inversibilidad de mis predicos puedo decir lo siguiente

1. El primer predicado promedioPeso, NO es completamente inversible, pero si es parcialemente inversible, es decir, cuando la salud esta instanciada pero el promedio no.

Pero en caso de instanciar el promedio y no la salud, no va a ser posible ya que para el promedio usamos IS/2 y este no puede deducir valores hacia atras

2. Este segundo predicado es tambien parcialmente inversible, si esta instanciada la salud y no el promedio.

Pero, lo mismo que ocurre anteriormente, el caso contrario donde la salud es el parametro libre no es inversible. Porque Depende directamente de la salida de promedioPeso(Salud, Promedio), la cual, como vimos arriba, no puede generar el valor de Promedio a partir de la nada; necesita calcularlo.