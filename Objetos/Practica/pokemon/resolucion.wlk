// TIP 1: El objeto que ejectua el metodo es quién tiene la responsabilidad
// Principio clave: “El mensaje va al que tiene la información necesaria para resolverlo”
// En esta consigna el movimiento sabe todas esas cosas, cuanto cura, cuanto daño hace
// no deberiamos tener un if gigante

// Esto hace que Pokémon tenga que saber:
// Que existe un método efecto
// Que se aplica así
// Que él es el “self” del efecto
// Que el movimiento tiene que gastar usos antes
// 
// Pokémon NO debe saber cómo se usan los movimientos.
// El Movimiento sabe usar el Movimiento.

class Pokemon {
    const vidaMaxima
    var movimientos = []

    method grositud() {
        return vidaMaxima * movimientos.sum{movimiento => movimiento.poder()}
    }

    method usarMovimiento(movimiento, contricante) {
        movimiento.gastar()
        contrincante.aplicarEfecto(movimiento)
    }

    method aplicarEfecto(movimiento){
        movmiento.efecto(self) //cada movimiento va a diseñar su efecto
    }
}

//////// MOVIMIENTOS

class Movimiento {
     const usoLimite

    method gastar() {
        return usoLimite -= 1
    }

}

class MovimientosCurativos inherits Movimiento {
    const curacion
   

    method poder() {
        return curacion
    }

}

class MovimientosDaninos inherits Movimiento {
    const daño 
    const usoLimite

    method poder() {
        return daño * 2
    }
}

class movimientosEspeciales inherits Movimiento {
    const condicionQueProvoca
    const usoLimite

    method poder() {
        return condicionQueProvoca.poder()
    }
}

//////// CONDICIONES

object paralisis {
    method poder() = 30
}

object suenio {
    method poder() = 50
}

// Opcional pero no buena ya que se pierde la idea del MOVIMIENTO ESPECIAL como tal
// Ademas asi separamos los movimientos de las condiciones que puedan generar
//
//class movimientosEspecialSuenio {
//    method poder() {
//        return 50
//    }
//}
//
//class movimientosEspecialParalisis {
//    method poder() {
//        return 30
//    }
//}