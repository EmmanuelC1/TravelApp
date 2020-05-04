//
//  FavoritesViewController.swift
//  TravelApp
//
//  Created by Emmanuel Castillo on 4/21/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit
import Parse
import CDYelpFusionKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var businessIDs = [String]()
    var favoritedBusiness = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
//        getObjectIds()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        businessIDs.removeAll()
        favoritedBusiness.removeAll()
        tableView.reloadData()
        getObjectIds()
    }
    
    func getObjectIds() {
        let query = PFQuery(className: "Favorites")
        let currentUser = PFUser.current()
        query.whereKey("user", equalTo: currentUser!)
        query.findObjectsInBackground { (objects: [PFObject]?,error: Error?) in
            if let error = error {
                //Log details of the failure
                print(error.localizedDescription)
            }
            else if let objects = objects {
                // found objects
                print("Successfully retrieved \(objects.count) favorited businesses.")
                
                //Append BussinessId of each object to businessIDs from Parse
                for object in objects {
                    //print(object.objectId!)
                    self.businessIDs.append(object["businessID"] as! String)
                }
            }
            // call getBusinessDictionary Function
            self.getBusinessDictionary(businessIDs: self.businessIDs)
        }
        
    }
    
    // Function that calls Yelp API and retrieves
    // the business dictionary using the businessID
    // stored in Parse. Then reloads tableView data
    func getBusinessDictionary(businessIDs:[String]) {
        //if there are no favorites
        if businessIDs.count == 0 {
            favoritedBusiness.append(["name": "You do not have any favorites"])
            self.tableView.reloadData()
        }
        else {
            //iterate through businessIDs and call API to get dictionary for that business
            for id in businessIDs {
                usleep(250000) //will sleep for .002 seconds
                CDYelpFusionKitManager.shared.apiClient.fetchBusiness(forId: id, locale: nil) { (response) in
                    if let response = response {
                        // append business to favoritedBusiness
                        self.favoritedBusiness.append(response.toJSON())
                        self.tableView.reloadData()
                    }
                    // If no results found, set default message
                    else {
                        self.favoritedBusiness = [["name": "No search results found."]]
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = loginViewController
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritedBusiness.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell") as! FavoritesCell
        cell.isUserInteractionEnabled = true
        
        let choice = favoritedBusiness[indexPath.row]
        let name = choice["name"] as! String
        cell.businessLabel.text = name
        
        //if there are no favorites, cell cannot be clicked on (no Segue to Details)
        if name == "You do not have any favorites" {
            cell.isUserInteractionEnabled = false;
        }
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //Find the selected cell
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let choice = favoritedBusiness[indexPath.row]
        
        //Pass the selected business to the details view controller
        let detailsViewController = segue.destination as! DetailsViewController
        detailsViewController.choice = choice
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}
