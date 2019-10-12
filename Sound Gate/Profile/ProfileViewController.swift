//
//  ProfileViewController.swift
//  Sound Gate
//
//  Created by Matheus Martins on 14/09/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthDayLabel: UILabel!
    @IBOutlet weak var cpfLabel: UILabel!
    @IBOutlet weak var rgLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        setupInfos(user: LoginService.userApp!)
        refreshButton.layer.cornerRadius = 8
        emailTextField.autocorrectionType = .no
        addressTextField.autocorrectionType = .no
        phoneTextField.autocorrectionType = .no
    }
    
    func setupInfos(user: User) {
        nameLabel.text = user.nome
        let date = user.nascimento.split(separator: "T")
        birthDayLabel.text = "\(date[0])"
        cpfLabel.text = "\(user.cpf)"
        rgLabel.text = user.rg
        addressTextField.placeholder = user.endereco.logradouro
        phoneTextField.placeholder = "\(user.telefone)"
        emailTextField.placeholder = user.login
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
        
        self.emailTextField.inputAccessoryView = doneToolbar
        self.addressTextField.inputAccessoryView = doneToolbar
        self.phoneTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.emailTextField.resignFirstResponder()
        self.addressTextField.resignFirstResponder()
        self.phoneTextField.resignFirstResponder()
    }
    
    @IBAction func refreshInfos(_ sender: Any) {
        
    }
    
}
