```prolog
humano(socrates).

mortal(Alguien) :=
    humano (Alguien).

mortal(maxte).
```
Tanto humano como mortal son predicados:
- humano/1
- mortal/1

Por otra parte

> mortal(maxte).

Es un HECHO.

Es una afirmacion incondicoinal y es una difinicion por extension, es decir, decimos/definimos cada uno de los hechos que son verdaderos

> mortal(Alguien) := humano (Alguien).

Es una REGLA.

Es una implicacion (si -> entonces) y la definicion es por compresion