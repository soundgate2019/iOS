//
//  FeedWalletViewController.swift
//  Sound Gate
//
//  Created by Matheus Martins on 14/09/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit

class FeedWalletViewController: UIViewController {

    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var expiringDatePicker: UIDatePicker!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var finalizeBuyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
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
        FeedWalletService.shared.updateAvailableMoney(value: Double(valueTextField.text!) as! Double)
    }
    
}
