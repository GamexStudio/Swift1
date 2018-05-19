//
//  StudentCell.swift
//  DatabaseSample
//
//  Created by   on 28/04/18.
//  Copyright © 2018  . All rights reserved.
//

import UIKit

class StudentCell: UITableViewCell {

    @IBOutlet weak var IBLblName: UILabel!
    @IBOutlet weak var IBLblMarks: UILabel!
    @IBOutlet weak var IBBtnEdit: UIButton!
    @IBOutlet weak var IBBtnDelete: UIButton!
    @IBOutlet weak var IBImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
