# TEMAS 
LAMBDAS

# Lambdas

En haskell una expresion lambda se escribe asi

```haskell
\x -> x * x
```

Y también podemos definirla como:

```haskell
cuadrado = \x -> x * x
```

La contrabarra (\) es el símbolo que remite a la letra griega lambda λ que como habrán notado es el ícono de la programación funcional. Luego de los parámetros que se separan por espacios, la flecha -> termina de definir el cuerpo de la función.

Se evalúa de esta manera:

```haskell
> (\x -> x * x) 2
4

Otro ejemplo:
> (\x y -> x + y) 2 3
5
```

Las expresiones lambdas permiten definir funciones anónimas que se usan en un contexto limitado (el de la misma función que estoy definiendo). Al no tener nombre, es una variante menos expresiva que una función cuadrado o suma, que además se pueden utilizar en diferentes contextos. No obstante son una herramienta muy útil,

# Uso efectivo de LAMBDAS

## Lambdas con filter y map

Las lambdas son útiles cuando queremos trabajar con funciones de orden superior y no tenemos necesidad de reutilizar una expresión en otro contexto:

```haskell
 filter (\cliente -> edad cliente > 40) clientes
```

en muchos casos podemos resolver el mismo problema con composición y aplicación parcial:

```haskell
filter ((> 40) . edad) clientes
```

Y ciertamente es la opción que vamos a preferir en la cursada, ya que no solo es más conciso el código sino que demuestra más entendimiento de los conceptos del paradigma. 

## Consecuencias de las lambdas

Algo importante a tener en cuenta es que, si no le damos un nombre a nuestras funciones, podríamos perder abstracciones útiles que podrían luego ser utilizadas en otros puntos de nuestro programa, por lo tanto es importante ser criteriosos respecto de nombrar o no una función.

Por lo general, si tengo una forma sencilla de nombrar una determinada lógica que forma parte de una función más grande, lo más probable es que no quiera definir ese pedacito de lógica usando una lambda, sino con una función que se llame como la idea que tenemos en la cabeza. Si no hay un nombre claro asociado a ese pedacito de lógica, posiblemente no sea un concepto del dominio que valga la pena modelar como algo aparte. 
