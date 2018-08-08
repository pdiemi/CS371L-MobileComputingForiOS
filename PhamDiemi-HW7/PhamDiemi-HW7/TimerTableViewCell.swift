//
//  TimerTableViewCell.swift
//  PhamDiemi-HW7
//  EID: mp43952
//  Course: CS371L
//
//  Created by Pham, Diemi on 8/7/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

class Timer: Equatable {
    var event: String
    var location: String
    var remainingTime: Int64
    
    init(e: String, l: String, t: Int64) {
        event = e
        location = l
        remainingTime = t
    }
    
    func getRemainingTime () -> Int64 {
        return remainingTime
    }
    
    func update(t: Int64) {
        remainingTime = t
    }
    
    static func == (lhs: Timer, rhs: Timer) -> Bool {
        return lhs.event == rhs.event && lhs.location == rhs.location
    }
}

class TimerTableViewCell: UITableViewCell {

    @IBOutlet weak var labelEvent: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelRemainingTime: UILabel!
    
    var timer: Timer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
