//
//  textNoteTableViewCell.swift
//  PhamDiemi-HW5
//  EID: mp43952
//  Course: CS371L
//
//  Created by Pham, Diemi on 7/30/18.
//  Copyright © 2018 Pham, Diemi. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelNotes: UILabel!
    
    var note: Note?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
