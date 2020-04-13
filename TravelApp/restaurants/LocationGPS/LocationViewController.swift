//
//  LocationViewController.swift
//  TravelApp
//
//  Created by Athena Raya on 4/12/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var locationView: LocationView!
    // adding locaton service
    var locationService : LocationService? 

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //setting callback for location view when tap is touched
        locationView.didTapAllow = { [weak self] in
            print("tapped allowed") // check console- works
            self?.locationService?.requestLocationAuthorization()
        }
        locationService?.didChangeStatus = { [weak self] success in
            if success {
                self?.locationService?.getlocation()
            }
        }
        
        locationService?.newLocaton = { [weak self] result in
            
            switch result {
            case .success(let location):
                print(location)
            case .failure(let error):
                assertionFailure("Error getting the users location \(error)")
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
