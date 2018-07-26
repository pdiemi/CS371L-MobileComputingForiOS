//
//  ViewController.swift
//  PhamDiemi-HW3
//  EID: mp43952
//  Course: CS371L
//
//  Created by Pham, Diemi on 7/24/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var buttonUsername: UIButton!
    @IBOutlet weak var buttonGender: UIButton!
    
    var newUsername = "User Name"
    var newGender = "Gender"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buttonUsername.setTitle(newUsername, for: .normal)
        buttonGender.setTitle(newGender, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    let genderSegueIdentifier = "genderSegueIdentifier"
    let usernameSegueIdentifier = "usernameSegueIdentifier"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is UsernameViewController,
            let destination = segue.destination as? UsernameViewController
        {
            destination.currentGender = buttonGender.currentTitle
            destination.currentUsername = buttonUsername.currentTitle
        }
        else if segue.destination is GenderViewController,
            let destination = segue.destination as? GenderViewController
        {
            destination.currentUsername = buttonUsername.currentTitle
        }
    }
}

