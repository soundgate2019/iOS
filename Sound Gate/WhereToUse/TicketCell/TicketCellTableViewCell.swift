//
//  TicketCellTableViewCell.swift
//  Sound Gate
//
//  Created by Matheus Martins on 06/10/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit

class TicketCellTableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var addressEventLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setInfos(ticket: Ingresso) {
        eventNameLabel.text = ticket.evento.nome
        let date = ticket.data.split(separator: "T")
        addressEventLabel.text = "Data: " + "\(date[0])"
        eventDateLabel.text = ticket.data
        addressEventLabel.text = ticket.evento.endereco.logradouro + "\n" + ticket.evento.endereco.descricao + "\n" + ticket.evento.endereco.cep
    }

}
