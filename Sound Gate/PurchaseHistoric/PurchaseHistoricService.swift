//
//  PurchaseHistoricService.swift
//  Sound Gate
//
//  Created by Matheus Martins on 21/09/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//
import Alamofire

class PurchaseHistoricService {
    static let shared = PurchaseHistoricService()
    static var historic: [PurchaseHistoricModel]?
    
    func loadHistoric() {
        let link = "https://soundgate.herokuapp.com/SoundGateWB/Usuario/historicos"
        guard let url = URL(string: link) else { return }
        Alamofire.request(url, method: .post, parameters: ["cd" : LoginService.userApp!.cd, "login" : LoginService.userApp!.login, "senha" : LoginService.userApp!.senha, "nome" : LoginService.userApp!.nome, "cpf" : LoginService.userApp!.cpf, "rg" : LoginService.userApp!.rg, "nascimento" : LoginService.userApp!.nascimento, "telefone" : LoginService.userApp!.telefone, "saldo" : LoginService.userApp!.saldo, "endereco" : ["cep" : LoginService.userApp!.endereco.cep, "logradouro" : LoginService.userApp!.endereco.logradouro, "descricao" : LoginService.userApp!.endereco.descricao]], encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                let teste = try! JSONDecoder().decode([PurchaseHistoricModel].self, from: response.data!)
                PurchaseHistoricService.historic = teste
            case .failure:
                print("deu ruim")
            }
        }
    }
}
