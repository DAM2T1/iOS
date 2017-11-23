//: Playground - noun: a place where people can play

import UIKit

//variable
var string = "Hello, playground"
//constantes
let CONSTANTE = "ESTO ES UNA CONSTANTE"

//
var numero : Int = 10
//No funciona el ++
numero += 1

//decimales y float
var float : Float = 1.20

var doble : Double = 2.20

var a : Int = 9

var b:Int = 9

var res: Double = Double(a) / Double(b)

var tarde: Bool = false;

if tarde {
    print("Tira pa casa paco")
} else {
    print("a sobarla premoh")
}

print("El resultado de la division es \(res)")

let copyright = "\u{00a9}"

var perrito = "🐟"

// ==, !=, >, >=, <, <= comparadores
//op lógicos NOT !, AND &&, OR ||

/*
 switch perrito {
 case "🐟":
 print("🐟")
 default:
 print("🐽")
 }
 */

//declaracion de funciones
func sumarDosNumeros (x: Int, y: Int) -> Int{
    let resultado = x + y
    print("El resultado es \(resultado)")
    return resultado
}

print(sumarDosNumeros(x: 3, y: 4))


var numeros: [Int] = [1, 2, 3]

var palabras: [String] = [String]()


numeros.append(8)

numeros.count

numeros.remove(at: 2)

palabras.append("aaaa")
numeros

//var ejemploDiccionario[String : Int] = ["a" : 1 , "b" : 2]

for num in numeros {
    print(num)
}

for numer in 0...9{
    print (numer)
}

for _ in 0...7{
    print("imprime esta mierda 8 veces")
}

var i = 5
while i < 10 {
    print("whiling...")
    i += 1
}

repeat {
    print("esto es un do while")
    i += 1
} while i < 12


var ejemplo: String?

ejemplo = nil

if(ejemplo != nil){
    var nulo = ejemplo!
}else{
    print("el ejemplo es nil")
}

print(ejemplo)


ejemplo = "hola"








