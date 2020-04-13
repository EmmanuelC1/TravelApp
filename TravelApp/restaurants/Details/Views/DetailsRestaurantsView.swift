//
//  DetailsRestaurantsView.swift
//  TravelApp
//
//  Created by Athena Raya on 4/12/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit
import MapKit

@IBDesignable class DetailsRestaurantsView: Baseview{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func handleControl(_ sender: UIPageControl){
        
    }
    
}
