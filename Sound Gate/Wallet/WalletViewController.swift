//
//  WalletViewController.swift
//  Sound Gate
//
//  Created by Matheus Martins on 25/08/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import AVFoundation
import UIKit
import ChirpConnect

class WalletViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var availableMoney: UILabel!
    @IBOutlet weak var blockMoney: UIButton!
    @IBOutlet weak var history: UIButton!
    var previousValue: Double?
    let loading = Loading()
    
    let chirp: ChirpConnect = ChirpConnect(appKey: "C6ff42A6Da1bb6fDC4f0e040f", andSecret: "D365e8F800a28dEccC24aFc77EEA6f1CdbADAb9D18EaaCcb80")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previousValue = LoginService.userApp!.saldo
        blockMoney.layer.cornerRadius = 8
        history.layer.cornerRadius = 8
        chirp.receivedBlock = {
            (data: Data?, channel: UInt?) -> () in
            if let _ = data {
                
                let identifier = "\(LoginService.userApp!.cd)"
                print(identifier)
                let payload: Data = identifier.data(using: .utf8)!
                self.tabBarController?.tabBar.isHidden = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.loading.playAnimations(view: self.self.view)
                    self.tabBarController?.tabBar.isHidden = false
                    LoginService.shared.login(user: LoginService.userApp!.login, password: LoginService.userApp!.senha) { User, _ in
                        self.availableMoney.text = "R$ " + String(format: "%.2f", User!.saldo)
                        self.loading.stopAnimation()
                        if self.previousValue != User?.saldo {
                            let alert = UIAlertController(title: "Passagem liberada", message: "Valor descontado com sucesso!", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        } else {
                            let alert = UIAlertController(title: "Passagem Não liberada", message: "Saldo insuficiente!", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                if let err = self.chirp.send(payload) {
                  print("ChirpError (%@)", err.localizedDescription)
                } else {
                  print("Sent (identifier)")
                }
            } else {
                print("deu ruim")
            }
        }
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSessionRecordPermission.granted:
            print("Permission granted")
        case AVAudioSessionRecordPermission.denied:
            print("Pemission denied")
        case AVAudioSessionRecordPermission.undetermined:
            print("Libera o microfone ae")
            AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
            })
        default:
            print("deu Ruim")
        }
        if let error = chirp.setConfig("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") {
            print("ChirpError (%@)", error.localizedDescription)
        } else {
            if let error = chirp.start() {
                print("ChirpError (%@)", error.localizedDescription)
            } else {
                print("Started ChirpSDK")
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInfos(user: LoginService.userApp!)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func refreshValue() {
        previousValue = LoginService.userApp!.saldo
    }
    
    func setupInfos(user: User) {
        availableMoney.text = "R$ " + String(format: "%.2f", user.saldo)
    }
    
    @IBAction func blockMoney(_ sender: Any) {
        if blockMoney.titleLabel?.text == "Bloquear Saldo" {
            availableMoney.textColor = .gray
            label.text = "Saldo Bloqueado"
            blockMoney.setTitle("Desbloquear Saldo", for: .normal)
        } else {
            availableMoney.textColor = .black
            label.text = "Saldo"
            blockMoney.setTitle("Bloquear Saldo", for: .normal)
        }
        
    }
    
    @IBAction func routeToHistory(_ sender: Any) {
        PurchaseHistoricService.shared.loadHistoric()
        tabBarController?.tabBar.isHidden = true
        loading.playAnimations(view: view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "PurchaseHistoricViewController") as! PurchaseHistoricViewController
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.loading.stopAnimation()
        }
    }
    
}

