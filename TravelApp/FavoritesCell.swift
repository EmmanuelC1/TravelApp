//
//  FavoritesCell.swift
//  TravelApp
//
//  Created by Emmanuel Castillo on 4/21/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    @IBOutlet weak var businessLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
