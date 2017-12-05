//
//  Unidad.swift
//  ExamenPickerView
//
//  Created by Raiksih on 4/12/17.
//  Copyright © 2017 Raiksih. All rights reserved.
//

import UIKit

class Unidad {
    
    var name : String
    var factorConversion: Double
    var unidad : UnidadMagnitud
    
    init(name : String, factorConversion : Double, unidad: UnidadMagnitud) {
        
        self.factorConversion = factorConversion
        self.unidad = unidad
        self.name = name
    }

}
