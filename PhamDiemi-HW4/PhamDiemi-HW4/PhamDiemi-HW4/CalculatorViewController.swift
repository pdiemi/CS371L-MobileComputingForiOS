//
//  CalculatorViewController.swift
//  PhamDiemi-HW4
//  EID: mp43952
//  Course: CS371L
//
//  Created by Pham, Diemi on 7/27/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var textFieldOperand1: UITextField!
    @IBOutlet weak var textFieldOperand2: UITextField!
    @IBOutlet weak var labelOperator: UILabel!
    @IBOutlet weak var labelResult: UILabel!
    
    
    var myOperator: String? = "Operator"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        labelOperator.text = myOperator
        textFieldOperand1.becomeFirstResponder()
    }
    
    //
    // This method is called when Calculate button is pressed.
    // When Calculate button is pressed, the displayed operator
    // is performed using inputs from the two textfFields.
    //
    // If either one of the inputs is empty or not numeric, then Result
    // label will show "Invalid input(s)!"
    //
    // If either one of the input numbers is too long that cannot
    // be converted to float, then Result label wil show
    // "Invalid input(s)!"
    //
    // If operator is "Divide" and operand 2 (input of textFieldOperand2)
    //   is 0, then Result label will show "Cannot divide by 0!"
    //
    @IBAction func buttonCalculatePressed(_ sender: Any) {
        if let input1 = textFieldOperand1.text,
            let input2 = textFieldOperand2.text,
            (Float(input1) != nil), (Float(input2) != nil)
        {
            //let operand1: Float? = (input1 as NSString).floatValue
            //let operand2: Float? = (input2 as NSString).floatValue
            let operand1 = Float(input1)
            let operand2 = Float(input2)
            
            switch myOperator {
            case "Add":
                labelResult.text = String(operand1! + operand2!)
            case "Subtract":
                labelResult.text = String(operand1! - operand2!)
            case "Multiply":
                labelResult.text = String(operand1! * operand2!)
            case "Divide":
                if operand2 != 0 {
                    labelResult.text = String(Float(operand1!) / Float(operand2!))
                } else {
                    labelResult.text = "Cannot divide by 0!"
                }
            default:    // This case should never happen
                labelResult.text = "Invalid operator!"
            }
        } else {
            labelResult.text = "Invalid input(s)!"
        }
        
    }
    
    // This method is called when the user touches the Return key on the
    // keyboard. The 'textField' passed in is a pointer to the textField
    // widget the cursor was in at the time they touched the Return key on
    // the keyboard.
    //
    // From the Apple documentation: Asks the delegate if the text field
    // should process the pressing of the return button.
    //
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
