//
//  ViewController.swift
//  Internet
//
//  Created by Tonny on 8/17/19.
//  Copyright © 2019 Blancovery. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Kingfisher

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tvTablaContactos: UITableView!
    
    var contactos : [Contacto] = []
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 166
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Conexión a la URL del JSON debe ser HTTPS por regla de seguridad
        Alamofire.request("https://getapp.mawetecnologias.com/api/contactos", method: .get, parameters: nil, headers: nil).responseJSON { response in
            
//            si la respuesta es success trabajamos con ello
            switch response.result {
            case .success(let value): print(value)
//            creamos variable "respuesta" que será un NSDictionary (esto se usa con los objetos de JSON)
                if let respuesta = value as? NSDictionary {
//                    de existir, entonces creamos una variable "contactos" que será vinculado forKey con el nombre del array "contactos" del JSON y se castea a NSArray por ser arreglo
                    if let contactos = respuesta.value(forKey: "contactos") as? NSArray {
//                        recorremos el arreglo recién casteado "contactos" al número de contactos que tenga y llamamos esta variable "contacto" que simboliza el número a recorrer
                        for contacto in contactos {
//                            por cada "contacto" que recorra realizará lo siguiente:
//                          la variable "diccionarioContacto" va a tomar el valor de cada "contacto" que recorra y lo va a castear a NSDictionary ya que éste contacto es un objeto de JSON porque dentro de él tiene distintos elementos
                            if let diccionarioContacto = contacto as? NSDictionary {
//                                una vez llegando al objeto contacto con sus elementos, la variable "nuevo contacto" se va a conectar con el modelo Contacto.switf que es una clase donde inicializamos y mandamos nuestro NSDictionary en este caso diccionarioContacto que tiene los elementos que necesitamos para llenar cada contacto
                                let nuevoContacto = Contacto.init(diccionario: diccionarioContacto)
//                                llenamos el arreglo contactos del ViewController actual con cada "nuevoContacto"
                                self.contactos.append(nuevoContacto)
                            }
                        }
                        //  IMPORTANTE: al finalizar el arreglo DEBEMOS actualizar la tabla, si no, los elementos no aparecen
                        self.tvTablaContactos.reloadData()
                    }
                }
            case .failure(let value): print(value)
            }
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celdaContacto = tableView.dequeueReusableCell(withIdentifier: "cellContacto") as! CeldaContactoController
        
        celdaContacto.lblContacto.text = contactos[indexPath.row].nombre
        
        /* if let urlImage = contactos[indexPath.row].urlImagen as? String {
           Alamofire.request("https://getapp.mawetecnologias.com/" + urlImage).responseImage(completionHandler: { (response) in
                print(response)
                
           /* if let image = response.result.value {
                DispatchQueue.main.async {
                celdaContacto.imgContacto.image = image
                    }
                } */
                
            })
        
        } */
        
        let nombreImagen = contactos[indexPath.row].urlImagen
        
        let url = URL(string: "https://getapp.mawetecnologias.com/\(nombreImagen)")
        celdaContacto.imgContacto.kf.setImage(with: url)
        
        return celdaContacto
    }
    
}

