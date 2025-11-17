class Empleado {
    var salud
    var habilidades = []
    var property puesto 

    method estaIncapacitado() = salud < self.saludCritica()

    method saludCritica() = puesto.saludCritica()

    method puedeUsarHabilidad(habilidad) {
        not self.estaIncapacitado() && self.poseeHabilidad(habilidad)
    }
    
    method poseeHabilidad(habilidad) = habilidades.contains(habilidad) 

    method recibirDanio(cantidad) {
        salud = salud - cantidad
    }

    method completarMision(mision) {
      
    }
}

class Jefe inherits Empleado {
    var subordinados = []

    override method poseeHabilidad(habilidad) = super(habilidad) or self.habilidadSubordinado(habilidad)

    method habilidadSubordinado(habilidad) = subordinados.any{subordinado => subordinado.puedeUsarHabilidad(habilidad)}

}

class PuestoEspia {
    method saludCritica() = 15
}


class PuestoOficinista {
    var estrellas = 0

    method ganarEstrella() {
        estrellas = estrellas + 1
    }

    method saludCritica() = 40 - 5 * estrellas
}

class Mision {
    var habilidadesRequeridas = []
    var peligrosidad

    method serCumplicaPor(asignado) {
        self.validarHabilidades(asignado)
        asignado.recibirDanio(peligrosidad) // Error grave preguntarme con If si es emplado o equipo.
        asignado.completarMision(self)
         
    }

    method validarHabilidades(asignado) {
        if (not self.reuneHabilidadesRequeridas(asignado)) {
            self.error("La mision no se puede cumplor")
        }
    }

    method reuneHabilidadesRequeridas(asignado) = 
        habilidadesRequeridas.all{habilidad => asignado.puedeUsarHabilidad(habilidad)}
    
}

