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
    
      var bookings = [PFObject]() //  empty array of post
     // var selectedPost : PFObject!
    
    
      override func viewDidLoad() {
           super.viewDidLoad()
           
          
           tableView.delegate = self
           tableView.dataSource = self
           
           // Do any additional setup after loading the view.
       }
      
      
      // requried function
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
          return 0
         
        
          
          
      }
   
        //  func numberOfSections(in tableView: UITableView) -> Int {
        //  return posts.count
     // }
      
    // required functions
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              
         let cell = tableView.dequeueReusableCell(withIdentifier: "MybookingCellTableViewCell") as! MybookingCellTableViewCell
                  
        let booked = bookings[indexPath.row]
        
        let user = booked["username"] as! PFUser
        cell.userName.text = user.username
        
        
       cell.bookingDateLabel.text = booked["dateTime"] as! String
                  
        let imageFile = booked["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
                  
        cell.photoView.af_setImage(withURL: url)
                  
         return cell
        
             }
      
     
     
      
      override func viewDidAppear(_ animated: Bool) {
             super.viewDidAppear(animated)
             
             let query = PFQuery(className: "Bookings") //  query for parse
          
             query.includeKeys(["username"]) // dot . notation
             query.limit = 20 // last 20
             
             query.findObjectsInBackground{ (bookings, error) in
                 if bookings != nil {
                     self.bookings = bookings! //
                     self.tableView.reloadData()
                     // get the query
                     // store the data
                     //reload the table view
                 }
                 
             }
          
    
        }
   
      
    
        
       
                
    


}

