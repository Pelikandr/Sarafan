//
//  SignUpViewController.swift
//  Sarafan
//
//  Created by Denis Zayakin on 12/26/18.
//  Copyright © 2018 Denis Zayakin. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self as? UITextFieldDelegate
        password.delegate = self as? UITextFieldDelegate
        passwordConfirm.delegate = self as? UITextFieldDelegate
        email.tag = 0 //теги для return
        password.tag = 1
        passwordConfirm.tag = 2
    }
    
    // первая функция return (клавиатура переключается на следующий textfield)
    func textFieldShouldReturn(_ email: UITextField) -> Bool
    {
        if let nextField = email.superview?.viewWithTag(email.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            email.resignFirstResponder()
        }
        return false
    }
    
    /* второй способ return? более простой
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email {
            textField.resignFirstResponder()
            password.becomeFirstResponder()
        } else if textField == password {
            textField.resignFirstResponder()
            passwordConfirm.becomeFirstResponder()
        } else if textField == passwordConfirm {
            textField.resignFirstResponder()
        }
        return true
    }*/
    
    // при нажатии на свободное место скрывается клавиатура
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        email.resignFirstResponder()
        password.resignFirstResponder()
        passwordConfirm.resignFirstResponder()
    }
    
    // регистрация
    @IBAction func signupActioN(_ sender: Any) {
        if password.text != passwordConfirm.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please try again", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "signupToHome", sender: self)
                }
                else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
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
