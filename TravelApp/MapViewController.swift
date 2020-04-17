//
//  MapViewController.swift
//  TravelApp
//
//  Created by Jorge Gaytan on 4/10/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit
import MapKit
//import MessageInputBar
import CoreLocation

//struct Stadium {
//    var name: String
//    var latitude: CLLocationDegrees
//    var longitude: CLLocationDegrees
//}

class MapViewController: ViewController, CLLocationManagerDelegate {
    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var MapView: MKMapView!
    
    //let restaurant = true
    var locationManager:CLLocationManager!
    //let searchBar = MessageInputBar()
    //var showsSearchBar = false
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkLocationStatus()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.stopUpdatingLocation()

        } else {
            print("Error with location")
        }
        
//        searchBar.inputTextView.placeholder = "Add a comment..."
//        searchBar.sendButton.title = "Search"
//        searchBar.delegate = self
        
        
     
    }
//    @objc func keyboardWillBeHidden(note: Notification){
//           searchBar.inputTextView.text = nil
//           showsSearchBar = false
//           becomeFirstResponder()
//
//       }
//    override var inputAccessoryView: UIView?{
//        return searchBar
//    }
//    override var canBecomeFirstResponder: Bool{
//        return showsSearchBar
//    }
//    func checkLocationStatus(){
//
//    }
    
    @IBAction func onSearch(_ sender: Any) {
         
        let userSearch = searchInput.text as! String
        //let userLat = MapView.userLocation.location?.coordinate.latitude
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
//        if userSearch != nil {
//            userSearch = searchInput.text!
//        }
        CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: userSearch, location: "Los Angeles", latitude: nil, longitude: nil, radius: 10000, categories: nil, locale: .english_unitedStates, limit: 10, offset: 0, sortBy: .rating, priceTiers: [.oneDollarSign, .twoDollarSigns], openNow: nil, openAt: nil, attributes: nil) { (response) in
            if let response = response,
                let businesses = response.businesses,
                businesses.count > 0 {
                print(businesses.toJSON())
                print(businesses)
                
                }
            
            }
        
    }
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
          MapView.showsUserLocation = true
           
         case .denied: // Show alert telling users how to turn on permissions
         break
        case .notDetermined:
          locationManager.requestWhenInUseAuthorization()
          MapView.showsUserLocation = true
        case .restricted: // Show an alert letting them know what’s up
         break
        case .authorizedAlways:
         break
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
}
