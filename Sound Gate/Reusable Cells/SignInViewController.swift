//
//  SignInViewController.swift
//  Sound Gate
//
//  Created by Matheus Martins on 25/08/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var cpfTextField: UITextField!
    @IBOutlet weak var rgTextField: UITextField!
    @IBOutlet weak var addresTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.cornerRadius = 8
        dismissButton.layer.cornerRadius = 8
        nameTextField.autocorrectionType = .no
        emailTextField.autocorrectionType = .no
        rgTextField.autocorrectionType = .no
        addresTextField.autocorrectionType = .no
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
        
        self.nameTextField.inputAccessoryView = doneToolbar
        self.emailTextField.inputAccessoryView = doneToolbar
        self.birthTextField.inputAccessoryView = doneToolbar
        self.cpfTextField.inputAccessoryView = doneToolbar
        self.rgTextField.inputAccessoryView = doneToolbar
        self.addresTextField.inputAccessoryView = doneToolbar
        self.phoneTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.nameTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.birthTextField.resignFirstResponder()
        self.cpfTextField.resignFirstResponder()
        self.rgTextField.resignFirstResponder()
        self.addresTextField.resignFirstResponder()
        self.phoneTextField.resignFirstResponder()
    }
    
    @IBAction func register(_ sender: Any) {
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
