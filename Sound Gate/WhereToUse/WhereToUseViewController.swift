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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewContent.delegate = self
        tableViewContent.dataSource = self
        tableViewContent.layer.cornerRadius = 8
        tableViewContent.register(UINib(nibName: "TicketCellTableViewCell", bundle: nil), forCellReuseIdentifier: "TicketCell")
        tableViewContent.register(UINib(nibName: "TicketStoreTableViewCell", bundle: nil), forCellReuseIdentifier: "TicketStoreCell")
    }
    @IBAction func switchTableViewController(_ sender: UISegmentedControl) {
        tableViewContent.reloadData()
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
            print("ok")
        }
    }
}

extension WhereToUseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return 7
        } else {
            return 7
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0 {
            let cell = tableViewContent.dequeueReusableCell(withIdentifier: "TicketStoreCell") as! TicketStoreTableViewCell
            cell.backgroundColor = UIColor(red: 62/255, green: 31/255, blue: 74/255, alpha: 1)
            cell.eventNameLabel.text = "4 Amigos Stund-up comedy"
            cell.fromDateLabel.text = "De 2019-11-01"
            cell.toDateLabel.text = "De 2019-11-31"
            return cell
        } else {
            let cell = tableViewContent.dequeueReusableCell(withIdentifier: "TicketCell") as! TicketCellTableViewCell
            cell.backgroundColor = UIColor(red: 62/255, green: 31/255, blue: 74/255, alpha: 1)
            cell.eventNameLabel.text = "Joker"
            cell.eventNameLabel.textColor = .white
            cell.eventDateLabel.text = "2019-10-11 \nHorário de inicio: 21:00"
            cell.eventDateLabel.textColor = .white
            cell.addressEventLabel.text = "Avenida Deputado cantídio sampaio 4822\nVila Souza\nCEP: 02860-001"
            cell.addressEventLabel.textColor = .white
            
            func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == .delete {
                    print("ok")
                }
            }
            return cell
        }
    }
}
