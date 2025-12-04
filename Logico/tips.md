# Existe vs Todos

- forall: Se usa para asegurar que todos cumplan algo.
- Prolog estándar: Se usa para buscar si existe al menos uno que cumpla algo. Es decir, que prolog recorria con todos los casos posibles

# Predicado generador

Siempre antes de un NOT, FORALL, o FINDALL ponemos un predicado generador para que sea inversible, sino pasaria algo asi

Ej con mi parcial
1. Prolog entra al not.
2. Llama a bienCuidado(Alguien).
3. Como bienCuidado es inversible, va a buscar un paciente que esté bien cuidado. Digamos que encuentra a ali.
4. Como encontró a alguien (true), el not dice: "Ah, encontré uno que sí cumple, entonces el not es FALSO".
5. Resultado final: false.
6. Conclusión: No te devolvió ningún paciente complicado. Te dijo "Falso" porque existe alguien que no está complicado.

# Forall

A la izquierda del forall va el generador, el universo de existentes 

Ej: Quienes tienen que estar de acuerdo? Los caballos ganadores

a la derecha va la prueba, la condicion

Ej: Que tienen que hacer? Preferir al jockey


