//
//  FeedWalletViewController.swift
//  Sound Gate
//
//  Created by Matheus Martins on 14/09/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit
import TLCustomMask

class FeedWalletViewController: UIViewController {

    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var expiringDatePicker: UIDatePicker!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var finalizeBuyButton: UIButton!
    let cardMask = TLCustomMask()
    let cvvMask = TLCustomMask()
    let loading = Loading()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        
        cardMask.formattingPattern = "$$$$ $$$$ $$$$ $$$$"
        cvvMask.formattingPattern = "$$$"
        cardNumberTextField.delegate = self
        cvvTextField.delegate = self
        finalizeBuyButton.layer.cornerRadius = 8
        valueTextField.autocorrectionType = .no
        cardNumberTextField.autocorrectionType = .no
        nameTextField.autocorrectionType = .no
        cvvTextField.autocorrectionType = .no
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
        
        self.valueTextField.inputAccessoryView = doneToolbar
        self.cardNumberTextField.inputAccessoryView = doneToolbar
        self.nameTextField.inputAccessoryView = doneToolbar
        self.cvvTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.valueTextField.resignFirstResponder()
        self.cardNumberTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        self.cvvTextField.resignFirstResponder()
    }
    
    @IBAction func finalizeBuy(_ sender: Any) {
        if valueTextField.text != "" && cardNumberTextField.text != "" && nameTextField.text != "" && cvvTextField.text != "" {
            loading.playAnimations(view: self.view)
            self.tabBarController?.tabBar.isHidden = true
            FeedWalletService.shared.updateAvailableMoney(value: Double(valueTextField.text!)!) {_ in
                let alert = UIAlertController(title: "Compra bem Sucedida", message: "Saldo atualizado", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.loading.stopAnimation()
                self.tabBarController?.tabBar.isHidden = false
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Campo(s) obrigatórios não preenchidos", message: "Preencha todos os campos", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.loading.stopAnimation()
            self.tabBarController?.tabBar.isHidden = false
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension FeedWalletViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if textField == cardNumberTextField {
            textField.text = cardMask.formatStringWithRange(range: range, string: string)
        }
        
        if textField == cvvTextField {
            textField.text = cvvMask.formatStringWithRange(range: range, string: string)
        }
        
        return false
    }
}
