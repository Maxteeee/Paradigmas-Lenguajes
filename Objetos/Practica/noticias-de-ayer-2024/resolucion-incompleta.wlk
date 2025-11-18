class Fecha {
    var año
    var mes
    var dia

    method diaPublicacion = dia
}


class NoticiaGenerica {
    var property fechaPublicacion //deberia ser CONST
    var property autor
    var importancia 
    var titulo
    var desarrollo

    method esCopada() = importancia >= 8 && (hoy - fechaPublicacion.diaPublicacion) < 3 //Implementar el hoy

    method contienePalabra(palabra) = desarrollo.contains(palabra)

    method tamañoDesarrollo = desarrollo.length
}

class NoticiaComun inherits NoticiaGenerica{
    var links  = []

    override method esCopada() = super() && links.size >= 2
}

class Chivo inherits NoticiaGenerica{
    var plata 
    var producto 

    override method esCopada() = super() && plata > 2000000


}

class Reportaje inherits NoticiaGenerica{
    var entrevistado

    override method esCopada() = super() && entrevistado.length % 2 != 0 

    override method contieneLaPalabra(palabra) = super(palabra) && desarrollo.contains(entrevistado)

}

class Cobertura inherits NoticiaGenerica{
   var serieDeNoticias  = []

    override method esCopada() = super() && self.todasNoticiasCopadas()

    method todasNoticiasCopadas() = serieDeNoticias.all({noticia => noticia.esCopada()})
}

class Periodistas {

    var fechaIngreso
    var property preferencia
    var limiteToleranciaPorDia = 0

    method quierePublicar(noticia) = preferencia.leGusta(noticia)

    method publicar(noticia) = self.limitePorDia(noticia) && noticia.estaBienEscrita
    
}

class PreferenciaCopada {
    method leGusta(noticia) = noticia.esCopada()
}

class PreferenciaSensacionalista {
    var palabras = [espectacular, increible, grandioso]
    var persona = "Dibu Martinez"

    method leGusta(noticia) = self.estaLaPalabraEn(noticia)

    method estaLaPalabraEn(noticia) {
        palabras.any({palabra => noticia.contienePalabra(palabra)}) // MAL TAMBIEN PORQUE NO EVALUA NUNCA QUE ESTE EL DIBU COMO PERSONA
    }

}

class Vagos {
    method leGusta(noticia) = self.noticiaCorta(noticia) or // TODO: IMPLEMENTAR QUE SEA SOLO CHIVO

    method noticiaCorta(noticia) = noticia.tamañoDesarrollo < 100
}

object JoseDeZer inherits Periodistas {
    override method quierePublicar(noticia) = noticia.titulo //  TODO: IMPLEMENTAR QUE EMPIECE CON T
}