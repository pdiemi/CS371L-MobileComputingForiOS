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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let width = CGFloat(screenWidth/9)
        let height = CGFloat(screenHeight/19)
        
        let myLabel = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: width , height: height))
        myLabel.center = self.view.center
        myLabel.backgroundColor = UIColor.green
        self.view.addSubview(myLabel)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

