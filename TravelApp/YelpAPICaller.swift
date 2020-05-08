//
//  YelpAPICaller.swift
//  TravelApp
//
//  Created by Howard Aguilar on 4/10/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import CDYelpFusionKit
import UIKit

final class CDYelpFusionKitManager: NSObject {

    static let shared = CDYelpFusionKitManager()

    var apiClient: CDYelpAPIClient!

    func configure() {
        // How to authorize using your clientId and clientSecret
        self.apiClient = CDYelpAPIClient(apiKey: "i3TOID1CyXwZ5JMTZo1fC1GJcveK9Ef24uFHjtQ4pK07IetifbUtySQdXdO_z6Kj2hxPOkoEqgBoQJaWn87YFD7l3MfFUPtp5lcyixveTVsww_0xZriXt0AOzay1XnYx")
    }
}

