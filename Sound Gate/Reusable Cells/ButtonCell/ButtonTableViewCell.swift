//
//  ButtonTableViewCell.swift
//  Sound Gate
//
//  Created by Matheus Martins on 11/08/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setFinalization(buttonText: String) {
        button.setTitle(buttonText, for: .normal)
        button.backgroundColor = .purple
        button.tintColor = .green
        button.layer.cornerRadius = 8
    }

    func setOption(optionText: String) {
        button.setTitle(optionText, for: .normal)
        button.tintColor = .purple
    }
}
