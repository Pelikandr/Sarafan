//
//  ThirdViewController.swift
//  Sarafan
//
//  Created by Denis Zayakin on 12/26/18.
//  Copyright © 2018 Denis Zayakin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class ThirdViewController: UIViewController {

    @IBOutlet weak var profileNavigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileNavigationBar.topItem?.title = Auth.auth().currentUser?.email
    }
    
    // выход из профиля
    @IBAction func logOutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            DataSource.shared.clear()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }

    /*    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
