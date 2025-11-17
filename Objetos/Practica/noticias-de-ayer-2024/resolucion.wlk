class NoticiaGenerica{
    var fechaPublicacion 
    var autor
    var importancia 
    var titulo
    var desarrollo

  
}



class NoticiaComun inherits NoticiaGenerica{
    var link  = []
}

class Chivo inherits NoticiaGenerica{
    var plata 
    var articulo 

}

class Reportaje inherits NoticiaGenerica{
    var entrevistado
}

class Cobertura inherits NoticiaGenerica{
   var serieDeNoticias  = []
}

