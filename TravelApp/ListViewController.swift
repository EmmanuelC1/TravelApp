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
import CoreLocation

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var word:String = ""
    var business = [[String:Any]]()
    
    // Location variables
    var locationManager = CLLocationManager()
    //var lat: Double!
    //var long: Double!
    var lat = 0.0
    var long = 0.0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return business.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        
        let choice = business[indexPath.row]
        let name = choice["name"] as! String
        
        cell.listNameLabel.text = name
        
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // LocationManager
        locationManager.requestWhenInUseAuthorization()
        //var currentLoc: CLLocation!
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        /*
        // Get a list of businesses
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
        CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: word, location: nil, latitude: lat, longitude: long, radius: 10000, categories: nil, locale: .english_unitedStates, limit: 10, offset: 0, sortBy: .rating, priceTiers: [.oneDollarSign, .twoDollarSigns], openNow: nil, openAt: nil, attributes: nil) { (response) in
            
            if let response = response,
                let businesses = response.businesses,
                businesses.count > 0 {
                //print(businesses)
                //print(businesses.toJSON())
                    
                self.business = businesses.toJSON()
                //print(self.business)
                self.tableView.reloadData()
                
            }
            // If no results found, set default message
            else {
                self.business = [["name": "No search results found."]]
                self.tableView.reloadData()
            }
        }*/
            

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
    
    // Obtain user latitude & longitude
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = locValue.latitude
        long = locValue.longitude
        locationManager.stopUpdatingLocation()
        // Get a list of businesses
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
        CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: word, location: nil, latitude: lat, longitude: long, radius: 10000, categories: nil, locale: .english_unitedStates, limit: 10, offset: 0, sortBy: .rating, priceTiers: [.oneDollarSign, .twoDollarSigns], openNow: nil, openAt: nil, attributes: nil) { (response) in
            
            if let response = response,
                let businesses = response.businesses,
                businesses.count > 0 {
                //print(businesses)
                //print(businesses.toJSON())
                    
                self.business = businesses.toJSON()
                //print(self.business)
                self.tableView.reloadData()
                
            }
            // If no results found, set default message
            else {
                self.business = [["name": "No search results found."]]
                self.tableView.reloadData()
            }
        }
        
        
        print("COORDINATES")
        print(lat)
        print(long)
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

}
