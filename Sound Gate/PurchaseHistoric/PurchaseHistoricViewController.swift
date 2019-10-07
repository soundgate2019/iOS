//
//  PurchaseHistoricViewController.swift
//  Sound Gate
//
//  Created by Matheus Martins on 14/09/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit

class PurchaseHistoricViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var historic: [PurchaseHistoricModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(red: 62/255, green: 31/255, blue: 74/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 195/255, green: 240/255, blue: 67/255, alpha: 1)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        self.navigationController?.title = "Churros"
        historic = PurchaseHistoricService.historic?.reversed()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PurchaseHistoricTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

}

extension PurchaseHistoricViewController: UITableViewDelegate {
    
}

extension PurchaseHistoricViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historic!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PurchaseHistoricTableViewCell
        cell.loadInfos(historic: historic![indexPath.row])
        return cell
    }
    
    
}
