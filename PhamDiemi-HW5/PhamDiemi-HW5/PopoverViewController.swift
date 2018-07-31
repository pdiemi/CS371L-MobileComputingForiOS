//
//  PopoverViewController.swift
//  PhamDiemi-HW5
//  EID: mp43952
//  Course: CS371L
//
//  Created by Pham, Diemi on 7/30/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

//
// This class store information of a Note includes
// date and time the note created and content of the Note
//
public class Note {
    private var date: NSDate
    var str: String
    init(s: String) {
        date = NSDate()
        str = s
    }
    
    func getDate() -> String {
        let myDateFormat = DateFormatter()
        myDateFormat.dateFormat = "MM/dd/yyyy"
        return myDateFormat.string(from: date as Date)
    }
    
    func getTime() -> String {
        let myDateFormat = DateFormatter()
        myDateFormat.dateFormat = "HH:mm"
        return myDateFormat.string(from: date as Date)
    }
    
    func update(s: String) {
        str = s
        date = NSDate()
    }
}

//
//  Delegate for passing information between PopoverViewController
//  and the main ViewController (QuickNotesViewController)
//

protocol NewNoteDelegate {
    func updateNewNote(s: String)
    func resetFlags(isNewNote: Bool, currentText: String)
}

//
//  Popover View Controller Class
//
class PopoverViewController: UIViewController {

    @IBOutlet weak var barButtonDiscard: UIBarButtonItem!
    @IBOutlet weak var barButtonSave: UIBarButtonItem!
    @IBOutlet weak var textViewNotes: UITextView!
    
    var isNewNote: Bool = true
    var currentText :String?
    var delegate: NewNoteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textViewNotes.becomeFirstResponder()
    }
    
    //
    //  PopoverViewCOntroller displays content of the selected Note for updating,
    //  or a blank Note for adding a new Note.
    //
    override func viewWillAppear(_ animated: Bool) {
        if !isNewNote {
            textViewNotes.text = currentText
        }
    }

    //
    //  When PopoverViewController disappears, reset all the Flags
    //
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.resetFlags(isNewNote: true, currentText: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    //  This method is called when Discard button is pressed.
    //  When Dismiss button is pressed, dismiss the PopoverViewController
    //
    @IBAction func barButtonDiscardPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //
    //  This method is called when Save button is pressed.
    //  When Save button is pressed, the text typed in the
    //  textView will be passed to the main ViewcController
    //  through the defined delegate and the PopoerViewController
    //  will be dismissed.
    //
    @IBAction func barButtonSavePressed(_ sender: Any) {
        currentText = textViewNotes.text
        delegate?.updateNewNote(s: currentText!)
        dismiss(animated: true, completion: nil)
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
        delegate?.resetFlags(isNewNote: true, currentText: "")
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
