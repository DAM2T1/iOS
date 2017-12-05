//
//  ViewController.swift
//  ExamenPickerView
//
//  Created by Raiksih on 4/12/17.
//  Copyright © 2017 Raiksih. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {
    
    var uniadadesMaginutd = [UnidadMagnitud]()
    // 0 = metro
    // 1 = litros
    // 2 = kilogramos
    
    var rowPicker1 : Int = 0
    var rowPicker2 : Int = 0
    
    var unidades = [Unidad]()
    
    @IBOutlet weak var userInput: UITextField!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var labelDisplay: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func newInput(_ sender: UITextField) {
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inicializarUnidades()
        userInput.text = "1"
        picker.delegate = self
        picker.dataSource = self
    }
    
    func inicializarUnidades(){
        
        var aux = UnidadMagnitud(nombre: "metro", nombreImage: "metro.jpg")
        uniadadesMaginutd.append(aux)
        
        aux = UnidadMagnitud(nombre: "litro", nombreImage: "agua.jpg")
        uniadadesMaginutd.append(aux)
        
        aux = UnidadMagnitud(nombre: "kilogramo", nombreImage: "balanza.png")
        uniadadesMaginutd.append(aux)
        
       var p = Unidad(name: "pies", factorConversion: 3.28, unidad: uniadadesMaginutd[0])
        unidades.append(p)
        
        p = Unidad(name: "yardas", factorConversion: 1.09, unidad: uniadadesMaginutd[0])
        unidades.append(p)
            
        p = Unidad(name: "pulgadas", factorConversion: 39.37, unidad: uniadadesMaginutd[0])
        unidades.append(p)
        
        p = Unidad(name: "pintas", factorConversion: 2.11, unidad: uniadadesMaginutd[1])
        unidades.append(p)
        
        p = Unidad(name: "cc", factorConversion: 1000, unidad: uniadadesMaginutd[1])
        unidades.append(p)
        
        p = Unidad(name: "libras", factorConversion: 2.20, unidad: uniadadesMaginutd[2])
        unidades.append(p)
        
        p = Unidad(name: "onzas", factorConversion: 35.27, unidad: uniadadesMaginutd[2])
        unidades.append(p)
    }
    
	//Funcion que compara los pickers y si el nombre de la UnidadMagnitud de la unidad en question es la misma que esta seleccionada
	//en el primer picker (el de las uniadadesMaginutd) hace la conversion y sino pone error en texto e imagen
    func checkValueIsParsableAndWriteTheDisplayInput(row : Int){
        if(unidades[row].unidad.nombre != uniadadesMaginutd[rowPicker1].nombre){
            image.image = UIImage(named: "errorstop-3.png")
    
            labelDisplay.text = "Error!!"
        }else{
            image.image = uniadadesMaginutd[rowPicker1].imagen
            var p = Double(userInput.text!)
    
            var resultado = p! * unidades[rowPicker2].factorConversion
            labelDisplay.text = String("\(uniadadesMaginutd[rowPicker1].nombre) son \(resultado)")
    
        }
    }
    

    //Set the number o picker views
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(component == 1){
		//Cambio aqui, esto me falto 5 min de clase, me fallo el cambio de string a double y mostrarlo
            rowPicker2 = row
        }else{
            rowPicker1 = row

        }
		checkValueIsParsableAndWriteTheDisplayInput(row: row)
    }
    
    
    //Set the String for the picker view row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0){
            return uniadadesMaginutd[row].nombre
        }else{
            return unidades[row].name
        }
    }
    
    //Set the number of rows of the pickers
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(component == 0){
		//Aqui puse un 3 directamente porque en un inicio no metia los objetos de UnidadMagnitud en un array
		//luego lo cambie y asi es escalable
            return uniadadesMaginutd.count
        }else{
            return unidades.count
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	
}

