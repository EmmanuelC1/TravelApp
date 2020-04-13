//
//  AppDelegate.swift
//  TravelApp
//
//  Created by Emmanuel Castillo on 3/9/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit
import CoreLocation
import Parse
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


 let window = UIWindow()
 // location service
    let locationService = LocationService() // adding the location service
    //reference to storyboard
    let storybord = UIStoryboard(name: "Main", bundle: nil)
    let service  = MoyaProvider<YelpService.BusinessesProvider>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "TravelApp"
                configuration.server = "https://travel-app-cst495.herokuapp.com/parse"
            })
        )
      //test
        
        service.request(.search(lat: 42.361145, long: -71.057083)) { (result) in
            switch result{
            case .success(let response):
                print(try? JSONSerialization.jsonObject(with: response, options: []))
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        // setting the root
        switch locationService.status { // when we dont have access to the user location we want to launch the new your location view.
        case .notDetermined, .denied, .restricted:
            let locationViewController = storybord.instantiateViewController(identifier: "LocationViewController") as? LocationViewController
            
            locationViewController?.locationService = locationService
            window.rootViewController = locationViewController
        default:
            assertionFailure()
        }
        window.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

