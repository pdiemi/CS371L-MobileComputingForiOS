//
//  ViewController.swift
//  PhamDiemi-HW9
//
//  Created by Pham, Diemi on 8/10/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    //let screenSize: CGRect = UIScreen.main.bounds
    var myLabel: UILabel?
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    var screenHeight: CGFloat = UIScreen.main.bounds.height
    var width: CGFloat = UIScreen.main.bounds.width/9
    var height: CGFloat = UIScreen.main.bounds.height/19
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
        
        myLabel = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: width , height: height))
        myLabel?.center = self.view.center
        myLabel?.backgroundColor = UIColor.green
        self.view.addSubview(myLabel!)
        
        // Define Gesture handlers
        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipeRightGesture(recognizer:)))
        swipeRightRecognizer.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRightRecognizer)
        
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipeLeftGesture(recognizer:)))
        swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeftRecognizer)
        
        let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipeUpGesture(recognizer:)))
        swipeUpRecognizer.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUpRecognizer)
        
        let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipeDownGesture(recognizer:)))
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
    // Swipe Right Gesture
    //
    @objc func recognizeSwipeRightGesture(recognizer: UISwipeGestureRecognizer) {
        semaphoreGameOver.wait()
        if gameOver {
            semaphoreGameOver.signal()
            return
        } else {
            semaphoreGameOver.signal()
            var myLabelX: CGFloat = (self.myLabel?.center.x)!

            DispatchQueue.global(qos: .userInteractive).async {
                self.semaphoreDirectionChanged.wait()
                self.directionChanged = "right"
                self.semaphoreDirectionChanged.signal()
                
                self.semaphoreGameOver.wait()
                while (!self.gameOver) {
                    self.semaphoreGameOver.signal()
                    self.semaphoreDirectionChanged.wait()
                    if self.directionChanged != "right" {
                        self.semaphoreDirectionChanged.signal()
                        return
                    } else {
                        self.semaphoreDirectionChanged.signal()
                        usleep(300000)
                        
                        self.semaphoreGameOver.wait()
                        self.semaphoreDirectionChanged.wait()
                        myLabelX += self.width
                        if Int(myLabelX - self.right!) == 0 && self.directionChanged == "right" {
                            self.gameOver = true }
                        self.semaphoreGameOver.signal()
                        self.semaphoreDirectionChanged.signal()
                        
                        // Update UI in the main thread
                        self.updateUI(direction: "right", position: myLabelX)
                        
                        self.semaphoreGameOver.wait()
                    }
                }
                self.semaphoreGameOver.signal()
            }
        }
    }
    
    //
    // Swipe Left Gesture
    //
    @objc func recognizeSwipeLeftGesture(recognizer: UISwipeGestureRecognizer) {
        semaphoreGameOver.wait()
        if gameOver {
            semaphoreGameOver.signal()
            return
        } else {
            semaphoreGameOver.signal()
            var myLabelX: CGFloat = (self.myLabel?.center.x)!

            
            DispatchQueue.global(qos: .userInteractive).async {
                self.semaphoreDirectionChanged.wait()
                self.directionChanged = "left"
                self.semaphoreDirectionChanged.signal()
                
                self.semaphoreGameOver.wait()
                while (!self.gameOver) {
                    self.semaphoreGameOver.signal()
                    self.semaphoreDirectionChanged.wait()
                    if self.directionChanged != "left" {
                        self.semaphoreDirectionChanged.signal()
                        return
                    } else {
                        self.semaphoreDirectionChanged.signal()
                        usleep(300000)
                        
                        self.semaphoreGameOver.wait()
                        self.semaphoreDirectionChanged.wait()
                        myLabelX -= self.width
                        if Int(myLabelX - self.left!) == 0 && self.directionChanged == "left" {
                            self.gameOver = true }
                        self.semaphoreGameOver.signal()
                        self.semaphoreDirectionChanged.signal()
                        
                        // Update UI in the main thread
                        self.updateUI(direction: "left", position: myLabelX)
                        
                        self.semaphoreGameOver.wait()
                    }
                }
                self.semaphoreGameOver.signal()
            }
        }
    }
    
    //
    // Swipe Up Gesture
    //
    @objc func recognizeSwipeUpGesture(recognizer: UISwipeGestureRecognizer) {
        semaphoreGameOver.wait()
        if gameOver {
            semaphoreGameOver.signal()
            return
        } else {
            semaphoreGameOver.signal()
            var myLabelY: CGFloat = (self.myLabel?.center.y)!

            
            DispatchQueue.global(qos: .userInteractive).async {
                self.semaphoreDirectionChanged.wait()
                self.directionChanged = "up"
                self.semaphoreDirectionChanged.signal()
                
                self.semaphoreGameOver.wait()
                while (!self.gameOver) {
                    self.semaphoreGameOver.signal()
                    self.semaphoreDirectionChanged.wait()
                    if self.directionChanged != "up" {
                        self.semaphoreDirectionChanged.signal()
                        return
                    } else {
                        self.semaphoreDirectionChanged.signal()
                        usleep(300000)
                        
                        self.semaphoreGameOver.wait()
                        self.semaphoreDirectionChanged.wait()
                        myLabelY -= self.height
                        if Int(myLabelY - self.top!) == 0 && self.directionChanged == "up" {
                            self.gameOver = true }
                        self.semaphoreGameOver.signal()
                        self.semaphoreDirectionChanged.signal()
                        
                        // Update UI in the main thread
                        self.updateUI(direction: "up", position: myLabelY)
                        
                        self.semaphoreGameOver.wait()
                    }
                }
                self.semaphoreGameOver.signal()
            }
        }
    }
    
    //
    // Swipe Down Gesture
    //
    @objc func recognizeSwipeDownGesture(recognizer: UISwipeGestureRecognizer) {
        semaphoreGameOver.wait()
        if gameOver {
            semaphoreGameOver.signal()
            return
        } else {
            semaphoreGameOver.signal()
            var myLabelY: CGFloat = (self.myLabel?.center.y)!
         
            DispatchQueue.global(qos: .userInteractive).async {
                self.semaphoreDirectionChanged.wait()
                self.directionChanged = "down"
                self.semaphoreDirectionChanged.signal()
                
                self.semaphoreGameOver.wait()
                while (!self.gameOver) {
                    self.semaphoreGameOver.signal()
                    self.semaphoreDirectionChanged.wait()
                    if self.directionChanged != "down" {
                        self.semaphoreDirectionChanged.signal()
                        return
                    } else {
                        self.semaphoreDirectionChanged.signal()
                        usleep(300000)
                        
                        self.semaphoreGameOver.wait()
                        self.semaphoreDirectionChanged.wait()
                        myLabelY += self.height
                        if Int(myLabelY - self.bottom!) == 0 && self.directionChanged == "down"{
                            self.gameOver = true }
                        self.semaphoreGameOver.signal()
                        self.semaphoreDirectionChanged.signal()
                        
                        // Update UI in the main thread
                        self.updateUI(direction: "down", position: myLabelY)
                        
                        self.semaphoreGameOver.wait()
                    }
                }
                self.semaphoreGameOver.signal()
            }
        }
    }
    
    //
    // Tap Gesture
    //
    @objc func recognizeTapGesture(recognize: UITapGestureRecognizer) {
        myLabel?.center = self.view.center
        myLabel?.backgroundColor = UIColor.green
        var myLabelY: CGFloat = (self.myLabel?.center.y)!
        
        semaphoreGameOver.wait()
        self.semaphoreDirectionChanged.wait()
        gameOver = false
        self.directionChanged = "tap"
        semaphoreGameOver.signal()
        self.semaphoreDirectionChanged.signal()
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.semaphoreGameOver.wait()
            while (!self.gameOver) {
                self.semaphoreGameOver.signal()
                self.semaphoreDirectionChanged.wait()
                if self.directionChanged != "tap" {
                    self.semaphoreDirectionChanged.signal()
                    return
                } else {
                    self.semaphoreDirectionChanged.signal()
                    usleep(300000)
                    
                    self.semaphoreGameOver.wait()
                    self.semaphoreDirectionChanged.wait()
                    myLabelY += self.height
                    if Int(myLabelY - self.bottom!) == 0 && self.directionChanged == "tap"{
                        self.gameOver = true }
                    self.semaphoreGameOver.signal()
                    self.semaphoreDirectionChanged.signal()
                    
                    // Update UI in the main thread
                    self.updateUI(direction: "tap", position: myLabelY)
                    
                    self.semaphoreGameOver.wait()
                }
            }
            self.semaphoreGameOver.signal()
        }
    }
    
    //
    // The method is called to Update UI in main thread
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
    

}

