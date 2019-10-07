//
//  TicketStoreTableViewCell.swift
//  Sound Gate
//
//  Created by Matheus Martins on 06/10/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit

class TicketStoreTableViewCell: UITableViewCell {
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buyButton.isEnabled = false
        buyButton.layer.cornerRadius = 8
    }

}
