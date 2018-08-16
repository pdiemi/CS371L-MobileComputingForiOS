//
//  ViewController.swift
//  PhamDiemi-HW10
//
//  Created by Pham, Diemi on 8/15/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

let NUMBER_IMAGES_PER_ROW: CGFloat = 3

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
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

    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            if let cell = sender as? ImageCell {
                destination?.image = cell.image.image
            }
        }
    }

}

