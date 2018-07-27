//
//  ViewController.swift
//  PhamDiemi-HW4
//  EID: mp43952
//  Course: CS371L
//
//  Created by Pham, Diemi on 7/27/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

public let operators = ["Add", "Subtract", "Multiply", "Divide"]

let textCellIdentifier = "textCell"
let calculatorSegueIdentifier = "calculatorVC"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // To conform to UITableViewDataSource, you must implement
    // 3 methods:
    //    1.  numberOfSectionsInTableView
    //    2.  tableView:numberOfRowsInSection
    //    3.  tableView:cellForRowAtIndexPath
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
        return operators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = operators[row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == calculatorSegueIdentifier,
            let destination = segue.destination as? CalculatorViewController,
            let operatorIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.myOperator = operators[operatorIndex]
        }
    }
}

