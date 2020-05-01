//
//  DetailsViewController.swift
//  TravelApp
//
//  Created by Howard Aguilar on 4/11/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit
import AlamofireImage
import CoreLocation

class DetailsViewController: UIViewController {
    
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
    var details: [String:Any]!
    var details2: [[String:Any]]!
    var details3: [[String:Any]]!
    var unique:String!
    // Time variables for the week
    @IBOutlet weak var sunHours: UILabel!
    @IBOutlet weak var monHours: UILabel!
    @IBOutlet weak var tueHours: UILabel!
    @IBOutlet weak var wedHours: UILabel!
    @IBOutlet weak var thuHours: UILabel!
    @IBOutlet weak var friHours: UILabel!
    @IBOutlet weak var satHours: UILabel!
    
    
    var weekdays = ["N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Obtain user lat & long
        
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
            print(business)
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
    
    // BEGIN OF UNNECESSARY CODE
    /*var start = element["start"] as! String
    var end = element["end"] as! String
    
    start.insert(":", at: start.index(start.startIndex, offsetBy: 2))
    end.insert(":", at: end.index(end.startIndex, offsetBy: 2))
    print(start)
    print(end)*/ //WAS USING THIS TO INPUT ":" BUT WAS UNNECESSARY
    
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
        sunHours.text = weekdays[0]
        monHours.text = weekdays[1]
        tueHours.text = weekdays[2]
        wedHours.text = weekdays[3]
        thuHours.text = weekdays[4]
        friHours.text = weekdays[5]
        satHours.text = weekdays[6]
        
        //print("END OF TIMES FUNCTION")
    }
    
    // Segue to booking screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //Pass the selected movie to the details view controller
        let bookingsViewController = segue.destination as! BookingViewController
        bookingsViewController.choice = choice
        
    }

}
