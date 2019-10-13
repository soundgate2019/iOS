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
    
    func reloadUser() {
        let link = "https://soundgate.herokuapp.com/SoundGateWB/Usuario/atualizar"
        guard let url = URL(string: link) else { return }
        Alamofire.request(url, method: .put, parameters: ["cd" : LoginService.userApp!.cd, "login" : LoginService.userApp!.login, "senha" : LoginService.userApp!.senha, "nome" : LoginService.userApp!.nome, "cpf" : LoginService.userApp!.cpf, "rg" : LoginService.userApp!.rg, "nascimento" : LoginService.userApp!.nascimento, "telefone" : LoginService.userApp!.telefone, "saldo" : LoginService.userApp!.saldo , "endereco" : ["cep" : LoginService.userApp!.endereco.cep, "logradouro" : LoginService.userApp!.endereco.logradouro, "descricao" : LoginService.userApp!.endereco.descricao]], encoding: JSONEncoding.default).response { _ in
        }
    }
    func updateAvailableMoney(value: Double, oNcompletion: @escaping (DefaultDataResponse) -> Void) {
        LoginService.shared.login(user: LoginService.userApp!.login, password: LoginService.userApp!.senha, onCompletion: { _,_  in
            let link = "https://soundgate.herokuapp.com/SoundGateWB/Usuario/adicionarSaldo"
            guard let url = URL(string: link) else { return }
            Alamofire.request(url, method: .put, parameters: ["cd" : LoginService.userApp!.cd, "login" : LoginService.userApp!.login, "senha" : LoginService.userApp!.senha, "nome" : LoginService.userApp!.nome, "cpf" : LoginService.userApp!.cpf, "rg" : LoginService.userApp!.rg, "nascimento" : LoginService.userApp!.nascimento, "telefone" : LoginService.userApp!.telefone, "saldo" : LoginService.userApp!.saldo + value, "endereco" : ["cep" : LoginService.userApp!.endereco.cep, "logradouro" : LoginService.userApp!.endereco.logradouro, "descricao" : LoginService.userApp!.endereco.descricao]], encoding: JSONEncoding.default).response { (response) in
                LoginService.userApp!.saldo = LoginService.userApp!.saldo + value
                oNcompletion(response)
            }
        })
    }
}

