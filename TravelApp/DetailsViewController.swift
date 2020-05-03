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
    
    // Outlets for labels
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var businessAddress: UILabel!
    @IBOutlet weak var businessPhone: UILabel!
    @IBOutlet weak var businessAvailability: UILabel!
    //Need to configure extra label & Book Button
    @IBOutlet weak var bookButton: UIButton!
    // Parsing dictionaries
    var choice: [String:Any]!
    var addy: [String:Any]!
    // Extra parsing for hours
    var details: [String:Any]!
    var details2: [[String:Any]]!
    var details3: [[String:Any]]!
    var unique:String!
    // Time outlets
    @IBOutlet weak var sunHours: UILabel!
    @IBOutlet weak var monHours: UILabel!
    @IBOutlet weak var tueHours: UILabel!
    @IBOutlet weak var wedHours: UILabel!
    @IBOutlet weak var thuHours: UILabel!
    @IBOutlet weak var friHours: UILabel!
    @IBOutlet weak var satHours: UILabel!
    // Time list for all week hours
    var weekdays = ["N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // view page details
        bookButton.layer.cornerRadius = 10.0
        posterView.layer.cornerRadius = 20
        posterView.clipsToBounds = true
        posterView.layer.borderColor = UIColor.white.cgColor
        posterView.layer.borderWidth = 4
        businessName.layer.cornerRadius = 20.0
        
        // Obtain unique business ID
        let unique = choice["id"] as? String
        
        
        // EXTRA CODE HERE TO SEARCH BY BUSINESS ID, replace previous dictionary pass in

        // Do any additional setup after loading the view.
        businessName.text = choice["name"] as? String
        businessName.sizeToFit()
        
        let posterUrl = URL(string: ((choice["image_url"] as? String)!))
        businessImage.af_setImage(withURL: posterUrl!)
        
        let posterUrl2 = URL(string: ((choice["image_url"] as? String)!))
        posterView.af_setImage(withURL: posterUrl2!)
        
        // Address displays but likely unsafe.
        // Prints check values of my dictionaries/arrays
        //print(choice["location"]!)
        // Get just the display_address portion out of location, so basically
        // businessChoice["location"]["display_address"]
        addy = choice["location"] as? [String:Any]
        //print (addy["display_address"]!)
        // This displays the address, but with [] around and likely un-safe
        businessAddress.text = "\(String(describing: addy["display_address"]!))"
        //businessAddress.text = addy["display_address"] as? String // This does not work, displays nothing
        businessAddress.sizeToFit()
        
        businessPhone.text = choice["display_phone"] as? String
        if choice["display_phone"] as? String == ""{
            businessPhone.text = "No number available"
        }
        // Testing business hours by using YelpAPI for business details
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
        CDYelpFusionKitManager.shared.apiClient.fetchBusiness(forId: unique,locale: nil) { (business) in
          // If business details are found, break apart the response into different types of dictionaries, depending on response
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
            if self.details2 != nil, let isOpen = self.details2[0]["is_open_now"] as? Bool {
                self.businessAvailability.text = isOpen ? "Currently Open" : "Currently Closed"
                self.details3 = self.details2[0]["open"] as? [[String:Any]]
                //self.times(details: self.details3)
            } else if self.details2 == nil {
                self.businessAvailability.text = "Not Available"
            } else {
                self.businessAvailability.text = "Currently Closed"
            }
            
            if self.details3 != nil, let hoursExist = self.details3 {
                self.times(details: hoursExist)
            }
            //self.details3 = self.details2[0]["open"] as? [[String:Any]]
            //print(self.details3!)
            //self.times(details: self.details3)
            //print(self.details3[0]["start"]!)
            // Pass in details3 to a function that interprets the days and times?
          }
        }
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
    
    // Function to convert times from 24hr to 12hr format
    func times(details: Array<Dictionary<String, Any>>) -> Void {

        for element in details {
            // Convert 4 digit 24hr time to 12hr time & Assign times to weekdays array
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HHmm"
            let date = dateFormatter.date(from: element["start"] as! String)
            dateFormatter.dateFormat = "h:mma"
            var Date12 = dateFormatter.string(from: date!)
            //print ("12 hour formatted start:", Date12)
            weekdays[element["day"] as! Int] = Date12
            
            dateFormatter.dateFormat = "HHmm"
            let date2 = dateFormatter.date(from: element["end"] as! String)
            dateFormatter.dateFormat = "h:mma"
            Date12 = dateFormatter.string(from: date2!)
            //print ("12 hour formatted end:", Date12)
            weekdays[element["day"] as! Int] += "-"+Date12
            
            // Prints to check contents
            //print(weekdays[element["day"] as! Int])
            //print("Content of entire day")
            //print(element)
        }
        // Assign hours to their labels
        sunHours.text = weekdays[0]
        monHours.text = weekdays[1]
        tueHours.text = weekdays[2]
        wedHours.text = weekdays[3]
        thuHours.text = weekdays[4]
        friHours.text = weekdays[5]
        satHours.text = weekdays[6]
        //print("END OF TIMES FUNCTION")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //Pass the selected movie to the details view controller
        let bookingsViewController = segue.destination as! BookingViewController
        bookingsViewController.choice = choice
        
    }

}
