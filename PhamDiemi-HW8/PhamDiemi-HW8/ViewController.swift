//
//  ViewController.swift
//  PhamDiemi-HW8
//
//  Created by Pham, Diemi on 8/8/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

let imageA = "uttower"
let imageB = "ut"

class ViewController: UIViewController {

    let imageUT = UIImage(named: imageB)
    let imageUTTower = UIImage(named: imageA)
    
    @IBOutlet weak var buttonImage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonImageClicked(_ sender: Any) {
        // Starting center value
        //self.labelMayTheForce.center.x = self.view.center.x
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
        

    }
    
}

