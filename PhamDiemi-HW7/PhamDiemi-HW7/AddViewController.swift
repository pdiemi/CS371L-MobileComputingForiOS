//
//  AddViewController.swift
//  PhamDiemi-HW7
//
//  Created by Pham, Diemi on 8/7/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

//
// Delegate for passing information between the main ViewController
// and the AddViewController
//
protocol NewTimerDelegate {
    func addTimer(event: String, location: String, totalTime: Int64)
}


class AddViewController: UIViewController {

    @IBOutlet weak var textFieldEvent: UITextField!
    @IBOutlet weak var textFieldLocation: UITextField!
    @IBOutlet weak var textFieldTotalTime: UITextField!
    
    var delegate: NewTimerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSavePressed(_ sender: Any) {
        if let event = textFieldEvent.text,
            let location = textFieldLocation.text,
            let totalTime = Int64(textFieldTotalTime.text!) {
            if totalTime >= 0 {
                delegate.addTimer(event: event, location: location, totalTime: totalTime)
                // TODO: display main ViewController
                self.navigationController?.popViewController(animated: true)
                
            }
            else {
                let alert = UIAlertController(title: "Invalid input",
                                              message: "Total time must be a non-negative integer.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
                return
            }
        } else {
            let alert = UIAlertController(title: "Invalid input or missing Information",
                                          message: "All fields are required. Total time must be a non-negative integer.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
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
