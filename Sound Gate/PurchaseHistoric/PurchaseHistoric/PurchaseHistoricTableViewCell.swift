//
//  PurchaseHistoricTableViewCell.swift
//  Sound Gate
//
//  Created by Matheus Martins on 21/09/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit

class PurchaseHistoricTableViewCell: UITableViewCell {
    @IBOutlet weak var dateBuy: UILabel!
    @IBOutlet weak var descriptionBuy: UILabel!
    @IBOutlet weak var valueBuy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func loadInfos(historic: PurchaseHistoricModel) {
        let date = historic.data.split(separator: "T")
        dateBuy.text = "Data: " + "\(date[0])"
        descriptionBuy.text = historic.descricao
        valueBuy.text = "R$ " + String(format: "%.2f", historic.valor)
    }

}
