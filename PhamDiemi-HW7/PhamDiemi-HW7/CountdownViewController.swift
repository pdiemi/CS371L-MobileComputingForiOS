//
//  CountdownViewController.swift
//  PhamDiemi-HW7
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
        if selectedRemainingTime != nil {
            labelEvent.text = selectedEvent
            labelLocation.text = selectedLocation
            labelRemainingTime.text = String(selectedRemainingTime!) }
        // Start counting down
        startCountdown()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        shouldStop = true
    }
    
    func startCountdown() {
        DispatchQueue.global(qos: .userInteractive).async {
            // background thread: counting down here
            
            DispatchQueue.main.async {
                // main UI thread
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
