//
//  DetailsViewController.swift
//  TravelApp
//
//  Created by Howard Aguilar on 4/11/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var businessAddress: UILabel!
    @IBOutlet weak var businessPhone: UILabel!
    //Need to configure extra label & Book Button
    
    var choice: [String:Any]!
    var addy: [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        businessName.text = choice["name"] as? String
        businessName.sizeToFit()
        
        let posterUrl = URL(string: ((choice["image_url"] as? String)!))
        businessImage.af_setImage(withURL: posterUrl!)
        
        // Issue trying to display address
        print(choice["location"]!)
        addy = choice["location"] as? [String:Any]
        print(addy["display_address"]!)
        //This displays the address but with extra unwanted "Optional", parenthesis and square brackets
        businessAddress.text = "\(String(describing: addy["display_address"]!))"
        //businessAddress.text = addy["display_address"] as? String
        businessAddress.sizeToFit()
        
        businessPhone.text = choice["display_phone"] as? String
        if choice["display_phone"] as? String == ""{
            businessPhone.text = "No number available"
        }
        print(self.choice!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
