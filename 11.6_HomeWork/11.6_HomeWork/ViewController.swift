//
//  ViewController.swift
//  11.6_HomeWork
//
//  Created by Вадим Зинатуллин on 20.05.2021.
//

import UIKit
import ReactiveKit
import Bond

class ViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonSignin: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.text = " "
        
        combineLatest(loginTextField.reactive.text, passwordTextField.reactive.text) { email, pass in
            return email!.count >= 1 && pass!.count >= 1
          }
          .bind(to: buttonSignin.reactive.isEnabled)
        
        combineLatest(loginTextField.reactive.text, passwordTextField.reactive.text) { email, pass in
            if email!.isValidEmail(){
                return .black
            }else{ return .red}
          }
        .bind(to: loginTextField.reactive.textColor)
        
        combineLatest(loginTextField.reactive.text, passwordTextField.reactive.text) { email, pass in
            if pass!.isValidPassword() {
                return .black
            }else{ return .red}
          }
        .bind(to: passwordTextField.reactive.textColor)
        
    }

    @IBAction func signInButton() {
        let email = loginTextField.text
        let pass = passwordTextField.text

            if email!.isValidEmail(){
                if !pass!.isValidPassword(){
                    errorLabel.text = "Пароль не удовлетворяет требованиям!"
                } else {errorLabel.text = " "}
            } else { errorLabel.text = email!.isEmpty ? " " : "Некорректная почта!"}
               
        if email!.isValidEmail() && pass!.isValidPassword(){
            errorLabel.text = "Ok"
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateViewController(identifier: "ViewControllerCongratulations") as! ViewControllerCongratulations
            vc.message = "Вы успешно авторизовались!"
            self.present(vc, animated:true, completion:nil)
        }
        
    }
    
}

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidPassword() -> Bool {
        let password = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{6,}$")
        return password.evaluate(with: self)
    }
}
