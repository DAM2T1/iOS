//
//  ButtonAnswer.swift
//  PickerViewPractice
//
//  Created by Raiksih on 21/11/17.
//  Copyright © 2017 Raiksih. All rights reserved.
//

import UIKit

class ButtonAnswer: UIButton {

    
    var answer : Respuesta? = nil
    
    override init(frame : CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
    

    func setAnswer(answer: Respuesta){
        self.answer = answer
    }
}
