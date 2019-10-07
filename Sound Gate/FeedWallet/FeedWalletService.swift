//
//  FeedWalletService.swift
//  Sound Gate
//
//  Created by Matheus Martins on 21/09/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import Alamofire

class FeedWalletService {
    static let shared = FeedWalletService()
    
    func updateAvailableMoney(value: Double) {
        let link = "http://localhost:8080/SoundGateWB/Usuario/adicionarSaldo"
        guard let url = URL(string: link) else { return }
        Alamofire.request(url, method: .put, parameters: ["cd" : LoginService.userApp!.cd, "login" : LoginService.userApp!.login, "senha" : LoginService.userApp!.senha, "nome" : LoginService.userApp!.nome, "cpf" : LoginService.userApp!.cpf, "rg" : LoginService.userApp!.rg, "nascimento" : LoginService.userApp!.nascimento, "telefone" : LoginService.userApp!.telefone, "saldo" : LoginService.userApp!.saldo + value, "endereco" : ["cep" : LoginService.userApp!.endereco.cep, "logradouro" : LoginService.userApp!.endereco.logradouro, "descricao" : LoginService.userApp!.endereco.descricao]], encoding: JSONEncoding.default).response { (response) in
            LoginService.userApp!.saldo = LoginService.userApp!.saldo + value
            print(response.data)
        }
    }
}
