// pokemon.grositud()
// movimiento.usarEntre(usuario, contricante)
// Segun GPT la condicion que provoca deberia estar en manos de las condiciones, la profe dijo que es valida too

class Pokemon {
    var vida
    const vidaMaxima
    var movimientos = []
    var property condicion = normal //null es la nada misma pero lo representamos con un nombre

    method grositud() {
        return vidaMaxima * movimientos.sum{movimiento => movimiento.poder()}
    }

    method curarse(cantidadCuracion){
        vida = (vida + cantidadCuracion).min(vidaMaxima)
    }

    method recibirDanio(cantidadDanio){
        vida = 0.max(vida - cantidadDanio)
    }
    
    method lucharContra(contrincante){
        self.estaVivo()
        contrinante.estaVivo()

        const movimientoAUsar = self.movimientoDisponible()

        condicion.intentaMoverse(self)

        movimientoAUsar.usarEntre(self, contrincante)
    }
    
    method movimientoDisponible() {
        return movimientos.find{movimiento => movimiento.estaDisponible}, 
        { throw new NoPuedeMoverseException(message = "El pokemon no esta vivo")}
    }

    method estaVivo(){
        if(vida == 0){
            throw new NoPuedeMoverseException(message = "El pokemon no esta vivo")
        }
    }
}

//////// MOVIMIENTOS

class Movimiento {
    var usoLimite 

    method usarEntre(usuario, contrinante){ 
        if (! sels.estaDisponible())
            throw new MovimientoAgotadoException(message = "El movimiento no esta disponible")
        usoLimite -= !
        self.aplicarEfecto(usuario, contrincante) 
    }

    method estaDisponible() {
        return usoLimite > 0
    }

    method aplicarEfecto(usuario, contrinante)
}

class MovimientosCurativos inherits Movimiento {
    const cantidadCuracion

    method poder() {
        return curacion
    }

    override method aplicarEfecto(usuario, contrincante){
        usuario.curarse(cantidadCuracion)
    }
}

class MovimientosDaninos inherits Movimiento{
    const daño 

    method poder() {
        return daño * 2
    }

    override method aplicarEfecto(usuario, contrincante){
        contrincante.recibirDanio(daño)
    }
}

class movimientosEspeciales inherits Movimiento{
    const condicionQueProvoca

    method poder() {
        return condicionQueProvoca.poder()
    }

    override method aplicarEfecto(usuario, contrincante){
        contrincante.condicion(condicionQueProvoca)
    }
}

//////// CONDICIONES

object normal {
    method intentaMoverse(pokemon){}
}

//////// CONDICIONES ESPECIALES

class condicionEspecial {

    method intentaMoverse(pokemon){
        if (! lograMoverse())
            throw new NoPuedeMoverseException(message = "El pokemon no pudo moverse")
      }

    // Con esto solo tendria que redefinir estos metodos fallo y pudo en las subclases
    // Nada detalles para mejorar codigo 
    //
    //  method intentaMoverseDOS(pokemon) {
    //     if (! lograMoverse())
    //         self.falloAlIntentarMoverse(pokemon)
    //     else
    //         self.pudoMoverse(pokemon)
    //  }


      method lograMoverse() {
        return 0.randomUpTo(2).roundUp().even
      }

      method poder()
}

object paralisis inhertis condicionEspecial {
    method poder() = 30
}

object suenio inhertis condicionEspecial {
    method poder() = 50

    override method intentaMoverse(pokemon){
        super.(pokemon)
        pokemon.condicion = normal 
        // Tambien pokemon.normalizar() y que el se normalice pero es como el danger zone que
        // Como la condicion sabe que es una condicion, ya esta acoplada naturalmente asi que no pasa nada 
      }
}

// Class porque la cantidad de turnos varia

class confusion inhertis condicionEspecial {
    const turnosQueDura // no va a mutar>

    override  method poder() {
        return 40 * turnosQueDura
    }

    override intentaMoverse(pokemon) {
        self.pasoUnTurno(pokemon)
        if (super(pokemon) == false){
            pokemon.recibirDanio(20)
        }
    }

    // Metodo de la profe con manejo de errores y cosas re falopa
    // Seria la correcta porque el metodo super esta implementado con excepcion

    // override intentaMoverse(pokemon){
    //     try {
    //         super(pokemon)
    //     }
    //     catch e : NoPuedeMoverseException {
    //         throw new NoPuedeMoverseException(message = "El pokemon no pudo moverse y se hizo daño")
    //     } then always {
    //         self.pasoUnTurno(pokemon)
    //     }
    // }

    method pasoUnTurno(pokemon){
        if(turnosQueDura > 1 ){
            pokemon.condicion(new confusion(turnosQueDura = turnosQueDura - 1))
        } else {
          pokemon.condicion = normal
        }
    // Va creando instancias de confuncion con distitnos turnos hasta que se apunte a una
    // Que su turnos sea 0 (o negativo depende la implementacion pero se puede cambiar)

    // Si 2 objetos comparten una referencia (turnosquedura -=1), y mutás la referencia, los dos cambian.
    // Para eso creamos objetos inmutables
    }
}


/// EXCEPCIONES PARA EL MANEJO DE ERRORES

class MovimientoAgotadoException inhertis Exception ()
class NoPuedeMoverseException inhertis Exception ()