//
//  BookingViewController.swift
//  TravelApp
//
//  Created by Howard Aguilar on 4/12/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import UIKit
import AlamofireImage


class BookingViewController: UIViewController {
    
    @IBOutlet weak var businessName: UILabel!
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputTimeTextField: UITextField!
    
    
    @IBOutlet weak var restaurantView: UIImageView!
    
    var choice: [String:Any]!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        businessName.text = choice["name"] as? String
        businessName.sizeToFit()
        
        //date
        createDatePicker()
       
        
        let posterUrl = URL(string: ((choice["image_url"] as? String)!))
               restaurantView.af_setImage(withURL: posterUrl!)
    
    }
    
    func createDatePicker(){
        
       
        
       inputTextField.textAlignment = .center
        
       //toolbar
       let toolbar = UIToolbar ()
       toolbar.sizeToFit()
        
       //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar to keyboard
        inputTextField.inputAccessoryView = toolbar
        
        //assign date picker to the texfield
        inputTextField.inputView = datePicker
        
        //datepicker to only show dates and time.
        datePicker.datePickerMode = .dateAndTime
        
        }
    
    @objc func donePressed(){
         // formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        // assigning user text to textField
        
        inputTextField.text = formatter.string(from: datePicker.date)
        
       
        self.view.endEditing(true)
    }
    
  
    
  
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
