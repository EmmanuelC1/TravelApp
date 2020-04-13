//
//  LocationView.swift
//  TravelApp
//
//  Created by Athena Raya on 4/12/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit

@IBDesignable class LocationView: Baseview {
    
    @IBOutlet weak var allowButton: UIButton!
    @IBOutlet weak var denyButton: UIButton!
    
    // call back
    var didTapAllow: (()-> Void)?
    
    @IBAction func allowAction(_sender: UIButton){
        didTapAllow?()
        
    }
    @IBAction func denyAction(_sender: UIButton){
           
       }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
