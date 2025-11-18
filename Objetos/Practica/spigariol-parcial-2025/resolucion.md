# CODIGO INICIAL

```wollok
class Cliente {
    var property publicidades = []

    method costoClinente(publicidad) = publicidades.sum(publicidad )
}

class PublicidadNoTradicional {
    var property medios = []
    var property estaActiva = true

    method costo() {
        if (estaActiva) return medios.sum(medio => medio.tarifa())
        else return 0
    }
}

class PublicidadTradicional {
    var property plan
    var property estaActiva = true

    method costo(cliente) {
        const cantPublicidadesActivas =
            cliente.publicidades().count(publicidad => publicidad.estaActiva())

        if (not estaActiva) return 0

        if (plan == "platino") {
            if (cantPublicidadesActivas > 3) return 800
            else return 1000
        }

        if (plan == "estandar") return 1000

        if (plan == "gold") return 1200 / cantPublicidadesActivas
    }
}
```

## RESPUESTAS

**1 A) MI RTA: VERDADERO,** Si se podria considerar que hay logica repetida, aparte de la variabe esta activa, en el metodo costo hacen lo mismo pero de formas diferentes
La publicidad tradicional chequea si no esta activa y retorna 0. En cambio la no tradicional chequea si esta activa else 0. Esto se podria abstraer a una super clase publicidad
La cual aparte de contener a la variable esta ACTIVA, va a tener al metodo costo con su chequeo de if not esta activa, luego cada clase lo sobreescribira sumandole logica a este chequeo inicial

**Gemini**: Hay una violación del principio "Don't Repeat Yourself" (DRY). La lógica para determinar si una publicidad tiene costo (si estaActiva es true o false) está repetida en el método costo() de PublicidadNoTradicional y en el método costo(cliente) de PublicidadTradicional. Esto podría resolverse con Herencia, subiendo la responsabilidad de estaActiva y la lógica de costo cero a una superclase común, dejando que las subclases se ocupen únicamente de calcular el costo cuando sí están activas.

> Conceptos: Principio DRY (Don't Repeat Yourself) / Herencia

**B) VERDADERO,** En la clase PublicidadTradicional, el método costo(cliente) tiene la responsabilidad de consultar al cliente sobre la cantidad de publicidades activas (líneas 1 y 2 dentro del método). Esto genera un acoplamiento indebido, ya que la Publicidad Tradicional sabe demasiado sobre la estructura interna de su Cliente.

La publicidad debería poder calcular su costo por sí misma o, en todo caso, recibir los datos necesarios (como la cantidad de activas) como argumento. Esto viola el principio de Encapsulamiento, La responsabilidad de calcular el costo debería recaer, en la medida de lo posible, en el objeto que está recibiendo el mensaje (PublicidadTradicional).

> Conceptos:  Encapsulamiento

**C) FALSO,** Aunque ambas publicidades definen el mensaje costo, no respetan el principio de Polimorfismo por Interfaz porque la firma de los métodos es diferente.
Un método costoTotal en Cliente querría iterar sobre su lista de publicidades y enviar a cada una el mensaje costo. Al enviar publicidad.costo() fallaría para las tradicionales, y al enviar publicidad.costo(self) fallaría para las no tradicionales. Por lo tanto, no se podría resolver fácilmente debido a la falta de una interfaz común 

> Conceptos: Polimorfismo 

**D) Falso,** la dificultad de agregar un nuevo plan de costo (como "Diamante") no está directamente relacionada con la falta de una superclase en común para ambos tipos de publicidad (Tradicional y NoTradicional). El problema está dentro de la clase PublicidadTradicional misma, donde se están usando múltiples if/else para discriminar el plan
Ya que agregar un plan requiere modificar modificar la clase PublicidadTradicional.

Se podria mejorar con composicion, haciendo que la variable plan de la clase referencia a objetos que sean los diferentes planes

> Conceptos: Principio Abierto/Cerrado y Composicion

