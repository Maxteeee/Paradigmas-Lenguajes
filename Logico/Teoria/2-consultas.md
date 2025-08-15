### Base del conocimiento

```prolog
humano(socrates).

mortal(Alguien) :=
    humano (Alguien).

mortal(maxte).
```

### Consultas al motor

1. Es cierto que maxte es mortal?

```prolog
?- mortal(maxte).
true.
```

esta es una duda INDIVIDUAL, pregunto por alguien en particular

2. Existe alguien que sea mortal?
quienes son mortales?

```prolog
?- mortal(_).
true % Encontro a alguien mortal

?- mortal(Quien) % Quien nombre de variable
Quien = socrates ;
Quien = maxte. 
```
Estas son dudas EXISTENCIALES, al preguntar TODA la gente/en general es existencial
