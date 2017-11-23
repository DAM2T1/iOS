//
//  ViewController.swift
//  Practica1iOS
//
//  Created by Raiksih on 2/10/17.
//  Copyright © 2017 Raiksih. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
				
    
    @IBOutlet weak var b1: UIButton!
    
    @IBOutlet weak var b2: UIButton!
    
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var b4: UIButton!
    
    @IBOutlet weak var b5: UIButton!
    
    @IBOutlet weak var b6: UIButton!
    
    @IBOutlet weak var puntuacion: UILabel!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var finishResult: UILabel!
    
    @IBOutlet weak var TimerShower: UILabel!
    
    var randoms: [Int] = []
    
    var buttonArray: [UIButton] = []

    var rightGuess: Int = 0
    
    @IBOutlet weak var levelDisplayer: UILabel!
    
    var contPuntuacion: Int = 0
    
    var timer:Timer? = nil
    
    var level:Int = 0
    
    let standardTimeOut: Int = 20
    
    var timeOutChalleng: Int = 20;
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        if sender.currentTitle == String(randoms[rightGuess]) {
            sender.isHidden = true
            rightGuess += 1
            contPuntuacion += 1
        }
        
        puntuacion.text = String(contPuntuacion)
        
        if(isWinned()){
            level += 1
            levelDisplayer.text = "LVL \(level)"
            preGame()
        }

        
    }
    
    @IBAction func playAgain(_ sender: Any) {
        timeOutChalleng = standardTimeOut
        level = 0
        levelDisplayer.text = "LVL \(level)"
        contPuntuacion = 0
        finishResult.text = "Puntuacion total \(contPuntuacion)"
        finishResult.isHidden = true
        timer = nil
        preGame()
    }
    
    func preGame() {
        buttonArray = [b1,b2,b3,b4,b5,b6]
        assignInitialNumbers()
        randoms.sort()
        // posible pedo (poner variable a nil y asignar solo si esta nil)
        if(timer == nil){
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(funcionCadaSegundo), userInfo: nil, repeats: true)
        }
        
        rightGuess = 0
        playAgainButton.isHidden = true
        if((standardTimeOut - ( 3 * level)) >= 5){
            timeOutChalleng = standardTimeOut - (3 * level)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        preGame()
        
    }

    func funcionCadaSegundo() {
        timeOutChalleng -= 1
        TimerShower.text = String(timeOutChalleng)
        
        if(timeOutChalleng == 0){
            timer?.invalidate()
            for button in buttonArray {
                button.isHidden = true
            }
            finishResult.text = "Puntuacion total \(contPuntuacion)"
            playAgainButton.isHidden = false
        }
    }
    func assignInitialNumbers() {
        randoms.removeAll()
        for i in 0...5 {
            randoms.append(generateRandom())
            buttonArray[i].setTitle(String(randoms[i]), for: .normal)
            buttonArray[i].isHidden = false
        }
    }
    
    func generateRandom() -> Int {
        return  Int(arc4random_uniform(201)) - 100
    }
    
    func isWinned() -> Bool{
        if rightGuess == 6 && timeOut() == false{
            return true
        }
            return false
    }
    func timeOut() -> Bool{
        if(timeOutChalleng <= 0){
            return true
        }
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //randoms =  Array<Int>(repeating: generateRandom(), count : 6)
    }

}

						
