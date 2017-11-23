//
//  Tema.swift
//  PickerViewPractice
//
//  Created by Raiksih on 6/11/17.
//  Copyright © 2017 Raiksih. All rights reserved.
//

import UIKit

class Tema {
    var nombre :String;
    var preguntas = [Pregunta]();
    
    init(nombre: String) {
        self.nombre = nombre
    }
    
    func addPregunta(pregunta: Pregunta){
        preguntas.append(pregunta)
    }
    

}
