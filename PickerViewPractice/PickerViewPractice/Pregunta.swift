//
//  Pregunta.swift
//  PickerViewPractice
//
//  Created by Raiksih on 6/11/17.
//  Copyright © 2017 Raiksih. All rights reserved.
//

import UIKit

class Pregunta: NSObject {
    var descripccion :String = "";
    var respuestas = [Respuesta]();
    
    
    init(descripccion: String) {
        self.descripccion = descripccion
    }
    
    init(descripccion: String, respuestas: Respuesta) {
        self.descripccion = descripccion
        self.respuestas = [respuestas] //this works?
    }
    
    func addRespuesta (respuesta: Respuesta){
        respuestas.append(respuesta)
    }
    
    func shuffle(){
        for i in 0...respuestas.count-1{
            var aux2 : Respuesta;
            let aux = Int(arc4random_uniform(UInt32(respuestas.count)))
            aux2 = respuestas[i]
            respuestas[i] = respuestas[aux]
            respuestas[aux] = aux2
        }
    }

}
