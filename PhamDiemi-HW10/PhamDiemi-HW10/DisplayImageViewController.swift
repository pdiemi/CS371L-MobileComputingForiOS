//
//  DisplayImageViewController.swift
//  PhamDiemi-HW10
//
//  Created by Pham, Diemi on 8/16/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

protocol SaveImageDelegate {
    func saveImage(_ saveConfirm: Bool)
}

class DisplayImageViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var buttonSave: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
    var isFromPicker: Bool = false
    var delegate: SaveImageDelegate?
    var saveConfirm: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = image
        if isFromPicker {
            self.navigationController?.isToolbarHidden = false
            self.buttonSave.isEnabled = true
        } else {
            self.navigationController?.isToolbarHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSavePressed(_ sender: Any) {
        saveConfirm = true
        delegate?.saveImage(saveConfirm)
        print("I'm also here")
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
