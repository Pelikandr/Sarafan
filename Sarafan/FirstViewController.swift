//
//  FirstViewController.swift
//  Sarafan
//
//  Created by Denis Zayakin on 12/26/18.
//  Copyright © 2018 Denis Zayakin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FirstViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    //var ref: DatabaseReference!
    //ref = Database.database().reference()
    
    let ref = Database.database().reference(withPath: "sarafanbase1")
    @IBOutlet weak var eventDescriptionTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var eventCreateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // test connection
        //let db = Database.database().reference()
        //db.setValue("Hello Firebase")
        
        nameTextField.delegate = self as UITextFieldDelegate
        eventDescriptionTextView.delegate = self as UITextViewDelegate

        nameTextField.tag = 0 //теги для return
        eventDescriptionTextView.tag = 1

        //  делаем рамку textview как у textfield
        self.eventDescriptionTextView.layer.cornerRadius = 5
        self.eventDescriptionTextView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        self.eventDescriptionTextView.layer.borderWidth = 0.5
        self.eventDescriptionTextView.clipsToBounds = true
    }
    
    // функция return (клавиатура переключается на следующий textView)
    func textFieldShouldReturn(_ nameTextField: UITextField) -> Bool
    {
        if let nextField = nameTextField.superview?.viewWithTag(nameTextField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            nameTextField.resignFirstResponder()
        }
        return false
    }
    
    @IBAction func createEvent() {
        let eventsDB = Database.database().reference().child("Events") // child database
        let eventDictionary : NSDictionary = ["Sender" : Auth.auth().currentUser!.email as String!, "EventBody" : nameTextField.text!, "EventInfo" : eventDescriptionTextView.text!]
        if self.nameTextField.text != "" && self.eventDescriptionTextView.text != "" {
            eventsDB.childByAutoId().setValue(eventDictionary) {
                (error, ref) in
                if error != nil {
                    print(error!)
                }
                else {
                    let alertController = UIAlertController(title: nil, message: "Event created successfully!", preferredStyle: .alert)
                    //let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    //alertController.addAction(defaultAction)
                
                    // alert пропадает через 1,5 секунды
                    self.present(alertController, animated: true, completion: nil)
                    let when = DispatchTime.now() + 2
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alertController.dismiss(animated: true, completion: nil)
                    }
                }
            }
        } else {
            let alertController2 = UIAlertController(title: nil, message: "Name or description is empty!", preferredStyle: .alert)
            self.present(alertController2, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alertController2.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // при нажатии на свободное место скрывается клавиатура
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        eventDescriptionTextView.resignFirstResponder()
    }

    /*
    @IBAction func getMessage () {
        let messageDB = Database.database().reference().child("Events")
        messageDB.observe(.childAdded, with: { snapshot in
            let snapshotValue = snapshot.value as! NSDictionary
            let text = snapshotValue["EventBody"] as! String
            let sender = snapshotValue["Sender"] as! String
            self.messageLabel.text = text
            self.senderLabel.text = sender
        })
    }
 */
}
