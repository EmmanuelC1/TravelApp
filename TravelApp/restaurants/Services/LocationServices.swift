//
//  LocationServices.swift
//  TravelApp
//
//  Created by Athena Raya on 4/13/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import Foundation
import CoreLocation

enum Result<T> {
    case success(T)
    case failure(Error)
}

final class LocationService: NSObject {
    
    private let manager: CLLocationManager
    
    init(manager: CLLocationManager = .init()){
        self.manager = manager
        super.init()
        manager.delegate = self
        
    }
    
    // call back - taking in result type of CLLocation which is an object responsible for holding coorinated
    var newLocaton: ((Result<CLLocation>) -> Void)?
    var didChangeStatus: ((Bool) -> Void)?
    // lets us know the current authorization of the user. Did they give us access.
    var status: CLAuthorizationStatus{
        return CLLocationManager.authorizationStatus()
    }
    
    // getting location auth
    func requestLocationAuthorization(){
        manager.requestWhenInUseAuthorization() // ask when in use
    }
    // ask to get location updates
    func getlocation(){
        manager.requestLocation() // fires once and grabs user location. get new location 
    }
    
    
}
extension LocationService: CLLocationManagerDelegate {
    // if it fails
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        newLocaton?(.failure(error))
    
    }
    // gives user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.sorted(by: {$0.timestamp > $1.timestamp}).first {
            newLocaton?(.success(location))
        }
        
    }
    // check the authorization status
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .restricted, .denied:
            didChangeStatus?(false)
        default:
            didChangeStatus?(true)
        }
        
    }
}
