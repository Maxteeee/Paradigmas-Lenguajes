Aca voy a escribir explicaciones de diseño 

# 1 Saques Peligrosos

La consigna dice: "Se cumple cuando la efectividad que tiene con dicho saque es mayor al 80%".

- El Saque ya sabe calcular la efectividad.
- El Saque sabe que el "número mágico" para aprobar es 80.

Toda la lógica de evaluación del saque está encapsulada en la clase Saque. Si mañana la regla cambia a "Los saques de salto se dominan con más de 90, y los de abajo con 50", solo tocas la jerarquía de Saque. El Jugador no se entera.