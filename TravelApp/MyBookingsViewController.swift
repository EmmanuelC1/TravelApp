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
    
    let myRefreshControl = UIRefreshControl()
  
    
          var bookings = [PFObject]() //  empty array of bookings
          
                 override func viewDidLoad() {
                 super.viewDidLoad()
                 
                 tableView.delegate = self
                 tableView.dataSource = self
                  
                    myRefreshControl.addTarget(self, action: #selector(viewDidAppear(_:)
                        ), for: .valueChanged)
                    tableView.refreshControl = myRefreshControl
                
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
                               self.myRefreshControl.endRefreshing()
                               // get the query
                               // store the data
                               //reload the table view
                            
                           }
                           
                       }
                    
              
                  }
    // swipe action
            func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let delete = UIContextualAction(style: .destructive, title: "Cancel") { (contextualAction, view, actionPerformed: @escaping (Bool)-> ()) in
                
                let alert = UIAlertController (title:"Cancel Booking" , message: "Are you sure you want to cancel this booking?", preferredStyle: .alert)
                // adding action
                
                alert.addAction(UIAlertAction(title: "Keep", style: .cancel, handler: { (alertAction) in actionPerformed(false)
                }))
                
                alert.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: { (alertAction) in
                    //perform deletion
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MybookingCellTableViewCell") as! MybookingCellTableViewCell // grabing cell and getting access to obtlets
                    let booked = self.bookings[indexPath.row] // PF object - grab data
                    booked.deleteInBackground()
                    actionPerformed(true)
                    
                }))
                self.present(alert, animated: true)
              
                }
          
            return UISwipeActionsConfiguration(actions: [delete])
            }
    
    
          
            

          
          // requried function for datasource #1
             func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
              
              
              return bookings.count
               
           }
            
          // required functions for data source #2 - attaching data
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    
               let cell = tableView.dequeueReusableCell(withIdentifier: "MybookingCellTableViewCell") as! MybookingCellTableViewCell // grabing cell and getting access to obtlets
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
              cell.photoView.layer.cornerRadius = 2.5
              cell.photoView.layer.borderWidth = 4
              cell.photoView.layer.borderColor = UIColor.darkGray.cgColor
                       
              print("successful")
                
             
                          
              cell.layer.borderWidth = 2
              cell.layer.borderColor = UIColor.gray.cgColor
                
                
              return cell
              
              
                   }
            
           
           
            
          
         
            
          
              
             
                      
          


                }
