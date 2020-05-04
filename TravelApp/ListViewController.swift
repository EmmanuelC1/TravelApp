//
//  ListViewController.swift
//  TravelApp
//
//  Created by Howard Aguilar on 4/16/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit
import Parse
import CDYelpFusionKit
import MapKit
import Alamofire

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Variables for location/business
    var word:String = ""
    var business = [[String:Any]]()
    var choice: [String:Any]!
    var choice2: [Double:Any]!
    // Location variables
    var locationManager = CLLocationManager()
    // Initialization and default coordinate values
    var lat = 0.0
    var long = 0.0
    // Label if nothing is added
    @IBOutlet weak var nothing: UILabel!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return business.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        
       let choice = business[indexPath.row]
       let choice2 = business[indexPath.row]
       // let rate = choice["rating"] as! String
       let name = choice["name"] as! String
       let posterUrl = URL(string: ((choice["image_url"] as? String)!))
       let rate = choice2["rating"] as! Double
       let price = choice["price"] as! String
       //cell
       cell.layer.cornerRadius = cell.frame.height / 2.5
       cell.layer.borderColor = UIColor.red.cgColor
        
        
        
       cell.restaurantImageView.layer.cornerRadius = cell.frame.height / 2.5
       cell.restaurantImageView.layer.borderWidth = 4
       cell.restaurantImageView.layer.borderColor = UIColor.white.cgColor
        
       cell.ratingLabel.text = String(rate)
       cell.priceLabel.text = price
       cell.listNameLabel.text = name
       cell.restaurantImageView.af_setImage(withURL: posterUrl!)
        
        
      
        
       return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Works but not a consistent display
        self.nothing.text = "  Loading..."
        
        // LocationManager
        locationManager.requestWhenInUseAuthorization()
        // If authorized, find location coordinates
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Obtain user latitude & longitude while then performing the specific business YelpAPI call
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = locValue.latitude
        long = locValue.longitude
        locationManager.stopUpdatingLocation()
        // Get a list of businesses through YelpAPI call with user's location data
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
        CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: word, location: nil, latitude: lat, longitude: long, radius: 10000, categories: nil, locale: .english_unitedStates, limit: 10, offset: 0, sortBy: .rating, priceTiers: [.oneDollarSign, .twoDollarSigns], openNow: nil, openAt: nil, attributes: nil) { (response) in
            // Obtain responses in .JSON format
            if let response = response,
                let businesses = response.businesses,
                businesses.count > 0 {
                //print(businesses)
                //print(businesses.toJSON())
                    
                self.business = businesses.toJSON()
                //print(self.business)
                self.tableView.reloadData()
                self.nothing.text = ""
            }
            // If no results found, set default message
            else {
                //self.business = [["name": "No search results found."]]
                //self.tableView.reloadData()
                //print("Running")
                // Having a difficult time displaying Loading then no search results found. Displays No search results found immediately.
                // Works but not always consistent now in order
                
                if self.business.count == 0 && self.nothing.text == "  Loading..." {
                    self.nothing.text = "  No search results found."
                }
            }
        }
        // Coordinate checks
        //print("COORDINATES")
        //print(lat)
        //print(long)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let choice = business[indexPath.row]
        
        //Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! DetailsViewController
        detailsViewController.choice = choice
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func onLogout(_ sender: Any) {
         PFUser.logOut()
                
         let main = UIStoryboard(name: "Main", bundle: nil)
         let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
         let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
         sceneDelegate.window?.rootViewController = loginViewController
    }
    
}
