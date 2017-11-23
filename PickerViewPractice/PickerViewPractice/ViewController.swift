//
//  ViewController.swift
//  PickerViewPractice
//
//  Created by Raiksih on 6/11/17.
//  Copyright © 2017 Raiksih. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var temaCollection = [Tema]()

    
    @IBOutlet weak var pick: UIPickerView!
    @IBOutlet weak var buttonRespuesta1: ButtonAnswer!
    @IBOutlet weak var buttonRespuesta2: ButtonAnswer!
    @IBOutlet weak var buttonRespuesta3: ButtonAnswer!
    @IBOutlet weak var buttonRespuesta4: ButtonAnswer!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var buttonEscogerTema: UIButton!
    @IBOutlet weak var labelPuntuacion: UILabel!
    @IBOutlet weak var buttonSiguientePregunta: UIButton!
    
    var puntuacion : Int = 0
    var questionPositionTheme : Int = 0
    var buttonCollection = [ButtonAnswer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pick.dataSource = self
        pick.delegate = self
        buttonCollection = [buttonRespuesta1, buttonRespuesta2, buttonRespuesta3, buttonRespuesta4]
        initialTemas()
        initialQuestionsWithAnswers()
        hideButtons()
        labelPuntuacion.isHidden = true
        buttonSiguientePregunta.isHidden = true
        
    }
    
    @IBAction func selectTheme(_ sender: UIButton) {
        //Miramos el tema seleccionado
        if (buttonSiguientePregunta.title(for: .normal) == "Exit") {
            resetGame()
            return;
        }
        //mirar que juego no haya acabado
        
        var themeSelected = getSelectTheme()
        if(themeSelected.preguntas.count == 0){return;}
        prePlayGame(questionSelected:getRandomQuestion(tema: themeSelected))
        }
    
    
    func checkIfNextQuestionExist(themeSelected : Tema) -> Bool{
        if(themeSelected.preguntas.count == 0){
            return false
        }
        return true
    }
    
    
    
    func prePlayGame(questionSelected : Pregunta){
        showPlayGameComponents()
        // TODO randomiza respuestas
        questionSelected.shuffle()
        
        //miramos el numero de respuestas asignadas
        var numberOfAnswer : Int = questionSelected.respuestas.count
        
        labelQuestion.text = questionSelected.descripccion

        //formating buttons
        for i in 0...(buttonCollection.count-1){
            if(i < numberOfAnswer){
            buttonCollection[i].setAnswer(answer: questionSelected.respuestas[i])
            buttonCollection[i].setTitle(questionSelected.respuestas[i].descripccion , for: .normal)
            buttonCollection[i].isHidden = false
            buttonCollection[i].isEnabled = true
            }else{
                buttonCollection[i].isHidden = true
            }
        }
    }
    
    @IBAction func checkValueButtons(_ sender: ButtonAnswer) {
        if(sender.answer?.correcta)!{
            sender.backgroundColor = UIColor.green
            //Borrar
            getSelectTheme().preguntas.remove(at: questionPositionTheme)
            //Sumar puntuacion
            puntuacion += 1
            
        }else{
            sender.backgroundColor = UIColor.red
            if(puntuacion != 0){
                puntuacion -= 1
            }
        }
        
        labelPuntuacion.text = "Puntuacion \(puntuacion)"
        //disable buttons
        disableButton()
        
        buttonSiguientePregunta.isEnabled = true
        
        if(!checkIfNextQuestionExist(themeSelected: getSelectTheme())){
                    labelQuestion.text = "No quedan mas preguntas de este tema"
            buttonSiguientePregunta.setTitle("Exit", for: .normal)
        }
        
    }
    //return the selected theme in the picker
    func getSelectTheme() -> Tema{
        return temaCollection[pick.selectedRow(inComponent: 0)];
    }
    
    func getRandomQuestion(tema : Tema) -> Pregunta{
        if(tema.preguntas.count == 1){
            questionPositionTheme = 0
        }else{
            questionPositionTheme = Int(arc4random_uniform(UInt32(tema.preguntas.count)))
        }
        return tema.preguntas[questionPositionTheme]
    }
    func removeTheme(){
        temaCollection.remove(at: pick.selectedRow(inComponent: 0))
        pick.dataSource = self
        pick.delegate = self
        
        
    }
    func checkIfGameIsDone() -> Bool{
        if(temaCollection.count == 0){
            pick.isHidden = true
            labelPuntuacion.isHidden = true
            buttonEscogerTema.isHidden = true
            labelQuestion.text = "Test finalizado con un total de  \(puntuacion) puntos"
            labelQuestion.isHidden = false
            buttonSiguientePregunta.isHidden = true
            hideButtons()
            return true
        }
        return false
    }
    
    func disableButton(){
        for buttonActual in buttonCollection {
            buttonActual.isEnabled = false;
        }
    }    
    func resetGame(){

        removeTheme()
        showSelectThemeComponents()
    }
    
    func showSelectThemeComponents(){
        if(checkIfGameIsDone()){return}
        labelQuestion.isHidden = true
        buttonSiguientePregunta.isHidden = true
        buttonSiguientePregunta.setTitle("Siguiente Pregunta", for: .normal)
        hideButtons()
        pick.isHidden = false
        buttonEscogerTema.isHidden = false
        
    }
    
    func showPlayGameComponents(){
        for buttonActual in buttonCollection {
            buttonActual.backgroundColor = UIColor.clear
        }
        pick.isHidden = true
        buttonEscogerTema.isHidden = true
        labelPuntuacion.isHidden = false
        buttonSiguientePregunta.isHidden = false
        buttonSiguientePregunta.isEnabled = false
        labelQuestion.isHidden = false
    }
    
    func hideButtons(){
        for actualButton in buttonCollection {
            actualButton.isHidden = true;
        }
    }
    
    // Add 4 Standard themes
    func initialTemas(){
        //TODO Next step, create a view that provide to the user, create theme
        var aux = Tema(nombre: "Java")
        temaCollection.append(aux)
        
        aux = Tema(nombre: "PHP")
        temaCollection.append(aux)
        
        aux = Tema(nombre: "C++")
        temaCollection.append(aux)
        
        aux = Tema(nombre: "Android")
        temaCollection.append(aux)
        
    }
    
    func initialQuestionsWithAnswers(){
        //Java questions & answers
        var aux = Pregunta(descripccion: "¿Es Java un lenguaje tipado?")
        var auxans = Respuesta(descripccion: "Sí", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "No", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[0].addPregunta(pregunta: aux)
        
        aux = Pregunta(descripccion: "¿Es Java un lenguaje compilado?")
        auxans = Respuesta(descripccion: "Sí", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "No", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[0].addPregunta(pregunta: aux)
        
        aux = Pregunta(descripccion: "¿Qué método permite copiar un objeto en otro?")
        auxans = Respuesta(descripccion: "==", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "equals", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "copy", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "clone", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[0].addPregunta(pregunta: aux)
        
        aux = Pregunta(descripccion: "¿Qué método usarias para leer desde un fichero?")
        auxans = Respuesta(descripccion: "InputStreamReader", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "BufferedReader", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "Reader", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "FileReader", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[0].addPregunta(pregunta: aux)
        
        //PHP questions
        aux = Pregunta(descripccion: "¿Es PHP un lenguaje fuertemente tipado?")
        auxans = Respuesta(descripccion: "Sí", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "No", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[1].addPregunta(pregunta: aux)
        
        aux = Pregunta(descripccion: "¿Es PHP un lenguaje compilado?")
        auxans = Respuesta(descripccion: "Sí", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "No", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[1].addPregunta(pregunta: aux)
        
        aux = Pregunta(descripccion: "¿desde que version es PHP un lenguaje object oriented?")
        auxans = Respuesta(descripccion: "12", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "3", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "5", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "3.5", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[1].addPregunta(pregunta: aux)
        
        aux = Pregunta(descripccion: "¿que significan las siglas PHP?")
        auxans = Respuesta(descripccion: "Processor Hypertext Protocol", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "Partido Hermafroditas Popular", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "Paradigma Hombre Pederasta", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "Personal Home Page", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[1].addPregunta(pregunta: aux)
        
        
        //C++ Questions
        aux = Pregunta(descripccion: "¿Es C++ un lenguaje tipado?")
        auxans = Respuesta(descripccion: "Sí", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "No", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[2].addPregunta(pregunta: aux)
        
        aux = Pregunta(descripccion: "¿Es C++ un lenguaje compilado?")
        auxans = Respuesta(descripccion: "Sí", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "No", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[2].addPregunta(pregunta: aux)
        
        aux = Pregunta(descripccion: "Nombre el tipo de datos que se puede utilizar para almacenar caracteres anchos")
        auxans = Respuesta(descripccion: "wchar_t", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "char", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "double", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "String", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[2].addPregunta(pregunta: aux)
        
        aux = Pregunta(descripccion: "¿Puede ser un programa compilado sin funcion main()? ")
        auxans = Respuesta(descripccion: "Sí", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "No existe en c++", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "No", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[2].addPregunta(pregunta: aux)
        
        aux = Pregunta(descripccion: "¿Quien diseño c++? ")
        auxans = Respuesta(descripccion: "Bjarne Stroustrup", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "El tito MC", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "James Gosling", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "Dennis Ritchie", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[2].addPregunta(pregunta: aux)
        
        
        //Android
        aux = Pregunta(descripccion: "¿Cúal es la clase principal en android para determinar la localizacion geográfica del dispositivo?")
        auxans = Respuesta(descripccion: "LocationManager", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "LocationService", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "LocationMap", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "LocationProvider", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[3].addPregunta(pregunta: aux)
        
        aux = Pregunta(descripccion: "¿En que carpeta debemos guardar los ficheros de audio o video?")
        auxans = Respuesta(descripccion: "res/raw", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "res/media", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "res/multimedia", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "res/ext", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[3].addPregunta(pregunta: aux)
        
        aux = Pregunta(descripccion: "¿Cúal de las siguientes, es una clase que existe para poder implementar tareas en segundo plano?")
        auxans = Respuesta(descripccion: "AsyncTask", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "AsyncThread", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "BackgroundTask", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[3].addPregunta(pregunta: aux)
        
        aux = Pregunta(descripccion: "¿Que metodo podemos usar para mostrar una notificacion por pantalla?")
        auxans = Respuesta(descripccion: "toast()", correcta: true)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "log()", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "log(category)", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        auxans = Respuesta(descripccion: "print()", correcta: false)
        aux.addRespuesta(respuesta: auxans)
        temaCollection[3].addPregunta(pregunta: aux)
    }
    
    //Set the number o picker views
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Set the String for the picker view row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return temaCollection[row].nombre
    }
    
    //Set the number of rows of the pickers
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return temaCollection.count
    }
    
    // Executed when program crash
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

