//
//  MyBookingsViewController.swift
//  TravelApp
//
//  Created by Athena Raya on 5/3/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit
import Parse
import Alamofire

class MyBookingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

     
    @IBOutlet weak var tableView: UITableView!
    
      var bookings = [PFObject]() //  empty array of bookings
    
    
    
      override func viewDidLoad() {
           super.viewDidLoad()
           
          
           tableView.delegate = self
           tableView.dataSource = self
           
           // Do any additional setup after loading the view.
       }
    
    
    
    
    @IBAction func LogoutMybooking(_ sender: Any) { // works 
    
        PFUser.logOut()
            
            let main = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
            
            let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            sceneDelegate.window?.rootViewController = loginViewController
     
      }
    
    
      override func viewDidAppear(_ animated: Bool) {  // this will post the booking the user just created
                 super.viewDidAppear(animated)
                  
        
                 
                 let query = PFQuery(className: "ConfirmBookings") //  query for parse
              
                 query.includeKeys(["username"]) // dot . notation
                 query.limit = 10 // last 10
                                  query.findObjectsInBackground{ (bookings, error) in
                     if bookings != nil {
                        
                         self.bookings = bookings! //
                         self.tableView.reloadData() // give me data
                         // get the query
                         // store the data
                         //reload the table view
                     }
                     
                 }
              
        
            }
     
    override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)
          
           self.bookings.removeAll()
           self.tableView.reloadData()
           
         }
    
    
    // requried function for datasource #1
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return bookings.count
         
     }
      
    // required functions for data source #2 - attaching data
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              
         let cell = tableView.dequeueReusableCell(withIdentifier: "MybookingCellTableViewCell") as! MybookingCellTableViewCell // grabing cel and getting access to obtlets
         let booked = bookings[indexPath.row] // PF object - grab data
        
        
        // configuration of outlets:
        
        let user = booked["username"] as! PFUser //tell its a PF user
        cell.username.text = user.username
        
        
        cell.bookingDateLabel.text = booked["dateTime"] as! String
        cell.restaurantName.text = booked["restaurantName"] as? String
        
        
        let imageFile = booked["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
                  
        cell.photoView.af_setImage(withURL: url)
        
        cell.photoView.layer.borderWidth = 4
        cell.photoView.layer.borderColor = UIColor.darkGray.cgColor
                  
         return cell
        
        
             }
      
     
     
      
    
   
      
    
        
       
                
    


}

