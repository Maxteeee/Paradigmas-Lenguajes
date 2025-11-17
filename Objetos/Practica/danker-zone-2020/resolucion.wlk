class Empleado {
    var salud
    var habilidades = #{} //set no admite repetidos

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

    method finalizarMision(mision) {
      if (self.estaVivo()) {
        self.completarMision(mision)
      } 
    }

    method estaVivo() = salud > 0 

    method completarMision(mision){
        puesto.completarMision(mision, self)
    }

    method aprenderHabilidad(habilidad){
        habilidades.add(habilidad)
    }
}

class Jefe inherits Empleado {
    var subordinados = []

    override method poseeHabilidad(habilidad) = super(habilidad) or self.habilidadSubordinado(habilidad)

    method habilidadSubordinado(habilidad) = subordinados.any{subordinado => subordinado.poseeHabilidad(habilidad)}

}

class PuestoEspia {
    method saludCritica() = 15

    method completarMision(mision, empleado){
        mision.enseniarHabilidades(empleado)
    }
}


class PuestoOficinista {
    var estrellas = 0

    method ganarEstrella() {
        estrellas = estrellas + 1
    }

    method saludCritica() = 40 - 5 * estrellas

    method completarMision(mision, empleado){
        estrellas = estrellas + 1  
        if (estrellas == 3) {
            empleado.puesto(PuestoEspia) 
            //Puedo hacer esto porque puesto en empleado es Property
            // No rompe el encapsulamiento del empleado porque estoy ya en un puesto y los puestos saben que son puestos}
            // Esta naturalmente acoplado desde antes por eso no pasa nada
            // Esto ya es una discucion de diseño, no del paradigma 
        } 
    }
}
        
class Mision {
    var habilidadesRequeridas = []
    var peligrosidad

    method serCumplidaPor(asignado) {
        self.validarHabilidades(asignado)
        asignado.recibirDanio(peligrosidad) // Error grave preguntarme con If si es emplado o equipo.
        asignado.finalizarMision(self)
    }

    method validarHabilidades(asignado) {
        if (not self.reuneHabilidadesRequeridas(asignado)) {
            self.error("La mision no se puede cumplor")
        }
    }

    method reuneHabilidadesRequeridas(asignado) = 
        habilidadesRequeridas.all{habilidad => asignado.puedeUsarHabilidad(habilidad)}
    
    method enseniarHabilidades(empleado){
        self.habilidadesQueNoPosee(empleado).forEach({habilidad => empleado.aprenderHabilidad(habilidad)})
    }

    method habilidadesQueNoPosee(empleado) = 
        habilidadesRequeridas.filter({habilidad => not empleado.poseeHabilidad(habilidad)})
}

class Equipos {
    var empleados = []

    method puedeUsarHabilidad(habilidad) = empleados.any({empleado => empleado.puedeUsarHabilidad(habilidad)})
    
    method recibirDanio(cantidad) {
        empleados.forEach({empleado => empleado.recibirDanio(cantidad / 3)})
    }
    
    method finalizarMision(mision){
        empleados.forEach({empleado => empleado.finalizarMision(mision)})
    }
}

