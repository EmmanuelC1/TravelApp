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
        self.apiClient = CDYelpAPIClient(apiKey: "RSD2X0YWowVTNALT-dkaLWL78XuuQ4VKvGNeaPzTyvBJek46dcEBr6nNk9E3nxDNc_QkD0COEtsC99m91Dc-wqC6_fsqQ54VVVkgxfsbe1OWglnCVFx-PY1fIOOOXnYx")
    }
}

