//
//  ViewController.swift
//  PhamDiemi-HW8
//  EID: mp43952
//  Course: CS371L
//
//  Created by Pham, Diemi on 8/8/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit
import UserNotifications

let imageA = "uttower"
let imageB = "ut"

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    let imageUT = UIImage(named: imageB)
    let imageUTTower = UIImage(named: imageA)
    var clickCount = 0
    let timeInterval: TimeInterval = 8
    
    @IBOutlet weak var buttonImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UNUserNotificationCenter.current().delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonImageClicked(_ sender: Any) {
        
        clickCount += 1
        
        // Animation
        let image = buttonImage.currentImage
        switch image {
        case imageUTTower:
            UIView.animate(
                withDuration: 1.0,
                delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    self.buttonImage.alpha = 0.0
            },
                completion: { finished in
                    self.buttonImage.setImage(self.imageUT, for: .normal)
                    UIView.animate(
                        withDuration: 1.0,
                        delay: 0.0,
                        options: .curveEaseIn,
                        animations: {
                            self.buttonImage.alpha = 1.0
                    },
                        completion: nil
                    )
                }
            )
            
        case imageUT:
            UIView.animate(
                withDuration: 1.0,
                delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    self.buttonImage.alpha = 0.0
            },
                completion: { finished in
                    self.buttonImage.setImage(self.imageUTTower, for: .normal)
                    UIView.animate(
                        withDuration: 1.0,
                        delay: 0.0,
                        options: .curveEaseIn,
                        animations: {
                            self.buttonImage.alpha = 1.0
                    },
                        completion: nil
                    )
                }
            )
        default:
            print("no bg image")
        }
        
        // Notification after 4 clicks
        if clickCount == 4 {
            // create the content for a local notification
            let notification = UNMutableNotificationContent()
            notification.title = "Click Count"
            notification.subtitle = "How many time have you clicked?"
            notification.body = "You have clicked \(clickCount) times."
            
            
            // Set up the notification to trigger after timeInterval delay
            let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            
            // Set up a request to tell iOS to submit the notification with that trigger
            let request = UNNotificationRequest(identifier: "fourClicksNotification",
                                                content: notification,
                                                trigger: notificationTrigger)
            
            // Submit the request to iOS
            UNUserNotificationCenter.current().add(request) { error in
                print("Request error: ", error as Any)
            }
        }
        

    }
    
    //  ADDED:  required method that presents the notification in the app.  While the app is currently
    //  open on the device screen, the notification will appear at the top.
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification:UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler ([.alert, .sound])
    }
    
    //  ADDED:  required method that indicates what actions, if any, you want to associate with your
    //  notification.
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
}

