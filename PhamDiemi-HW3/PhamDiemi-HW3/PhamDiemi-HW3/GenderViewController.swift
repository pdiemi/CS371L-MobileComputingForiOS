//
//  GenderViewController.swift
//  PhamDiemi-HW3
//
//  Created by Pham, Diemi on 7/25/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

class GenderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    var currentUsername:String?
    
    @IBOutlet weak var buttonMale: UIButton!
    @IBOutlet weak var buttonFemale: UIButton!
    
    //
    // The two following methods are called correspondingly when the Male/Female
    // button is pressed. It takes the lable of the utton as a newGender string,
    // pass that newGender back to the main ViewController, and switch to the main
    // ViewController.
    // When the main ViewController re-appears, the Gender button's label is updated
    // with newGender.
    //
    @IBAction func buttonMalepressed(_ sender: Any) {
        let newGender = buttonMale.titleLabel?.text!
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        mainVC.newGender = newGender!
        mainVC.newUsername = currentUsername!
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    @IBAction func buttonFemalePressed(_ sender: Any) {
        let newGender = buttonFemale.titleLabel?.text!
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        mainVC.newGender = newGender!
        mainVC.newUsername = currentUsername!
        navigationController?.pushViewController(mainVC, animated: true)    }
    
}
