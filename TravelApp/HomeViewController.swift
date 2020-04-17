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
    
    let choices = ["Restaurants", "Theaters", "Museums"]
    var counter = 0
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        
        cell.categories1NameLabel.text = choices[counter]
        counter += 1
        
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
        
        //Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let word = choices[indexPath.row]
        
        //Pass the selected movie to the details view controller
        let ListViewController = segue.destination as! ListViewController
        ListViewController.word = word
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}
