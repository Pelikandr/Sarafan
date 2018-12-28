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

class FirstViewController: UIViewController {
    
    //var ref: DatabaseReference!
    //ref = Database.database().reference()
    
    let ref = Database.database().reference(withPath: "sarafanbase1")
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var retrieveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Database.database().reference()
        db.setValue("Hello Firebase")
    }
    
    @IBAction func sendMessage() {
        let messagesDB = Database.database().reference().child("Messages") // child database
        let messageDictionary : NSDictionary = ["Sender" : Auth.auth().currentUser!.email as String!, "MessageBody" : input.text!]
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error, ref) in
            if error != nil {
                print(error!)
            }
            else {
                print("Message saved successfully!")
            }
        }
    }
    
    @IBAction func getMessage () {
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded, with: { snapshot in
            let snapshotValue = snapshot.value as! NSDictionary
            let text = snapshotValue["MessageBody"] as! String
            let sender = snapshotValue["Sender"] as! String
            self.messageLabel.text = text
            self.senderLabel.text = sender
        })
    }
    
}
