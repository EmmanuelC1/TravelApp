//
//  YelpApINetworkServices.swift
//  TravelApp
//
//  Created by Athena Raya on 4/13/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import Foundation
import Moya
// www.raywenderlich.com/5121-moya-tutorial-for-ios-getting-started#toc-anchor-002 - Documentation
// need:
// 1.base 2. path 3. methond 4 sample data. 5. task 6. validataionType 7. headers
#error("Enter a Yelp API key by visiting yelp.com/developers then delete this error.")
private let apiKey = "ADZ2yfBvuWk-_dwVJ4NSgI7EFigaLJ0MU0OA6Gxq-pmqxVUG66A3oG_P9HhpRKHnk32PK8-_xcUVyhN8kanXRs_I7jlhMJ9Y5_bEIBYRruHYXkLsWCfVI9xZXtyLXnYx"

enum YelpService {
    enum BusinessesProvider: TargetType { // nested enum
        case search(lat: Double, long: Double) // long and lati
        case details(id: String)
        
        var baseURL: URL {
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }

        var path: String {
            switch self {
            case .search:
                return "/search"
            case let .details(id):
                return "/\(id)"
            }
        }

        var method: Moya.Method {
            return .get
        }

        var sampleData: Data { // for testing
            return Data()
        }

        var task: Task {
            switch self {
            case let .search(lat, long):
                return .requestParameters(
                    parameters: ["latitude": lat, "longitude": long, "limit": 10], encoding: URLEncoding.queryString)
            case .details:
                return .requestPlain
            }
            
        }

        var headers: [String : String]? {
            return ["Authorization": "Bearer \(apiKey)"]
        }
    }
}


