//
//  ViewController.swift
//  PhamDiemi-HW10
//
//  Created by Pham, Diemi on 8/15/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit
import AVFoundation

let NUMBER_IMAGES_PER_ROW: CGFloat = 3

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SaveImageDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    //var takenImage: UIImageView = UIImageView()
    var image: UIImage!
    var isFromPicker: Bool = false
    let picker = UIImagePickerController()
    
    
    var imageData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                     "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
                     "21", "22", "23", "24", "25", "26", "27", "28"]
    
    var imageCounter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // Protocol stub for SaveImageDelegate
    //
    func saveImage(_ saveConfirm: Bool) {
        if saveConfirm {
            print(saveConfirm)
            let cell = ImageCell()
            cell.image?.image = image
            collectionView.addSubview(cell)
            print("I'm here")
            collectionView.reloadData()
        }
    }
    


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Be sure to cast the following to your custom Cell class using “as!”
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! ImageCell
        
        cell.backgroundColor = UIColor.black
        let currentImageName = self.imageData[self.imageCounter]
        self.imageCounter += 1
        if self.imageCounter >= self.imageData.count {
            self.imageCounter = 0
        }
        
        // reference to my variable "image" in ImageCell.swift
        cell.image.image = UIImage(named:currentImageName)!
    
        return cell
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
        -> Int {
            
            return self.imageData.count
    }
    
    //
    // Set the size of the collectionViewCell so that
    // there are NUMBER_IMAGES_PER_ROW images per row.
    // For this HW, NUMBER_IMAGES_PER_ROW = 3
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width/NUMBER_IMAGES_PER_ROW
        let cellHeight = cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayImageSegue" {
            let destination = segue.destination as? DisplayImageViewController
            destination?.delegate = self
            if isFromPicker {
                destination?.image = image
                destination?.isFromPicker = true
            } else {
                if let cell = sender as? ImageCell {
                    destination?.image = cell.image.image
                }
            }
            isFromPicker = false
        }
    }
    
    //
    // Add an image from system photo library to CollectionView
    //
    @IBAction func buttonOrganizePressed(_ sender: Any) {
        // whole picture, not an edited version
        picker.allowsEditing = false
        picker.delegate = self
        // set the source to be the Photo Library
        picker.sourceType = .photoLibrary;
        
        // present the picker in a full screen popover
        //picker.modalPresentationStyle = .fullScreen
        
        present(picker, animated: true, completion: nil)
    }
    
    //
    // Add an image taken from camera to CollectionView
    //
    @IBAction func buttonCameraPressed(_ sender: Any) {
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) {
                    accessGranted in
                    guard accessGranted == true else { return }
                }
            case .authorized:
                break
            default:
                print("Access denied")
                return
            }
            
            // whole picture, not an edited version
            picker.allowsEditing = false
            
            // set the source to be the camera
            picker.sourceType = .camera
            
            // set camera mode to "photo"
            picker.cameraCaptureMode = .photo
            
            present(picker, animated: true, completion: nil)
            
        } else {
            noCamera()
        }
    }
    
    // if no camera is available on the device, pop up an alert.
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    // Save image taken by camera to MyCollections
    func saveImage(_ sender: AnyObject) {
        
        //let imageName = NSDate() as Date
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // info contains a *dictionary* of information about the selected media, including:
        //  - metadata
        //  - a user-edited image (if the .allowsEditing property is set to True)
        
        // get the selected picture:  this is the only part of info we're interested in here
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        image = chosenImage
        isFromPicker = true
        performSegue(withIdentifier: "displayImageSegue", sender: self)
        // dismiss the popover
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // dismiss the popover
        dismiss(animated: true, completion: nil)
        
    }
    
}

