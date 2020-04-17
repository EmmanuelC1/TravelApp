//
//  HomeViewController.swift
//  TravelApp
//
//  Created by Howard Aguilar on 4/11/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit
import Parse
import CDYelpFusionKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var business = [[String:Any]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return business.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        
        let choice = business[indexPath.row]
        let name = choice["name"] as! String
        
        cell.restaurantNameLabel.text = name
        
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
        CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: "Food", location: "San Francisco", latitude: nil, longitude: nil, radius: 10000, categories: [.restaurants], locale: .english_unitedStates, limit: 10, offset: 0, sortBy: .rating, priceTiers: [.oneDollarSign, .twoDollarSigns], openNow: nil, openAt: nil, attributes: nil) { (response) in
            
            if let response = response,
                let businesses = response.businesses,
                businesses.count > 0 {
                //print(businesses)
                //print(businesses.toJSON())
                    
                self.business = businesses.toJSON()
                //print(self.business)
                self.tableView.reloadData()
                
            }
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let choice = business[indexPath.row]
        
        //Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! DetailsViewController
        detailsViewController.choice = choice
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}
