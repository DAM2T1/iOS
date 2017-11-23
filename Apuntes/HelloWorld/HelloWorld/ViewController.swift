//
//  ViewController.swift
//  HelloWorld
//
//  Created by Raiksih on 22/9/17.
//  Copyright © 2017 Raiksih. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var texto: UILabel!
    
    @IBAction func cambiarTexto(_ sender: Any) {
            //Cambiamos el texto
        texto.text = "Hola caracola!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // texto.text = "hola caracola"
    }

    @IBOutlet weak var campoSaludo: UILabel!
    @IBOutlet weak var userInput: UITextField!
    
    @IBAction func saludar(_ sender: Any) {
        if(userInput.text == ""){
            campoSaludo.text = "Escribeme tu nombre"
        }else{
            campoSaludo.text = userInput.text;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

