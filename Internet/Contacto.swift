//
//  Contacto.swift
//  Internet
//
//  Created by Tonny Gammer on 8/17/19.
//  Copyright © 2019 Blancovery. All rights reserved.
//

import Foundation

// Nombre del modelo es SINGULAR, primera letra MAYÚSCULA
class Contacto {
//    variables inician con minuscula
    var nombre : String
    var direccion : String?
    var telefono : String?
    var urlImagen : String
    
//    Inicializadores de VALORES (parecido a contructores)
//    Parámetros se deben llamar igual que variables con las que se relacionan
    init(usando nombre : String, urlImagen : String) {
//        variables NO opcionales de la clase se deben inicializar
        self.nombre = nombre
        self.urlImagen = urlImagen
    }
    
//    Forzosamente inicializar NO OPCIONALES
    init(usando nombre : String, direccion : String) {
        self.nombre = nombre
        self.direccion = direccion
        self.urlImagen = "default.png"
    }
    
    init(diccionario : NSDictionary) {
        nombre = ""
        urlImagen = ""
        
        if let nombre = diccionario.value(forKey: "nombre") as? String {
            self.nombre = nombre
        }
        if let urlImagen = diccionario.value(forKey: "urlImagen") as? String {
            self.urlImagen = urlImagen
        }
    }
}
