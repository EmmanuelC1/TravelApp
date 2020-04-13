//
//  RestaurantTableViewCell.swift
//  TravelApp
//
//  Created by Athena Raya on 4/12/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantImageView : UIImageView!
    @IBOutlet weak var markeImageView : UIImageView!
    @IBOutlet weak var restaurantNameLabel : UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
