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
    @IBOutlet weak var businessAvailability: UILabel!
    //Need to configure extra label & Book Button
    @IBOutlet weak var bookButton: UIButton!
    
    var choice: [String:Any]!
    var addy: [String:Any]!
    var details: [String:Any]!
    var details2: [[String:Any]]!
    var details3: [[String:Any]]!
    var unique:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Obtain unique business ID
        let unique = choice["id"] as? String
        
        // Do any additional setup after loading the view.
        businessName.text = choice["name"] as? String
        businessName.sizeToFit()
        
        let posterUrl = URL(string: ((choice["image_url"] as? String)!))
        businessImage.af_setImage(withURL: posterUrl!)
        
        // Address displays but likely unsafe.
        // Prints check values of my dictionaries/arrays
        //print(choice["location"]!)
        // Get just the display_address portion out of location, so basically
        // businessChoice["location"]["display_address"]
        addy = choice["location"] as? [String:Any]
        //print(addy["display_address"]!)
        // This displays the address, but with [] around and likely un-safe
        businessAddress.text = "\(String(describing: addy["display_address"]!))"
        businessAddress.sizeToFit()
        
        businessPhone.text = choice["display_phone"] as? String
        if choice["display_phone"] as? String == ""{
            businessPhone.text = "No number available"
        }
        // Testing business hours
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
        CDYelpFusionKitManager.shared.apiClient.fetchBusiness(forId: unique,locale: nil) { (business) in

          if let business = business {
            self.details = business.toJSON()
            //print(business)
            //print("DIVIDER")
            //print(self.details!)
            //print("DIVIDER")
            //print(self.details["hours"]!)
            self.details2 = self.details["hours"] as? [[String:Any]]
            //print("DIVIDER")
            //print(self.details2[0])
            if self.details2[0]["is_open_now"] as! Bool {
                self.businessAvailability.text = "Currently Open"
            } else {
                self.businessAvailability.text = "Currently Closed"
            }
            self.details3 = self.details2[0]["open"] as? [[String:Any]]
            print(self.details3!)
            print(self.details3[0]["start"]!)
          }
        }
        //print (self.details2[0])
        // End of testing business hours
        
        //print(self.choice!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //Pass the selected movie to the details view controller
        let bookingsViewController = segue.destination as! BookingViewController
        bookingsViewController.choice = choice
        
    }

}
