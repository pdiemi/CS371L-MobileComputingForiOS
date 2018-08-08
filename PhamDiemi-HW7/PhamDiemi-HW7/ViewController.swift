//
//  ViewController.swift
//  PhamDiemi-HW7
//  EID: mp43952
//  Course: CS371L
//
//  Created by Pham, Diemi on 8/7/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

let timerCellIdentifier = "timerCellIdentifier"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewTimerDelegate, UpdatedTimerDelegate {
    
    @IBOutlet weak var timerTableView: UITableView!
    
    var selectedTimerIndex: Int!
    var isCountdown: Bool = false
    var selectedTimer: Timer?
    
    var timers: [Timer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timerTableView.dataSource = self
        timerTableView.delegate = self
        
        timerTableView.reloadData()
        
        // Initialize Timer array for testing
        // Comment out the following line if you want to start with an empty Timer array
        timersInit()
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
        return timers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            timerCellIdentifier, for: indexPath as IndexPath) as! TimerTableViewCell
        let row = indexPath.row
        cell.timer = timers[row]
        cell.labelEvent.text = "Event\t\t" + timers[row].event
        cell.labelLocation.text = "Location\t" + timers[row].location
        cell.labelRemainingTime.text = "Remaining time(s)\t" + String(timers[row].remainingTime)
        return cell
    }
    

    //
    // Prepare for segues
    //
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        switch segue.identifier {
        case "addSegue":
            let destination = segue.destination as? AddViewController
            destination?.delegate = self
        
        case "countdownSegue":
            let destination = segue.destination as? CountdownViewController
            destination?.delegate = self
            if let indexPath = self.timerTableView.indexPathForSelectedRow {
                selectedTimerIndex = indexPath.row
                selectedTimer = timers[selectedTimerIndex]
                isCountdown = true
                destination?.timer = selectedTimer
            }
        default:
            break
        }
    }
    
    //
    // Delegate stubs for NewTimerDelegate
    //
    func addTimer(event: String, location: String, totalTime: Int64) {
        // Strore the new timer passed from AddViewCOntroller to Core Data
        addNewTimer(event: event, location: location, remainingTime: totalTime)
        timerTableView.reloadData()
    }
    
    //
    // Delegate stubs for UpdatedTimerDelegate
    //
    func updateTimer(remainingTime: Int64) {
        timers[selectedTimerIndex].update(t: remainingTime)
        if let index = self.timerTableView.indexPathForSelectedRow{
            self.timerTableView.deselectRow(at: index, animated: true) }
        timerTableView.reloadData()
    }
    
    //
    // Method used to save a new Note to Core Data
    //
    
    func addNewTimer(event: String, location: String, remainingTime: Int64) {
        let newTimer = Timer(e: event, l: location, t: remainingTime)
        if timers.contains(newTimer) {
            let alert = UIAlertController(title: "Arealdy Exist",
                                          message: "The event you entered already exists. Please enter a new event. The (Event, Locaion) pair must not be duplicated.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        timers.append(newTimer)
    }
    
    //
    // Initialize Timer array for testing
    //
    
    func timersInit() {
        for i in 1...4 {
            let time: Int64 = Int64(i * 5)
            let timerInit: Timer = Timer(e: "\(i)", l: "\(i)", t: time)
                timers.append(timerInit)
        }
    }
    
}

