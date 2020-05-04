//
//  MapViewController.swift
//  TravelApp
//
//  Created by Jorge Gaytan on 4/10/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit
import MapKit

import CoreLocation
import CDYelpFusionKit
import Parse


class MapViewController: ViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var MapView: MKMapView!
    
    var locationManager:CLLocationManager!
    var lat: Double!
    var long: Double!
    var businesses = [[String:Any]]()
    var chosen: [String:Any]?

    

    
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return (true)
       }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           let userLocation: CLLocation = locations[0] as CLLocation
           
           guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
           
           //print("locations = \(locValue.latitude) \(locValue.longitude)")
            lat  = locValue.latitude
            long = locValue.longitude
           animateMap(userLocation)
            //print("locations = \(locValue.latitude) \(locValue.longitude)")
       }
       
       func animateMap(_ location: CLLocation){
           let region = MKCoordinateRegion.init(center: location.coordinate,latitudinalMeters: 10000,longitudinalMeters: 10000)
           MapView.setRegion(region, animated: true)
       }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    @IBAction func onSearch(_ sender: Any) {
        let userSearch = searchInput.text as! String
        
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
        print(userSearch)
        CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: userSearch, location: nil, latitude: lat, longitude: long, radius: 10000, categories: nil, locale: .english_unitedStates, limit: 10, offset: 0, sortBy: .rating, priceTiers: [.oneDollarSign, .twoDollarSigns], openNow: nil, openAt: nil, attributes: nil) { (response) in
            
            if let response = response,
                let businesses = response.businesses,
                businesses.count > 0 {
                //print(businesses)
                //print(businesses.toJSON())
                    
                self.businesses = businesses.toJSON()
                print(userSearch + " in if statement")
                print(self.businesses)
                self.createMarker(businesses: self.businesses)
            }
            else {
                print("else statement")
            }
    
        }
        
    }
    
    
    func createMarker(businesses: [[String : Any]]){
        MapView.removeAnnotations(MapView.annotations)

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

    

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
       func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
       
        
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
        chosen = business.first
        self.performSegue(withIdentifier: "selectedMapPin", sender: nil)
     
    }
   
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
               
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
       
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = loginViewController
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
           
           
           if let chosen = chosen,let detailViewController = segue.destination as? DetailsViewController{
               detailViewController.choice = chosen
           }
          
       }
}
