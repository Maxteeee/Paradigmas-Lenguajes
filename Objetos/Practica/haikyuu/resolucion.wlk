class Equipo {
    var jugadores = #{}

    method promedioAltura() {
        return jugadores.sum {jugador => jugador.altura() } / jugadores.size()
    }

}

class Jugador {
    var property altura
    var property precision
    var property potencia
    var property saqueJugador = []
    var property posicion
    

    method poseeSaquePeligroso(){
        return saqueJugador.any { saque => saque.esPeligroso(self) } 
    }

    method rotar() {
        posicion = posicion.siguientePosicion()
    }

}

class Saque {
    method esPeligroso(jugador) {
        self.saqueEsPeligroso() && self.esDominadoPor(jugador)
    }

     method esDominadoPor(jugador){
        return self.efectividadSaque(jugador) > 80
    }
    
    method efectividadSaque(jugador)
    method saqueEsPeligroso(jugador)

}
class SaqueDeAbajo inherits Saque {
    
    override method efectividadSaque(jugador){
        return jugador.precision() * 5
    }

    override method saqueEsPeligroso(jugador) = false
}


class SaqueDeTenis inherits Saque {
    
    override method efectividadSaque(jugador){
        return (jugador.precision() / 2 + jugador.potencia()) * 3
    }

    override method saqueEsPeligroso(jugador) = jugador.potencia() > 10
}

class SaqueEnSalto inherits Saque {
    var property efectividad 

    override method efectividadSaque(jugador) = efectividad

    override method saqueEsPeligroso(jugador) = true
}

class Posicion {
  const property posicion
  method puedeRematar()
  method siguientePosicion()
}

class Delantero inherits Posicion { // 2,3,4
  override method puedeRematar() = true
}
object delanteroIzquierdo inherits Delantero(posicion = 4) {
  override method siguientePosicion() = delanteroCentro
}
object delanteroCentro inherits Delantero(posicion = 3) {
  override method siguientePosicion() = delanteroDerecho
}
object delanteroDerecho inherits Delantero(posicion = 2) {
  override method siguientePosicion() = zagueroDerecho
}

class Zaguero inherits Posicion { // 1,6,5
  override method puedeRematar() = false
}
object zagueroIzquierdo inherits Zaguero(posicion = 5) { 
  override method siguientePosicion() = delanteroIzquierdo
}
object zagueroCentral inherits Zaguero(posicion = 6) {
  override method siguientePosicion() = zagueroIzquierdo
}
object zagueroDerecho inherits Zaguero(posicion = 1) {
  override method siguientePosicion() = zagueroCentral
}

class partido {
    var property equipos = []

    method tieneVentaja(equipo, otroEquipo){
        
    }
}