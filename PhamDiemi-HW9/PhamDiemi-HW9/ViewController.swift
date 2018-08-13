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

    let screenSize: CGRect = UIScreen.main.bounds
    var myLabel: UILabel?
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    var width: CGFloat?
    var height: CGFloat?
    var right: CGFloat?
    var left: CGFloat?
    var top: CGFloat?
    var bottom: CGFloat?
    var shouldStop: Bool = true
    var direction: UISwipeGestureRecognizerDirection?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Programmatically creat a label as a block at the center of a (9 x 19) grid-view
        // Size of the block equals to size of a gird
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        width = CGFloat(screenWidth!/9)
        height = CGFloat(screenHeight!/19)
        right = screenWidth! - width!/2
        left = 0 + width!/2
        top = 0 + height!/2
        bottom = screenHeight! - height!/2
        
        myLabel = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: width! , height: height!))
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
        
        if self.myLabel?.center.x == self.right {
            return
        } else {
            var myLabelX: CGFloat = (self.myLabel?.center.x)!
            
            DispatchQueue.global(qos: .userInteractive).async {
                while (myLabelX != self.right) {
                    usleep(300000)
                    myLabelX += self.width!
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0,
                                       animations: {
                                        self.myLabel?.center.x = myLabelX },
                                       completion: {finished in
                                        if self.myLabel?.center.x == self.right {
                                            self.myLabel?.backgroundColor = UIColor.red } }
                        )
                    }
                }
            }
        }
    }
    
    //
    // Swipe Left Gesture
    //
    @objc func recognizeSwipeLeftGesture(recognizer: UISwipeGestureRecognizer) {
        
        if self.myLabel?.center.x == self.left {
            return
        } else {
            var myLabelX: CGFloat = (self.myLabel?.center.x)!
            
            DispatchQueue.global(qos: .userInteractive).async {
                while (myLabelX != self.left) {
                    usleep(300000)
                    myLabelX -= self.width!
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0,
                                       animations: {
                                        self.myLabel?.center.x = myLabelX },
                                       completion: {finished in
                                        if self.myLabel?.center.x == self.left {
                                            self.myLabel?.backgroundColor = UIColor.red } }
                        )
                    }
                }
            }
        }
    }
    
    //
    // Swipe Up Gesture
    //
    @objc func recognizeSwipeUpGesture(recognizer: UISwipeGestureRecognizer) {
        
        if self.myLabel?.center.y == self.top {
            return
        } else {
            var myLabelY: CGFloat = (self.myLabel?.center.y)!
            
            DispatchQueue.global(qos: .userInteractive).async {
                while (myLabelY - self.top!) > 0 {
                    usleep(300000)
                    myLabelY -= self.height!
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0,
                                       animations: {
                                        self.myLabel?.center.y = myLabelY },
                                       completion: {finished in
                                        if ((self.myLabel?.center.y)! - self.top!) <= 0 {
                                            self.myLabel?.backgroundColor = UIColor.red } }
                        )
                    }
                }
            }
        }
    }
    
    //
    // Swipe Down Gesture
    //
    @objc func recognizeSwipeDownGesture(recognizer: UISwipeGestureRecognizer) {
        
        if self.myLabel?.center.y == self.bottom {
            return
        } else {
            var myLabelY: CGFloat = (self.myLabel?.center.y)!
            
            DispatchQueue.global(qos: .userInteractive).async {
                while (myLabelY - self.bottom!) <= 0 {
                    usleep(300000)
                    myLabelY += self.height!
                    print(myLabelY - self.bottom!)
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0,
                                       animations: {
                                        self.myLabel?.center.y = myLabelY },
                                       completion: {finished in
                                        if ((self.myLabel?.center.y)! - self.bottom!) >= 0 {
                                            self.myLabel?.backgroundColor = UIColor.red } }
                        )
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
        
        while (myLabel?.center.y != bottom) {
            UIView.animate(withDuration: 0.3,
                           delay: 0.3,
                           animations: {
                            self.myLabel?.center.y += self.height!
            })
        }
        //myLabel?.backgroundColor = UIColor.red
    }

}

