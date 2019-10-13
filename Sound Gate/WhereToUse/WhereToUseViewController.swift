//
//  WhereToUseViewController.swift
//  Sound Gate
//
//  Created by Matheus Martins on 14/09/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit

class WhereToUseViewController: UIViewController {
    @IBOutlet weak var tableViewContent: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var isLoading = true
    let loading = Loading()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewContent.delegate = self
        tableViewContent.dataSource = self
        tableViewContent.layer.cornerRadius = 8
        tableViewContent.register(UINib(nibName: "TicketCellTableViewCell", bundle: nil), forCellReuseIdentifier: "TicketCell")
        tableViewContent.register(UINib(nibName: "TicketStoreTableViewCell", bundle: nil), forCellReuseIdentifier: "TicketStoreCell")
        showLoading()
        self.tabBarController?.tabBar.isHidden = true
        WhereToUseService.shared.loadTickets { _ in }
        WhereToUseService.shared.loadEvents { _ in
            self.showLoading()
            self.tableViewContent.reloadData()
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    private func showLoading() {
        if isLoading {
            loading.playAnimations(view: view)
            isLoading = false
        } else {
            loading.stopAnimation()
        }
    }
    @IBAction func switchTableViewController(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            isLoading = true
            self.tabBarController?.tabBar.isHidden = true
            showLoading()
            WhereToUseService.shared.loadEvents { _ in
                self.showLoading()
                self.tableViewContent.reloadData()
                self.tabBarController?.tabBar.isHidden = false
            }
        } else {
            isLoading = true
            self.tabBarController?.tabBar.isHidden = true
            showLoading()
             WhereToUseService.shared.loadTickets { _ in
                self.showLoading()
                self.tableViewContent.reloadData()
                self.tabBarController?.tabBar.isHidden = false
            }
        }
        
    }
}

extension WhereToUseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if segmentedControl.selectedSegmentIndex == 1 {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            WhereToUseService.shared.deleteTicket(ticketId: WhereToUseService.shared.tickets[indexPath.row].cd, eventId: WhereToUseService.shared.tickets[indexPath.row].evento.cd)
            isLoading = true
            self.tabBarController?.tabBar.isHidden = true
            showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                WhereToUseService.shared.loadTickets {_ in
                self.showLoading()
                self.tableViewContent.reloadData()
                self.tabBarController?.tabBar.isHidden = false
                let alert = UIAlertController(title: "Estorno bem sucedido", message: "Dinheiro já retornou para sua carteiira!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

extension WhereToUseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return WhereToUseService.shared.events.count
        } else {
            return WhereToUseService.shared.tickets.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0 {
            let cell = tableViewContent.dequeueReusableCell(withIdentifier: "TicketStoreCell") as! TicketStoreTableViewCell
            cell.backgroundColor = UIColor(red: 62/255, green: 31/255, blue: 74/255, alpha: 1)
            WhereToUseService.shared.downloadImage(from: WhereToUseService.shared.events[indexPath.row].fotoEvento) { (image, error) in
                if let iconImage = image {
                    DispatchQueue.main.async {
                        cell.eventImageView.image = iconImage
                    }
                }
            }
            cell.eventNameLabel.text = WhereToUseService.shared.events[indexPath.row].nome
            let dateFrom = WhereToUseService.shared.events[indexPath.row].primeiroDia.split(separator: "T")
            cell.fromDateLabel.text = "De: " + "\(dateFrom[0])"
            let dateTo = WhereToUseService.shared.events[indexPath.row].ultimoDia.split(separator: "T")
            cell.toDateLabel.text = "Até: " + "\(dateFrom[0])"
            return cell
        } else {
            let dateFrom = WhereToUseService.shared.tickets[indexPath.row].data.split(separator: "T")
            let cell = tableViewContent.dequeueReusableCell(withIdentifier: "TicketCell") as! TicketCellTableViewCell
            cell.backgroundColor = UIColor(red: 62/255, green: 31/255, blue: 74/255, alpha: 1)
            cell.eventNameLabel.text = WhereToUseService.shared.tickets[indexPath.row].evento.nome
            cell.eventNameLabel.textColor = .white
            WhereToUseService.shared.downloadImage(from: WhereToUseService.shared.tickets[indexPath.row].evento.fotoEvento) { (image, error) in
                if let eventImage = image {
                    cell.eventImageView.image = eventImage
                }
            }
            cell.eventDateLabel.text = "\(dateFrom[0]) \nHorário de inicio: \(WhereToUseService.shared.tickets[indexPath.row].evento.horarioInicial)"
            cell.eventDateLabel.textColor = .white
            cell.addressEventLabel.text = "\(WhereToUseService.shared.tickets[indexPath.row].evento.endereco.logradouro)\n\(WhereToUseService.shared.tickets[indexPath.row].evento.endereco.descricao)\n\(WhereToUseService.shared.tickets[indexPath.row].evento.endereco.cep)"
            cell.addressEventLabel.textColor = .white
            
            func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == .delete {
                    print("ok")
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 1 {
            return
        } else {
            let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "BuyTicketViewController") as! BuyTicketViewController
            vc.event = WhereToUseService.shared.events[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        }
    }
}
