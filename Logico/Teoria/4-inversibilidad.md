# ¿Que es la inversibilidad?

En prolog, un predicado es inversible si funciona en todas las direcciones. Es decir podes usarlo para:

- Preguntar Si algo cumple una condicion (preguntando especificamente por alguen)
- Preguntar que cumple una condicion((pongo nomas el nombre de la variable, es decir, una variable libre en 1 arguemtno o en todos sus argumentos) y es capaz de generar a las personas que cumplen esa condicion

## ¿ Como lograr la inversibilidad?

Usá variables y no hagas suposiciones de instanciación: Evitá hacer que un argumento siempre tenga que ser una constante o que una variable tenga que estar instanciada para que funcione.
Evitar cortes (!) y negaciones problemáticas que limiten cómo se puede usar el predicado.
Escribí reglas que funcionen para todos los casos posibles de variables y valores.

### Ejemplo NO inversible

tengo una base de conocimiento de diferentes personas y lenguajes de programacion que saben

```prolog
programaEn(mateo, go).
programaEn(mateo, java).
programaEn(vicky, go).
programaEn(maru, c++).
programaEn(_, c)
```

con programaEn(_, c) le estamos diciendo “Existe alguien, pero no me importa quién, que programa en C”. No define a ningún individuo concreto.

Entonces si preguntamos

```prolog
?- programaEn(Persona, C). % True
```

no nos dice QUIENES son los que programa en C, solo da True, significa que este predicado no es inversible para la PERSONA porque prolog no nos puede decir una persona concreta que cumpla con que programa en C

**Esto se puede arreglar agergando predicados conocidos como GENERADORES**

```prolog
ProgramaEn(Persona, C) :=
 	persona(Persona).

persona(vicky). %generador
persona(mateo). %generador
persona(maru). %generador
```

# Casos de NO inversibilidad

- Hechos con variables
- Comparacion por distinto
- > < >= <=
- not/1
- is/2
- forall/2
