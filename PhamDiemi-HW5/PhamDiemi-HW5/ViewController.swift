//
//  ViewController.swift
//  PhamDiemi-HW5
//  EID: mp43952
//  Course: CS371L
//
//  Created by Pham, Diemi on 7/30/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

let initNote = Note(s: "welcome to Quick notes!")
public var notes: [Note] = [initNote]

let textCellIdentifier = "NoteTableViewCell"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate, NewNoteDelegate {
    
    @IBOutlet var tableView: UITableView!
    //
    //  Flags - addNewNote: true if adding a new note, false if updating selected note
    //        - selectedNoteIndex: index of selected note
    //        - selected note: content of selected note, will be display to popover controller
    //
    var selectedNote: String?
    var selectedNoteIndex: Int?
    var addNewNote: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // To conform to UITableViewDataSource, you must implement
    // 3 methods:
    //    1.  numberOfSectionsInTableView
    //    2.  tableView:numberOfRowsInSection
    //    3.  tableView:cellForRowAtIndexPath
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            textCellIdentifier, for: indexPath as IndexPath) as! NoteTableViewCell
        let row = indexPath.row
        //cell.textLabel?.text = notes[row]
        cell.note = notes[row]
        cell.labelDate.text = notes[row].getDate()
        cell.labelTime.text = notes[row].getTime()
        cell.labelNotes.text = notes[row].str
        return cell
    }
    
    //
    //  This method is called when a tableview cell is clicked.
    //  The method resets flags and performs a segue to a popover view controller
    //  for updating content of the selected Note.
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNoteIndex = indexPath.row
        selectedNote = notes[indexPath.row].str
        addNewNote = false
        performSegue(withIdentifier: "popoverSegue", sender: self)
    }
    
    //
    //  Conform to NewnoteDelegate
    //
    func updateNewNote(s: String) {
        if addNewNote { //Add a new note
            let newNote = Note(s: s)
            notes.append(newNote)
        } else { // Update selected note
            notes[selectedNoteIndex!].str = s
        }
        selectedNote = ""
        addNewNote = true
        tableView.reloadData()
    }
    func resetFlags(isNewNote: Bool, currentText: String) {
        addNewNote = isNewNote
        selectedNote = currentText
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true) }
    }
    
    //
    // Prepare for segue to Popover View Controller, avoid full screen popover
    //
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        if segue.identifier == "popoverSegue" {
            let destination = segue.destination as? PopoverViewController
            destination?.popoverPresentationController?.delegate = self
            destination?.delegate = self
            
            if !addNewNote {  // Update selected note
                destination?.isNewNote = addNewNote
                destination?.currentText = selectedNote!
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

}

