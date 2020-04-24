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
import CDYelpFusionKit

//struct Stadium {
//    var name: String
//    var latitude: CLLocationDegrees
//    var longitude: CLLocationDegrees
//}

class MapViewController: ViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var MapView: MKMapView!
    
    var locationManager:CLLocationManager!
    var lat: Double!
    var long: Double!
    var businesses = [[String:Any]]()
    //let searchBar = MessageInputBar()
    //var showsSearchBar = false
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkLocationStatus()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            //checkLocationAuthorization()
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
            MapView.showsUserLocation = true
            MapView.delegate = self
            
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           let userLocation: CLLocation = locations[0] as CLLocation
           
           guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
           
           //print("locations = \(locValue.latitude) \(locValue.longitude)")
            lat  = locValue.latitude
            long = locValue.longitude
           animateMap(userLocation)
            print("locations = \(locValue.latitude) \(locValue.longitude)")
       }
       
       func animateMap(_ location: CLLocation){
           let region = MKCoordinateRegion.init(center: location.coordinate,latitudinalMeters: 1000,longitudinalMeters: 1000)
           MapView.setRegion(region, animated: true)
       }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    @IBAction func onSearch(_ sender: Any) {
         
        let userSearch = searchInput.text as! String
       
        
        //MapView.showsUserLocation = true
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
//        if userSearch != nil {
//            userSearch = searchInput.text!
//        }
        CDYelpFusionKitManager.shared.apiClient?.searchBusinesses(byTerm: userSearch, location: nil, latitude: lat, longitude: long, radius: 10000, categories: nil, locale: .english_unitedStates, limit: 10, offset: 0, sortBy: .rating, priceTiers: [.oneDollarSign, .twoDollarSigns],openNow: nil, openAt: nil, attributes: nil) { (response) in
            if let response = response,
                let businesses = response.businesses,
                businesses.count > 0 {
                self.businesses = businesses.toJSON()
                //print(self.businesses)
                
                self.createMarker(businesses: self.businesses)
                
                }
            
            }
        
    }
    
    func createMarker(businesses: [[String : Any]]){
        for business in businesses{
            let annotations = MKPointAnnotation()
            annotations.title = business["name"] as? String
            //let id = business["id"] as? Double
            guard let coordinate = business["coordinates"] as? [String:Any] else {return}
            guard let latitude = coordinate["latitude"] as? Double else {return}
            guard let longitude = coordinate["longitude"] as? Double else {return}
            annotations.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      
            //removeMarker(annotations: annotations)
            //MapView.removeAnnotation(annotations)
            MapView.addAnnotation(annotations)
            //print(id)
            
        }
    }
    func removeMarker(annotations: MKPointAnnotation){
        MapView.removeAnnotation(annotations)
    }
//    func checkLocationAuthorization(){
//        switch CLLocationManager.authorizationStatus() {
//        case .authorizedWhenInUse:
//          MapView.showsUserLocation = true
//
//         case .denied: // Show alert telling users how to turn on permissions
//         break
//        case .notDetermined:
//          locationManager.requestWhenInUseAuthorization()
//          MapView.showsUserLocation = true
//        case .restricted: // Show an alert letting them know what’s up
//         break
//        case .authorizedAlways:
//         break
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //let
        
        let business = businesses.filter { (business) -> Bool in
           // print(business)
            //print(view.annotation?.coordinate.latitude)
            //print(view.annotation?.coordinate.longitude)
            
            if let coordinates = business["coordinates"] as? [String:Any],
                let latitude = coordinates["latitude"] as? Double,
                
                let longitude = coordinates["longitude"] as? Double {
                let coordinate = view.annotation?.coordinate
                return coordinate?.latitude == latitude && coordinate?.longitude == longitude
                
            }
            return false
        }
        //print()
        print(business)
        print(view.annotation?.coordinate.latitude)
        print(view.annotation?.coordinate.longitude)
    }
   
}
