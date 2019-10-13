//
//  ProfileViewController.swift
//  Sound Gate
//
//  Created by Matheus Martins on 14/09/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit
import TLCustomMask

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthDayLabel: UILabel!
    @IBOutlet weak var cpfLabel: UILabel!
    @IBOutlet weak var rgLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var refreshButton: UIButton!
    var phoneValue: String?
    let phoneMask = TLCustomMask()
    let loading = Loading()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        setupInfos(user: LoginService.userApp!)
        refreshButton.layer.cornerRadius = 8
        emailTextField.autocorrectionType = .no
        addressTextField.autocorrectionType = .no
        phoneTextField.autocorrectionType = .no
        phoneTextField.delegate = self
        phoneMask.formattingPattern = "$$$$$-$$$$"
    }
    
    func setupInfos(user: User) {
        nameLabel.text = user.nome
        let date = user.nascimento.split(separator: "T")
        birthDayLabel.text = "Nascimento: \(date[0])"
        var cpf = "\(user.cpf)"
        cpf.insert(".", at: cpf.index(cpf.startIndex, offsetBy: 3))
        cpf.insert(".", at: cpf.index(cpf.startIndex, offsetBy: 7))
        cpf.insert("-", at: cpf.index(cpf.startIndex, offsetBy: 11))
        cpfLabel.text = "CPF: \(cpf)"
        var rg = "\(user.rg)"
        rg.insert(".", at: cpf.index(rg.startIndex, offsetBy: 2))
        rg.insert(".", at: cpf.index(rg.startIndex, offsetBy: 6))
        rg.insert("-", at: cpf.index(rg.startIndex, offsetBy: 10))
        rgLabel.text = "RG: \(rg)"
        addressTextField.placeholder = "Endereço: \(user.endereco.logradouro)"
        phoneTextField.placeholder = "Telefone: \(user.telefone)"
        emailTextField.placeholder = "E-Mail: \(user.login)"
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
        if emailTextField.text != "" && phoneValue != "" && addressTextField.text != "" {
            loading.playAnimations(view: self.view)
            self.tabBarController?.tabBar.isHidden = true
            ProfileService.shared.refreshInfos(email: emailTextField!.text!, phone: Int(phoneValue!)!, address: addressTextField.text!) { (sucess, erro) in
                if sucess == 200 {
                    self.loading.stopAnimation()
                    self.tabBarController?.tabBar.isHidden = false
                    let alert = UIAlertController(title: "Informações atualizadas", message: "Todas as informações estão atualizadas agora", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.emailTextField.text = ""
                    self.phoneTextField.text = ""
                    self.addressTextField.text = ""
                    self.setupInfos(user: LoginService.userApp!)
                }
                
                if erro != nil {
                    self.loading.stopAnimation()
                    self.tabBarController?.tabBar.isHidden = false
                    let alert = UIAlertController(title: "Ops =(", message: "Algo deu errado, tente mais tarde!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Ops =(", message: "É necessário preencher todos os campos", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String) -> Bool {
        if textField == phoneTextField {
            textField.text = phoneMask.formatStringWithRange(range: range, string: string)
            phoneValue = phoneMask.cleanText
        }
        
        return false
    }
    
}
