//
//  CountdownViewController.swift
//  PhamDiemi-HW7
//  EID: mp43952
//  Course: CS371L
//
//  Created by Pham, Diemi on 8/7/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit
import Foundation

//
// Delegate for passing information between the main ViewController
// and the AddViewController
//
protocol UpdatedTimerDelegate {
    func updateTimer(remainingTime: Int64)
}

class CountdownViewController: UIViewController {

    @IBOutlet weak var labelEvent: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelRemainingTime: UILabel!
    
    var delegate: UpdatedTimerDelegate!
    var timer: Timer!
    
    var selectedEvent: String?
    var selectedLocation: String?
    var selectedRemainingTime: Int64?
    
    var shouldStop: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            labelEvent.text = timer.event
            labelLocation.text = timer.location
            labelRemainingTime.text = String(timer.remainingTime)
            
            // Start counting down
            startCountdown()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            shouldStop = true
            selectedRemainingTime = timer.remainingTime
            delegate?.updateTimer(remainingTime: selectedRemainingTime!)
    }
    
    func startCountdown() {
        DispatchQueue.global(qos: .userInteractive).async {
            // background thread: counting down here
            while (!self.shouldStop && self.timer.remainingTime > 0) {
                sleep(1)
                self.timer.remainingTime -= 1
                
                DispatchQueue.main.async {  // Update remaining time label as descreasing
                    // main UI thread
                    self.labelRemainingTime.text = String(self.timer.remainingTime)
                }
            }
        }
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
