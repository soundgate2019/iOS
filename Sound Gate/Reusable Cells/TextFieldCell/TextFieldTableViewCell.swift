//
//  TextFieldTableViewCell.swift
//  Sound Gate
//
//  Created by Matheus Martins on 11/08/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setTextField(placeHolderText: String) {
        textField.placeholder = placeHolderText
        textField.textAlignment = .center
    }

}
