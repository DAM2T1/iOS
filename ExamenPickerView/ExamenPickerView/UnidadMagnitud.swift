//
//  UnidadMagnitud.swift
//  ExamenPickerView
//
//  Created by Raiksih on 4/12/17.
//  Copyright © 2017 Raiksih. All rights reserved.
//

import UIKit

class UnidadMagnitud{
    
    var nombre: String
    var imagen: UIImage
    
    init(nombre: String, nombreImage : String) {
        self.nombre = nombre
        imagen = UIImage(named: nombreImage)!
        
    }
    
    init(){
        nombre = ""
        imagen = UIImage()
    }

}
