//
//  BuyTicketViewController.swift
//  Sound Gate
//
//  Created by Matheus Martins on 09/10/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit

class BuyTicketViewController: UIViewController {
    @IBOutlet weak var ticketImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var availableSeatsLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var eventPriceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    var event: Evento?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buyButton.layer.cornerRadius = 8
        loadInfos(event: event!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func loadInfos(event: Evento) {
        let dateFrom = event.primeiroDia.split(separator: "T")
        let dateTo = event.ultimoDia.split(separator: "T")
        eventNameLabel.text = event.nome
        eventPriceLabel.text = "R$ \(String(format: "%.2f", event.preco))"
        eventDateLabel.text = "De \(dateFrom[0]) até \(dateTo[0])" 
        availableSeatsLabel.text = "Lugares Disponíveis \(event.lugaresPorDia)"
        startTimeLabel.text = "Horário de inicio: " + event.horarioInicial
        addressLabel.text = event.endereco.logradouro + "\n" + event.endereco.descricao + "\n" + event.endereco.cep
        WhereToUseService.shared.downloadImage(from: event.fotoEvento) { (image, error) in
            if let iconImage = image {
                DispatchQueue.main.async {
                    self.ticketImageView.image = iconImage
                }
            }
        }
    }
    
    @IBAction func buyTicket(_ sender: Any) {
        let date = event?.primeiroDia.split(separator: "T")
        WhereToUseService.shared.addTicket(idEvent: event!.cd, idUser: LoginService.userApp!.cd, data: "\(date![0])") { response,_  in
            if response == 200 {
                let alert = UIAlertController(title: "Sucesso", message: "Compra de ingresso bem sucedida!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Falha", message: "Saldo insuficiente para compra de ingresso", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
