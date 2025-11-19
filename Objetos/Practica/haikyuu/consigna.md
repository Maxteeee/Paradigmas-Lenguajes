Queremos modelar un partido de voley entre dos equipos. Cada equipo tiene 6 jugadores en la cancha, los cuales se ubican de una forma específica para cubrir las 6 posiciones del campo de juego, y durante el partido irán rotando sus posiciones como se explicará más adelante.

De cada partido nos interesa conocer el estado actual, que incluye el marcador (cuántos puntos anotó cada equipo), y sólo mientras el partido está en juego, cuál es el equipo que está sacando en ese momento. Los partidos se juegan a 25 puntos, con una diferencia mínima de dos puntos, por lo que se podría extender más que eso de ser necesario hasta que se defina un equipo vencedor.

A lo largo del partido, nos interesará registrar que un equipo anotó un punto, para lo cual se deberán tener en cuenta las siguientes consideraciones:
Al iniciar el partido cada equipo tiene 0 puntos y se juega un primer punto sólo por el saque (o sea, para definir cuál será el equipo que sacará una vez iniciado oficialmente el juego). No afecta al marcador que un equipo anote ese primer punto.
Si el equipo que está sacando es el mismo que anotó el punto, solamente debe incrementarse la cantidad de puntos que tiene ese equipo para el partido en curso.
Si el equipo que anotó no es el que está sacando (es el equipo que recibe), además de ganar un punto, el equipo que anotó debe rotar y pasa a ser el equipo que está sacando actualmente en el partido en curso.
Independientemente de quién esté sacando, el partido termina cuando un equipo anota 25 puntos, siempre y cuando haya 2 puntos de diferencia para poder ganar. Por lo tanto, si el partido iba 24 a 24, tendrán que seguir jugando hasta que se consiga esa diferencia de puntaje, por ejemplo 28 a 26. Cuando se cumpla la condición de puntaje para dar por finalizado el partido.
Una vez que un equipo se consagra ganador del partido, ya no debe ser posible anotar más puntos, ni hay un equipo que esté sacando (ya que dicha información sólo tiene sentido mientras el partido se está jugando).

Rotación 

Cuando los jugadores deben rotar al momento de cambiar el servicio (o sea, cuál es el equipo que está sacando en el partido), el nuevo equipo que saca rotará un lugar en el sentido de las agujas del reloj. El objetivo de esto es rotar a todos los jugadores en la posición de servicio a lo largo del partido (numerada como la posición 1).

Nos interesa representar 2 tipos de posiciones diferentes:
Delantero: son las 3 posiciones que se encuentran cerca de la red (numeradas como 2, 3 y 4). Los jugadores que ocupan estas posiciones se encuentran ejerciendo un rol ofensivo y pueden rematar (que es un ataque fuerte hacia el otro lado de la red, apuntando al piso de la cancha del equipo contrario).
Zaguero: son las 3 posiciones que se encuentran lejos de la red (numeradas como 1, 6 y 5). Los jugadores que ocupan estas posiciones están defendiendo, no pueden rematar.

A esas posiciones bien conocidas además de numerarlas se las denomina de una forma particular para identificarlas fácilmente, y por el sentido horario de la rotación sabemos que:
zaguero derecho: la siguiente posición es la 6
delantero derecho: la siguiente posición es la 1
delantero centro: la siguiente posición es la 2
delantero izquierdo: la siguiente posición es la 3
zaguero izquierdo: la siguiente posición es la 4
zaguero centro: la siguiente posición es la 5

Más allá de lo anterior, que nos indica cuál es la mecánica del juego, obviamente nos interesan ciertas características de los jugadores de cada equipo. Una de las más relevantes es la estatura de cada jugador, ya que si bien la altura no lo es todo, ciertamente les brinda una ventaja considerable cuando les toca estar como delanteros. También conocemos el nivel de precisión y de potencia que tiene cada jugador.

Además sabemos que hay distintas técnicas de saque que un jugador puede usar, las cuales pueden ser peligrosas para el equipo contrario por su dificultad para recibirlo. Por cada jugador nos interesa saber qué saques usa y si logró dominarlo, que se cumple cuando la efectividad que tiene con dicho saque es mayor al 80%. Un saque de un jugador se considera peligroso cuando la técnica en sí es peligrosa y logró dominarla.

Saque de abajo: es ideal para principiantes, enfocándose en la precisión más que en la potencia. La efectividad con la que un jugador puede realizarlo equivale a su precisión multiplicada por 5. Esta técnica no es peligrosa ya que suele ser fácil de recibir.
Saque de arriba: 
De Tenis: este saque se perfecciona con potencia y precisión, por lo que la efectividad se calcula como la precisión del jugador / 2 + la potencia, todo eso multiplicado por 3. Sólo es peligroso si la potencia del jugador es mayor al 10.
En Salto: combina altura y potencia, generando saques rápidos y muy difíciles de recibir, por lo que es siempre peligrosa. La efectividad de este tipo de saque deberá indicarse para cada jugador, porque requiere mucha práctica.
Requerimientos a resolver:

Conocer el promedio de altura de los jugadores de un equipo.
Saber si un jugador tiene algún saque peligroso.
Saber si un jugador puede rematar, teniendo en cuenta la posición en la que se encuentra. Además quienes miden menos de 1.60 m de altura no pueden rematar independientemente de en dónde se encuentren. 
Hacer que un equipo rote, que implica que cada jugador cambie su posición en la cancha por la posición siguiente.
Saber, para un partido, qué equipo tiene ventaja. Si alguno tiene más puntos que el otro, ese equipo tiene ventaja, de lo contrario para un partido en curso será el equipo que esté sacando si el jugador en la posición 1 tiene algún saque peligroso, y sino por defecto será el que tenga mayor altura promedio.
Para que se pueda jugar un partido queremos que un equipo pueda anotar un punto para el partido en cuestión, teniendo en cuenta todo lo que se mencionó inicialmente relativo al estado del partido (tanto si es por el saque o si el mismo está en curso, recordando que no debería poder hacerse luego de terminar el partido).
