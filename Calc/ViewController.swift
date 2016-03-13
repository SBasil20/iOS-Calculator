//
//  ViewController.swift
//  Calc
//
//  Created by Shruti  on 13/03/16.
//  Copyright © 2016 Shruti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var display : UILabel!
    
    var userisenteringnumbers = false
    
    @IBAction func enternumber (sender: UIButton){
        let digit = sender.currentTitle!
        
        if userisenteringnumbers {
            display.text = display.text! + digit
        }
        else{
            display.text = digit
            
            userisenteringnumbers = true
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter (){
        userisenteringnumbers = false
        
        operandStack.append(displayvalue)
        
        print("operandStack = \(operandStack)") //rename
    }

    var displayvalue : Double {
        get {
            return NSNumberFormatter ().numberFromString(display.text!)!.doubleValue
        } set {
            display.text = "\(newValue)"
            
            userisenteringnumbers = false
        }
    }
    
    @IBAction func clear (){
        displayvalue = 0;
        display.text = "\(displayvalue)"
    }
    
    @IBAction func operate (sender: UIButton) {
         let operation = sender.currentTitle!
        
        if userisenteringnumbers{
            enter()
        }
        
        switch operation {
            case "➕": performOperation {$0 + $1}
            case "➖": performOperation {$1 - $0}
            case "✖️": performOperation {$1 * $0}
            case "➗": performOperation {$1 / $0}
            case "√":  performOperation {sqrt($0)}
        default: break
        }
        
        
    }
    
    func performOperation (operation: (Double, Double) -> Double) {
        if operandStack.count >= 2{
            displayvalue = operation (operandStack.removeLast(),operandStack.removeLast() )
            
            enter()
        }
    }
    
    private func performOperation (operation: Double -> Double) {
        if operandStack.count >= 1{
            displayvalue = operation (operandStack.removeLast() )
        }
        
        enter()
    }
    
    func add (op1: Double, op2: Double) -> Double {
        return op1 + op2
    }
    
    func subtract (op1: Double, op2: Double) -> Double {
        return op1 - op2
    }
    
    func multiply (op1: Double, op2: Double) -> Double {
        return op1 * op2
    }
    
    func divide (op1: Double, op2: Double) -> Double {
        return op1 / op2
    }

    
}

