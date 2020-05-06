//
//  BookingViewController.swift
//  TravelApp
//
//  Created by Howard Aguilar on 4/12/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//
import UIKit
import AlamofireImage
import Parse


class BookingViewController: UIViewController, UINavigationBarDelegate, UIImagePickerControllerDelegate{
    
   
    @IBOutlet weak var MybookingBtn: UIButton!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var restaurantView: UIImageView!
    
    // MybookingView
    
    
    var booking = [PFObject]() // empty array
    
    var choice: [String:Any]!
    let datePicker = UIDatePicker()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        businessName.text = choice["name"] as? String
        businessName.sizeToFit()
        
        //date
        createDatePicker()
       
        
        let posterUrl = URL(string: ((choice["image_url"] as? String)!))
               restaurantView.af_setImage(withURL: posterUrl!)
        
        // alert connection
            
    }
    //alert func
    @objc func showAlert(){
        let alertView = UIAlertController(title:"Thankyou!", message: "Your booking was successful.", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            print( "done")

        }))
        // present alert view
        self.present(alertView, animated: true, completion: nil)

        }
    
    
    

    
     // done btn for Parse data
    @IBAction func confirmButton(_ sender: Any) { // set up schema /
        
        let booking = PFObject(className: "ConfirmBookings") // name of table
        
        booking["dateTime"] = inputTextField.text!
        booking["restaurantName"] = businessName.text!
        booking["username"] = PFUser.current()!
        
        
        let imageData = restaurantView.image!.pngData()
        let file = PFFileObject(name: "image.png", data:imageData!)
        
        booking["image"] = file
       
        
        booking.saveInBackground{(success, error) in
           
            if success {
                self.dismiss(animated: true, completion: nil)
                
                print("saved Booking!")
              
                
            }else{
                    print("error!")
                 }
            }
        
      
        
        
         }
    
    
    //********* create picker function*****************
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
    
    @objc func donePressed(){ // done button on date picker
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
