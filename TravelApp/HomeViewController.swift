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
import MapKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    // Variable that holds our categories
    let choices = ["Restaurants", "Fast Food", "Theaters", "Museums", "Laundry", "Clothing", "Shopping", "Gasoline"]
    var counter = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        
        cell.categories1NameLabel.text = choices[indexPath.row]
        counter += 1
        
        cell.layer.cornerRadius = cell.frame.height / 2.0
        cell.layer.borderWidth = 1
        
        return cell
    }

  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        

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
        
        //Find the selected cell
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let word = choices[indexPath.row]
        
        //Pass the selected cell to the details view controller
        let ListViewController = segue.destination as! ListViewController
        ListViewController.word = word
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK: onLogoutButton
    // Log user out when user clicks on Logout button
    @IBAction func onLogout(_ sender: Any) {
         PFUser.logOut()
                
         let main = UIStoryboard(name: "Main", bundle: nil)
         let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
         let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
         sceneDelegate.window?.rootViewController = loginViewController
    }
    
}
