class Pokemon {
    var vidaMaxima
    var movimientos = []

    method grositud() {
        return vidaMaxima * movimientos.sum{movimiento => movimiento.poder()}
    }

}

class MovimientosCurativos {
    var curacion

    method poder() {
        return curacion
    }
}

class MovimientosDaninos {
    var daño 

    method poder() {
        return daño * 2
    }
}

class movimientosEspeciales {


    method poder() {
      
    }
}