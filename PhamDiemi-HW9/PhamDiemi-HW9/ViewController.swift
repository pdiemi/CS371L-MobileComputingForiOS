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
    let serialQueue = DispatchQueue(label: "My Serial Queue")
    //var workItem: DispatchWorkItem?
    
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
            print("8\t\(self.directionChanged)\t\(self.gameOver)")
            semaphoreGameOver.signal()
            return
        } else {
            print("9\t\(self.directionChanged)\t\(self.gameOver)")
            semaphoreGameOver.signal()
            var myLabelX: CGFloat = (self.myLabel?.center.x)!

            DispatchQueue.global(qos: .userInteractive).async {
                self.semaphoreDirectionChanged.wait()
                print("10\t\(self.directionChanged)\t\(self.gameOver)")
                self.directionChanged = "right"
                self.semaphoreDirectionChanged.signal()
                
                print("1\t\(self.directionChanged)\t\(self.gameOver)")
                
                self.semaphoreGameOver.wait()
                while (!self.gameOver) {
                    self.semaphoreGameOver.signal()
                    self.semaphoreDirectionChanged.wait()
                    if self.directionChanged != "right" {
                        self.semaphoreDirectionChanged.signal()
                        print("2\t\(self.directionChanged)\t\(self.gameOver)")
                        return
                    } else {
                        self.semaphoreDirectionChanged.signal()
                        usleep(300000)
                        myLabelX += self.width
                        
                        print("3\t\(self.directionChanged)\t\(self.gameOver)")
                        self.semaphoreGameOver.wait()
                        self.semaphoreDirectionChanged.wait()
                        if Int(myLabelX - self.right!) == 0 && self.directionChanged == "right" {
                            self.gameOver = true }
                        self.semaphoreGameOver.signal()
                        self.semaphoreDirectionChanged.signal()
                        
                        print("4\t\(self.directionChanged)\t\(self.gameOver)")
                        DispatchQueue.main.async {
                            self.semaphoreGameOver.wait()
                            self.semaphoreDirectionChanged.wait()
                            
                            if self.directionChanged == "right" {
                                UIView.animate(withDuration: 0,
                                               animations: {
                                                self.myLabel?.center.x = myLabelX },
                                               completion: {finished in
                                                print("5\t\(self.directionChanged)\t\(self.gameOver)")
                                                if self.gameOver {
                                                    print("6\t\(self.directionChanged)\t\(self.gameOver)")
                                                    self.myLabel?.backgroundColor = UIColor.red }
                                                print("7\t\(self.directionChanged)\t\(self.gameOver)")
                                }
                                )
                            }
                            self.semaphoreGameOver.signal()
                            self.semaphoreDirectionChanged.signal()
                        }
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
            print("11\t\(self.directionChanged)\t\(self.gameOver)")
            semaphoreGameOver.signal()
            return
        } else {
            print("12\t\(self.directionChanged)\t\(self.gameOver)")
            semaphoreGameOver.signal()
            var myLabelX: CGFloat = (self.myLabel?.center.x)!

            
            DispatchQueue.global(qos: .userInteractive).async {
                self.semaphoreDirectionChanged.wait()
                print("13\t\(self.directionChanged)\t\(self.gameOver)")
                self.directionChanged = "left"
                self.semaphoreDirectionChanged.signal()
                
                self.semaphoreGameOver.wait()
                while (!self.gameOver) {
                    print("14\t\(self.directionChanged)\t\(self.gameOver)")
                    self.semaphoreGameOver.signal()
                    self.semaphoreDirectionChanged.wait()
                    if self.directionChanged != "left" {
                        print("15\t\(self.directionChanged)\t\(self.gameOver)")
                        self.semaphoreDirectionChanged.signal()
                        return
                    } else {
                        self.semaphoreDirectionChanged.signal()
                        usleep(300000)
                        myLabelX -= self.width
                        
                        print("16\t\(self.directionChanged)\t\(self.gameOver)")
                        self.semaphoreGameOver.wait()
                        self.semaphoreDirectionChanged.wait()
                        print("17\t\(self.directionChanged)\t\(self.gameOver)")
                        if Int(myLabelX - self.left!) == 0 && self.directionChanged == "left" {
                            self.gameOver = true }
                        self.semaphoreGameOver.signal()
                        self.semaphoreDirectionChanged.signal()
                        
                        DispatchQueue.main.async {
                            self.semaphoreGameOver.wait()
                            self.semaphoreDirectionChanged.wait()
                            
                            if self.directionChanged == "left" {
                                UIView.animate(withDuration: 0,
                                               animations: {
                                                self.myLabel?.center.x = myLabelX },
                                               completion: {finished in
                                                print("18\t\(self.directionChanged)\t\(self.gameOver)")
                                                if self.gameOver {
                                                    print("19\t\(self.directionChanged)\t\(self.gameOver)")
                                                    self.myLabel?.backgroundColor = UIColor.red }
                                }
                                )
                            }
                            self.semaphoreGameOver.signal()
                            self.semaphoreDirectionChanged.signal()
                        }
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
                
                while (!self.gameOver) {
                    
                    self.semaphoreDirectionChanged.wait()
                    if self.directionChanged != "up" {
                        self.semaphoreDirectionChanged.signal()
                        return
                    } else {
                        self.semaphoreDirectionChanged.signal()
                        usleep(300000)
                        myLabelY -= self.height
                        
                        self.semaphoreGameOver.wait()
                        self.semaphoreDirectionChanged.wait()
                        if Int(myLabelY - self.top!) == 0 && self.directionChanged == "up" {
                            self.gameOver = true }
                        self.semaphoreGameOver.signal()
                        self.semaphoreDirectionChanged.signal()
                        
                        DispatchQueue.main.async {
                            self.semaphoreGameOver.wait()
                            self.semaphoreDirectionChanged.wait()
                            
                            if self.directionChanged == "up" {
                                UIView.animate(withDuration: 0,
                                               animations: {
                                                self.myLabel?.center.y = myLabelY },
                                               completion: {finished in
                                                if self.gameOver {
                                                    self.myLabel?.backgroundColor = UIColor.red }
                                }
                                )
                            }
                            self.semaphoreGameOver.signal()
                            self.semaphoreDirectionChanged.signal()
                        }
                    }
                }
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
                
                while (!self.gameOver) {
                    
                    self.semaphoreDirectionChanged.wait()
                    if self.directionChanged != "down" {
                        self.semaphoreDirectionChanged.signal()
                        return
                    } else {
                        self.semaphoreDirectionChanged.signal()
                        usleep(300000)
                        myLabelY += self.height
                        
                        self.semaphoreGameOver.wait()
                        self.semaphoreGameOver.wait()
                        if Int(myLabelY - self.bottom!) == 0 {
                            self.gameOver = true }
                        self.semaphoreGameOver.signal()
                        self.semaphoreDirectionChanged.signal()
                        
                        DispatchQueue.main.async {
                            self.semaphoreGameOver.wait()
                            self.semaphoreDirectionChanged.wait()
                            
                            if self.directionChanged == "down" {
                                UIView.animate(withDuration: 0,
                                               animations: {
                                                self.myLabel?.center.y = myLabelY },
                                               completion: {finished in
                                                if self.gameOver {
                                                    self.myLabel?.backgroundColor = UIColor.red }
                                }
                                )
                            }
                            self.semaphoreGameOver.signal()
                            self.semaphoreDirectionChanged.signal()
                        }
                    }
                }
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
        
        self.semaphoreDirectionChanged.wait()
        self.directionChanged = "tap"
        self.semaphoreDirectionChanged.signal()
        
        semaphoreGameOver.wait()
        gameOver = false
        semaphoreGameOver.signal()
        
        DispatchQueue.global(qos: .userInteractive).async {
            while (!self.gameOver) {
                
                self.semaphoreDirectionChanged.wait()
                if self.directionChanged != "tap" {
                    self.semaphoreDirectionChanged.signal()
                    return
                } else {
                    self.semaphoreDirectionChanged.signal()
                    usleep(300000)
                    myLabelY += self.height
                    
                    self.semaphoreGameOver.wait()
                    self.semaphoreDirectionChanged.wait()
                    if Int(myLabelY - self.bottom!) == 0 {
                        self.gameOver = true }
                    self.semaphoreGameOver.signal()
                    self.semaphoreDirectionChanged.signal()
                    
                    DispatchQueue.main.async {
                        self.semaphoreGameOver.wait()
                        self.semaphoreDirectionChanged.wait()
                        
                        if self.directionChanged == "tap" {
                            UIView.animate(withDuration: 0,
                                           animations: {
                                            self.myLabel?.center.y = myLabelY },
                                           completion: {finished in
                                            if self.gameOver {
                                                self.myLabel?.backgroundColor = UIColor.red }
                            }
                            )
                        }
                        self.semaphoreGameOver.signal()
                        self.semaphoreDirectionChanged.signal()
                        
                    }
                }
            }
        }
    }
    
    //
    // Lock on an object to maintain persistentcy
    //
    
    func lock(object: Bool, toDo: () -> ()) {
        objc_sync_enter(object)
        toDo()
        objc_sync_exit(object)
    }

}

