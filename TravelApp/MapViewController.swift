//
//  MapViewController.swift
//  TravelApp
//
//  Created by Jorge Gaytan on 4/10/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: ViewController {

    @IBOutlet weak var MapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkLocationStatus()
        // Do any additional setup after loading the view.
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            print("Error with location")
        }
    }
    
//    func checkLocationStatus(){
//
//    }
    
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
