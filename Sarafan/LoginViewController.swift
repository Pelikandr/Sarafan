//
//  LoginViewController.swift
//  Sarafan
//
//  Created by Denis Zayakin on 12/26/18.
//  Copyright © 2018 Denis Zayakin. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self as? UITextFieldDelegate
        password.delegate = self as? UITextFieldDelegate
        email.tag = 0 //теги для return
        password.tag = 1
    }
    // функция return (клавиатура переключается на следующий textfield)
    func textFieldShouldReturn(_ email: UITextField) -> Bool
    {
        if let nextField = email.superview?.viewWithTag(email.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            email.resignFirstResponder()
        }
        return false
    }
    
    // проверяет выполнен ли вход
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "toTabBarController", sender: nil)
        }
    }
    
    // при нажатии на свободное место скрывается клавиатура
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        email.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    // логин
    @IBAction func loginAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "toTabBarController", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
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
