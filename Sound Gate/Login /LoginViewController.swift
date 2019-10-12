//
//  ViewController.swift
//  Sound Gate
//
//  Created by Matheus Martins on 07/05/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var sigInButton: UIButton!
    let loading = Loading()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 8
        sigInButton.layer.cornerRadius = 8
        passwordTextField.isSecureTextEntry = true
        userTextField.autocorrectionType = .no
        userTextField.layer.cornerRadius = userTextField.frame.height / 2
        userTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        passwordTextField.layer.masksToBounds = true
        self.addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.userTextField.inputAccessoryView = doneToolbar
        self.passwordTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.userTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    @IBAction func LogIn(_ sender: Any) {
        view.endEditing(true)
        loading.playAnimations(view: self.view)
        if let user = userTextField.text, let password = passwordTextField.text {
            LoginService.shared.login(user: user, password: password) { (sucess, erro) in
                if let deubom = sucess {
                    print(deubom)
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! UITabBarController
                    newViewController.modalPresentationStyle = .fullScreen
                    self.present(newViewController, animated: true, completion: nil)
                } else if let deuRuim = erro {
                    self.loading.stopAnimation()
                    print(deuRuim)
                    let alert = UIAlertController(title: "Logim mal sucedido", message: "Usuário ou senha incorretos", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    

    @IBAction func routeToRegister(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.present(newViewController, animated: true, completion: nil)
    }
}
