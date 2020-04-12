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

struct Stadium {
    var name: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
}

class MapViewController: ViewController {
    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var MapView: MKMapView!
    
    //let restaurant = true
    let locationManager = CLLocationManager()
    //let searchBar = MessageInputBar()
    //var showsSearchBar = false
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkLocationStatus()
        // Do any additional setup after loading the view.
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
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

}
