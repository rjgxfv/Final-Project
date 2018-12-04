//
//  ConversionViewController.swift
//  Conversion Calculator
//
//  Created by Robert Graman on 10/25/18.
//  Copyright © 2018 Robert Graman. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {

    
    
    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    
    let conversions = [ Conversion(label:"fahrenheit to celcius",inputUnit:"°F",outputUnit:"°C"),
                        Conversion(label:"celcius to fahrenheit",inputUnit:"°C",outputUnit:"°F"),
                        Conversion(label:"miles to kilometers",inputUnit:"mi",outputUnit:"km"),
                        Conversion(label:"kilometers to miles",inputUnit:"km",outputUnit:"mi")]
    
    let defaultConvert:Int=0
    let alert = UIAlertController(title: "Choose Converter", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
    var index:Int=0
    var number:Double? = 0
    var positive:Bool = true
    var decimal:Bool = false
    var decimalCount:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputDisplay.text=conversions[defaultConvert].outputUnit
        inputDisplay.text=conversions[defaultConvert].inputUnit
        
        for x in 0 ... (conversions.count-1){
            alert.addAction(UIAlertAction(title: conversions[x].label, style: UIAlertAction.Style.default, handler: {
                (alertAction)-> Void in
                self.conversion(x)
            }))
        }
    }
    
    @IBAction func clicked(_ sender: UIButton) {
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func decimalClicked(_ sender: Any) {
        decimal = true
        
    }
    @IBAction func plusMinusClicked(_ sender: Any) {
        positive = !positive
        number = number! * -1
        inputDisplay.text = String(number!) + "  " + conversions[index].inputUnit
        outputDisplay.text = String(convert(number!)) + "  " + conversions[index].outputUnit
    }
    @IBAction func clearClicked(_ sender: Any) {
        number = nil
        positive=true
        decimal = false
        decimalCount = 0
        inputDisplay.text = conversions[defaultConvert].inputUnit
        outputDisplay.text = conversions[defaultConvert].outputUnit
    }
    @IBAction func zeroClicked(_ sender: Any) {
        updateNumber(0)
    }
    @IBAction func oneClicked(_ sender: Any) {
        updateNumber(1)
    }
    @IBAction func twoClicked(_ sender: Any) {
        updateNumber(2)
    }
    @IBAction func threeClicked(_ sender: Any) {
        updateNumber(3)
    }
    @IBAction func fourClicked(_ sender: Any) {
        updateNumber(4)
    }
    @IBAction func fiveClicked(_ sender: Any) {
        updateNumber(5)
    }
    @IBAction func sixClicked(_ sender: Any) {
        updateNumber(6)
    }
    @IBAction func sevenClicked(_ sender: Any) {
        updateNumber(7)
    }
    @IBAction func eightClicked(_ sender: Any) {
        updateNumber(8)
    }
    @IBAction func nineClicked(_ sender: Any) {
        updateNumber(9)
    }
    
    func updateNumber(_ numberPressed:Int)-> Void{
        if(number != nil)
        {
            if(decimal){
                decimalCount = decimalCount + 1
            }
            if(positive){
                if(decimalCount == 0){
                    number = (number! * 10) + Double(numberPressed)
                }
                else if(decimalCount == 1){
                    number = ((number! * 10 ) + Double(numberPressed)) / 10
                }
                else{
                    number = ((number! * pow(10, Double(decimalCount)) ) + Double(numberPressed))/pow(10, Double(decimalCount))
                }
            }
            else{
                if(decimalCount == 0){
                    number = (number! * 10) - Double(numberPressed)
                }
                else if(decimalCount == 1){
                    number = ((number! * 10 ) - Double(numberPressed)) / 10
                }
                else{
                    number = ((number! * pow(10, Double(decimalCount)) ) - Double(numberPressed))/pow(10, Double(decimalCount))
                }
            }
            inputDisplay.text = String(number!) + "  " + conversions[index].inputUnit
            outputDisplay.text = String(convert(number!)) + "  " + conversions[index].outputUnit
        }
        else{
            number = Double(numberPressed)
            inputDisplay.text = String(number!) + "  " + conversions[index].inputUnit
            outputDisplay.text = String(convert(number!)) + "  " + conversions[index].outputUnit
        }
        
    }
    func convert(_ number:Double)->Double{
        var finalNum:Double=0.0
        switch index {
        case 0:
            finalNum = (number - 32) * 5/9
        case 1:
            finalNum = (number * 9/5) + 32
        case 2:
            finalNum = number * 1.609344
        case 3:
            finalNum = number * 0.62137119
        default:
            print("This really shouldn't be happening")
        }
        
        return finalNum
    }
    func conversion(_ cIndex:Int) -> Void {
        index=cIndex
        if(number != nil)
        {
            inputDisplay.text = String(number!) + "  " + conversions[index].inputUnit
            outputDisplay.text = String(convert(number!)) + "  " + conversions[index].outputUnit
        }
        else
        {
            inputDisplay.text = conversions[index].inputUnit
            outputDisplay.text = conversions[index].outputUnit
        }
    }
}
