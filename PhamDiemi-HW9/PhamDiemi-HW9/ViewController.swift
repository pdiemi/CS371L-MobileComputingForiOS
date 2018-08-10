//
//  ViewController.swift
//  PhamDiemi-HW9
//
//  Created by Pham, Diemi on 8/10/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let screenSize: CGRect = UIScreen.main.bounds
    var myLabel: UILabel?
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    var width: CGFloat?
    var height: CGFloat?
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
        
        myLabel = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: width! , height: height!))
        myLabel?.center = self.view.center
        myLabel?.backgroundColor = UIColor.green
        self.view.addSubview(myLabel!)
        
        // Define Gesture handlers
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipeGesture(recognizer:)))
        swipeRecognizer.direction = direction!
        self.view.addGestureRecognizer(swipeRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(recognizeTapGesture(recognize:)))
        self.view.addGestureRecognizer(tapRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func recognizeSwipeGesture(recognizer: UISwipeGestureRecognizer) {
        
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.right:
            while (myLabel?.center.x != self.view.bounds.width) {
                UIView.animate(withDuration: 0.3,
                               animations: {
                                self.myLabel?.center.x += self.width!
                })
            }
            myLabel?.backgroundColor = UIColor.red
        case UISwipeGestureRecognizerDirection.left:
            while (myLabel?.center.x != 0) {
                UIView.animate(withDuration: 0.3,
                               animations: {
                                self.myLabel?.center.x -= self.width!
                })
            }
            myLabel?.backgroundColor = UIColor.red
        case UISwipeGestureRecognizerDirection.up:
            while (myLabel?.center.y != 0) {
                UIView.animate(withDuration: 0.3,
                               animations: {
                                self.myLabel?.center.y -= self.height!
                })
            }
            myLabel?.backgroundColor = UIColor.red
        case UISwipeGestureRecognizerDirection.down:
            while (myLabel?.center.y != self.view.bounds.height) {
                UIView.animate(withDuration: 0.3,
                               animations: {
                                self.myLabel?.center.x += self.height!
                })
            }
            myLabel?.backgroundColor = UIColor.red
        default:
            break
        }
    }
    
    @objc func recognizeTapGesture(recognize: UITapGestureRecognizer) {
        
    }

}

