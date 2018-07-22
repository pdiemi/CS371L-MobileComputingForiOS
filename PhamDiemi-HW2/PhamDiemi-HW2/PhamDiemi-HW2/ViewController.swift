//
//  ViewController.swift
//  PhamDiemi-HW2
//  EID: mp34952
//  Course: CS371L
//
//  Created by Pham, Diemi on 7/22/18.
//  Copyright © 2018 UTCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.fieldUserId.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var fieldUserId: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    
    @IBOutlet weak var labelStatus: UILabel!

    
    // This method is called when the btnLogin is pressed.
    // If data has not been input into one or both of the two textFields,
    // update the status field with "Invalid login" message
    // If the data is fine, update the textField with the message,
    // "<userID logged in>"
    @IBAction func buttonPressed(_ sender: Any) {
        let user = fieldUserId.text!
        let pass = fieldPassword.text!
        var status = user
        if user == "" || pass == "" {
            status = "Invalid login"
        }
        else {
            status = user + " logged in"
            fieldUserId.text = ""
        }
        labelStatus.text = status
        fieldPassword.text = ""
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
    
}

