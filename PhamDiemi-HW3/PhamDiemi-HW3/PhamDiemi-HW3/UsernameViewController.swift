//
//  UsernameViewController.swift
//  PhamDiemi-HW3
//
//  Created by Pham, Diemi on 7/25/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

class UsernameViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textFieldUsername.delegate = self
        textFieldUsername?.text = currentUsername
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    var currentGender:String?
    var currentUsername:String?
    
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var labelUsername: UILabel!
    
    //
    // This method is called when the Save button is pressed.
    // It takes the content of the texFieldUsername as a newUsername,
    // pass that newUsername back to the main ViewController, and switch
    // to the main ViewController.
    // When the main ViewController re-appears, the Username button is
    // updated with newUsername.
    //
    @IBAction func buttonSavePressed(_ sender: Any) {
        let newUsername = textFieldUsername.text!
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        mainVC.newUsername = newUsername
        mainVC.newGender = currentGender!
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    
    // This method is called when the user touches the Return key on the
    // keyboard. The 'textField' passed in is a pointer to the textField
    // widget the cursor was in at the time they touched the Return key on
    // the keyboard.
    //
    // From the Apple documentation: Asks the delegate if the text field
    // should process the pressing of the return button.
    //
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
