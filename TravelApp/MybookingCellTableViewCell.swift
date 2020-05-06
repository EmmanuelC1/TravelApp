//
//  MybookingCellTableViewCell.swift
//  TravelApp
//
//  Created by Athena Raya on 5/3/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit

class MybookingCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var bookingDateLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
