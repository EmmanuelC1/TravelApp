//
//   Baseview.swift
//  TravelApp
//
//  Created by Athena Raya on 4/12/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit

@IBDesignable class Baseview: UIView {
    
    override init(frame: CGRect){ 
        super.init(frame: frame)
        self.configure()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    private func configure(){
        
    }
}