### PRINCIPIO ABIERTO CERRADO
Las entidades de software (clases, módulos, funciones, etc.) deben estar abiertas para su extensión, pero cerradas para su modificación

Para incorporar un nuevo comportamiento o un nuevo requisito, debemos ser capaces de extender el código existente PERO una vez que una clase ha sido desarrollada y probada, no deberíamos tener que modificar su código fuente para introducir nuevo comportamiento.

Si cada vez que agregamos algo nuevo tenemos que tocar el código de las clases existentes, corremos el riesgo de introducir errores (regresiones) en funcionalidades que ya estaban probadas y funcionando.

# 2 Correcion: (Mi solucion)

```wollok
class Cliente {
    var property publicidades = []

    method publicidadesActivas() = publicidades.count{publicidad => publicidad.estaActiva()}


    method costoTotal() = publicidades.sum(publicidad => publicidad.costo(self))

  
}


class Publicidad {
    var property estaActiva = true

    method costo(cliente){
        if (not estaActiva) return 0
    }

    method estaActiva() = estaActiva
}

class PublicidadNoTradicional inherits Publicidad {
    var property medios = []

    override method costo(cliente) {
        super() 
        return medios.sum(medio => medio.tarifa())
    }
}

class PublicidadTradicional inherits Publicidad {
    var property plan

    override method costo(cliente) {
        super()
        
        const cantPublicidadesActivas = cliente.publicidadesActivas()
        
        plan.costoSegunPlan(cantPublicidadesActivas)
    }
}

object estandar {
    method costoSegunPLan(cantidad) = 1000
}

object gold {
    method costoSegunPLan(cantidad) = 1200/cantidad
}

object platino {
    method costoSegunPLan(cantidad) {
         if (cantidad > 3) return 800
        else return 1000
    }

}
```

### Gemini dice que deberia usar algo como esto

```wollok
    method costoTotalDos() {
        const cantActivas = self.publicidadesActivas()
        return publicidades.sum { publicidad => publicidad.costo(cantActivas) }
    }
```

Y forzar a que el cliente ya mande la cantidad de activas, lo cual me parece razonable por eso lo agregue aca

# 3 Agregar funcionalidades:
Voy a seguir con mi correcion

```wollok

object agenciaDePublicidad {
    var property clientes = []

    method clientesActivos() = clientes.filter{cliente => cliente.publicidadesActivas() > 0}
    
}

class Cliente {
    var property publicidades = []

    method publicidadesActivas() = publicidades.count{publicidad => publicidad.estaActiva()}


    method costoTotal() = publicidades.sum(publicidad => publicidad.costo(self))

    method agregarPublicidad(publicidad) {
        if (not self.puedeAcpetar(publicidad)) {
            self.error("No se puede agregar: El cliente no tiene activas y la nueva es inactiva.")
        }
        else publicidades.add(publicidad)
    }
    
    method puedeAceptar(publicidad) = self.publicidadesActivas() > 0 or publicidad.estaActiva()
    
}


class Publicidad {
    var property estaActiva = true

    method costo(cliente){
        if (not estaActiva) return 0
    }

    method estaActiva() = estaActiva
}

class PublicidadNoTradicional inherits Publicidad {
    var property medios = []

    override method costo(cliente) {
        super() 
        return medios.sum(medio => medio.tarifa())
    }
}

class PublicidadTradicional inherits Publicidad {
    var property plan

    override method costo(cliente) {
        super()
        
        const cantPublicidadesActivas = cliente.publicidadesActivas()
        
        plan.costoSegunPlan(cantPublicidadesActivas)
    }
}

object estandar {
    method costoSegunPLan(cantidad) = 1000
}

object gold {
    method costoSegunPLan(cantidad) = 1200/cantidad
}

object platino {
    method costoSegunPLan(cantidad) {
         if (cantidad > 3) return 800
        else return 1000
    }

}
```
