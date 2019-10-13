//
//  SignInViewController.swift
//  Sound Gate
//
//  Created by Matheus Martins on 25/08/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit
import TLCustomMask

class SignInViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var cpfTextField: UITextField!
    @IBOutlet weak var rgTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cepTextField: UITextField!
    @IBOutlet weak var complemetationTexteField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    let loading = Loading()
    let dateMask = TLCustomMask()
    let cpfMask = TLCustomMask()
    let rgMask = TLCustomMask()
    let phoneMask = TLCustomMask()
    var cpfValue: String?
    var rgValue: String?
    var phoneValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cpfTextField.delegate = self
        birthTextField.delegate = self
        rgTextField.delegate = self
        phoneTextField.delegate = self
        registerButton.layer.cornerRadius = 8
        nameTextField.autocorrectionType = .no
        rgTextField.autocorrectionType = .no
        phoneTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
        self.addDoneButtonOnKeyboard()
        dateMask.formattingPattern = "$$$$-$$-$$"
        cpfMask.formattingPattern = "$$$.$$$.$$$-$$"
        rgMask.formattingPattern = "$$.$$$.$$$-$"
        phoneMask.formattingPattern = "$$$$$-$$$$"
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
        self.birthTextField.inputAccessoryView = doneToolbar
        self.cpfTextField.inputAccessoryView = doneToolbar
        self.rgTextField.inputAccessoryView = doneToolbar
        self.phoneTextField.inputAccessoryView = doneToolbar
        self.userTextField.inputAccessoryView = doneToolbar
        self.passwordTextField.inputAccessoryView = doneToolbar
        self.streetTextField.inputAccessoryView = doneToolbar
        self.cepTextField.inputAccessoryView = doneToolbar
        self.complemetationTexteField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.nameTextField.resignFirstResponder()
        self.birthTextField.resignFirstResponder()
        self.cpfTextField.resignFirstResponder()
        self.rgTextField.resignFirstResponder()
        self.phoneTextField.resignFirstResponder()
        self.userTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.streetTextField.resignFirstResponder()
        self.cepTextField.resignFirstResponder()
        self.complemetationTexteField.resignFirstResponder()
    }
    
    @IBAction func register(_ sender: Any) {
        loading.playAnimations(view: self.view)
        if userTextField.text != "" && passwordTextField.text != "" && nameTextField.text != "" && userTextField.text != "" && cpfValue != "" && rgValue != "" && birthTextField.text != "" && phoneValue != "" && cepTextField.text != "" && streetTextField.text != "" && complemetationTexteField.text != "" {
            SignInService.shared.registerNewUser(login: userTextField.text!, password: passwordTextField.text!, name: nameTextField.text!, cpf: Int(cpfValue!)!, rg: rgValue!, birthday: birthTextField.text!, phone: Int(phoneValue!)!, cep: cepTextField.text!, street: streetTextField.text!, number: complemetationTexteField.text!) { sucess, erro in
                if sucess == 200 {
                    self.loading.stopAnimation()
                    let alert = UIAlertController(title: "Cadastro realizado com sucesso!", message: "Já pode logar e usar nosso app!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                if let _ = erro {
                    self.loading.stopAnimation()
                    let alert = UIAlertController(title: "Cadastro não concluido", message: "Algum campo preenchido incorretamente", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            self.loading.stopAnimation()
            let alert = UIAlertController(title: "Campos obrigatórios não preenchidos!", message: "É necessário preencher todos os campos para prosseguir", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if textField == birthTextField {
            textField.text = dateMask.formatStringWithRange(range: range, string: string)
        }
        
        if textField == cpfTextField {
            textField.text = cpfMask.formatStringWithRange(range: range, string: string)
            cpfValue = cpfMask.cleanText
        }
        
        if textField == rgTextField {
            textField.text = rgMask.formatStringWithRange(range: range, string: string)
            rgValue = rgMask.cleanText
        }
        
        if textField == phoneTextField {
            textField.text = phoneMask.formatStringWithRange(range: range, string: string)
            phoneValue = phoneMask.cleanText
        }
        
        return false
    }
}
