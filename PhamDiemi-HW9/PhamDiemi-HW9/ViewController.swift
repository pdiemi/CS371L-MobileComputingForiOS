//
//  ViewController.swift
//  PhamDiemi-HW9
//  EID: mp43952
//  Course: CS371L
//
//  Created by Pham, Diemi on 8/10/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit
import Foundation

let numberOfRow: Int = 19
let numberOfCollumn: Int = 9

class ViewController: UIViewController {

    
    //let screenSize: CGRect = UIScreen.main.bounds
    var myLabel: UILabel?
    //var myLabelRowth: Int = 9
    //var myLabelCollumn: Int = 4
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    var screenHeight: CGFloat = UIScreen.main.bounds.height
    var width: CGFloat = UIScreen.main.bounds.width/CGFloat(numberOfCollumn)
    var height: CGFloat = UIScreen.main.bounds.height/CGFloat(numberOfRow)
    var right: CGFloat?
    var left: CGFloat?
    var top: CGFloat?
    var bottom: CGFloat?
    var directionChanged: String = "none"
    let semaphoreDirectionChanged = DispatchSemaphore(value: 1)
    var gameOver: Bool = false
    let semaphoreGameOver = DispatchSemaphore(value: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Programmatically creat a label as a block at the center of a (9 x 19) grid-view
        // Size of the block equals to size of a gird
        
        right = screenWidth - width/2
        left = 0 + width/2
        top = 0 + height/2
        bottom = screenHeight - height/2
        
        // Display myLabel
        myLabel = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: width , height: height))
        myLabel?.center = self.view.center
        myLabel?.backgroundColor = UIColor.green
        self.view.addSubview(myLabel!)
        //myLabelRowth = 9
        //myLabelCollumn = 4
        
        // Define Gesture handlers
        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipeGesture(recognizer:)))
        swipeRightRecognizer.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRightRecognizer)
        
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipeGesture(recognizer:)))
        swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeftRecognizer)
        
        let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipeGesture(recognizer:)))
        swipeUpRecognizer.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUpRecognizer)
        
        let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipeGesture(recognizer:)))
        swipeDownRecognizer.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDownRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(recognizeTapGesture(recognize:)))
        self.view.addGestureRecognizer(tapRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //
    // Swipe Gesture
    //
    @IBAction func recognizeSwipeGesture(recognizer: UISwipeGestureRecognizer) {
        
        var swipeDirection: String = "none"
        
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.right:
            swipeDirection = "right"
        case UISwipeGestureRecognizerDirection.left:
            swipeDirection = "left"
        case UISwipeGestureRecognizerDirection.up:
            swipeDirection = "up"
        case UISwipeGestureRecognizerDirection.down:
            swipeDirection = "down"
        default:
            break
        }
        semaphoreGameOver.wait()
        semaphoreDirectionChanged.wait()
        if gameOver || swipeDirection == directionChanged {
            semaphoreGameOver.signal()
            semaphoreDirectionChanged.signal()
            return
        } else {
            semaphoreGameOver.signal()
            semaphoreDirectionChanged.signal()
            runBackgroundThread(direction: swipeDirection)
        }
    }
    
    //
    // Tap Gesture
    //
    @IBAction func recognizeTapGesture(recognize: UITapGestureRecognizer) {
        myLabel?.center = self.view.center
        myLabel?.backgroundColor = UIColor.green
        //var myLabelY: CGFloat = (self.myLabel?.center.y)!
        
        semaphoreGameOver.wait()
        self.semaphoreDirectionChanged.wait()
        gameOver = false
        self.directionChanged = "tap"
        semaphoreGameOver.signal()
        self.semaphoreDirectionChanged.signal()
        
        runBackgroundThread(direction: "tap")
        
    }
    
    //
    // The method is called to Update UI in main queue thread
    //
    func updateUI(direction: String, position: CGFloat) {
        DispatchQueue.main.async {
            self.semaphoreGameOver.wait()
            self.semaphoreDirectionChanged.wait()
            
            if self.directionChanged == direction {
                UIView.animate(withDuration: 0,
                               animations: {
                                if direction == "left" || direction == "right" {
                                    self.myLabel?.center.x = position
                                } else {
                                    self.myLabel?.center.y = position } },
                               completion: {finished in
                                if self.gameOver {
                                    self.myLabel?.backgroundColor = UIColor.red }})
            }
            self.semaphoreGameOver.signal()
            self.semaphoreDirectionChanged.signal()
        }
    }
    
    //
    // The method is called to run background thread for movement
    //
    func runBackgroundThread(direction: String) {
        var myLabelY: CGFloat = (self.myLabel?.center.y)!
        var myLabelX: CGFloat = (self.myLabel?.center.x)!
        var newPosition: CGFloat!
        DispatchQueue.global(qos: .userInteractive).async {
            self.semaphoreDirectionChanged.wait()
            self.directionChanged = direction
            self.semaphoreDirectionChanged.signal()
            
            self.semaphoreGameOver.wait()
            while (!self.gameOver) {
                self.semaphoreGameOver.signal()
                self.semaphoreDirectionChanged.wait()
                if self.directionChanged != direction {
                    self.semaphoreDirectionChanged.signal()
                    return
                } else {
                    self.semaphoreDirectionChanged.signal()
                    usleep(300000)
                    
                    self.semaphoreGameOver.wait()
                    self.semaphoreDirectionChanged.wait()
                    
                    switch direction {
                    case "right":
                        myLabelX += self.width
                        if Int(myLabelX - self.right!) == 0 && self.directionChanged == direction {
                            self.gameOver = true }
                        newPosition = myLabelX
                    case "left":
                        myLabelX -= self.width
                        if Int(myLabelX - self.left!) == 0 && self.directionChanged == direction {
                            self.gameOver = true }
                        newPosition = myLabelX
                    case "up":
                        myLabelY -= self.height
                        if Int(myLabelY - self.top!) == 0 && self.directionChanged == direction {
                            self.gameOver = true }
                        newPosition = myLabelY
                    case "down":
                        myLabelY += self.height
                        if Int(myLabelY - self.bottom!) == 0 && self.directionChanged == direction{
                            self.gameOver = true }
                        newPosition = myLabelY
                    case "tap":
                        myLabelY += self.height
                        if Int(myLabelY - self.bottom!) == 0 && self.directionChanged == direction{
                            self.gameOver = true }
                        newPosition = myLabelY
                    default:
                        break
                    }
                    
                    self.semaphoreGameOver.signal()
                    self.semaphoreDirectionChanged.signal()
                    
                    // Update UI in the main thread
                    self.updateUI(direction: direction, position: newPosition)
                    
                    self.semaphoreGameOver.wait()
                }
            }
            self.semaphoreGameOver.signal()
        }
    }

}

