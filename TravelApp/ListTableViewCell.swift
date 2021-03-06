//
//  ListTableViewCell.swift
//  TravelApp
//
//  Created by Howard Aguilar on 4/16/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    
    override func awakeFromNib() {
               super.awakeFromNib()
               // Initialization code
           }

           override func setSelected(_ selected: Bool, animated: Bool) {
               super.setSelected(selected, animated: animated)

               // Configure the view for the selected state
           }

       }
