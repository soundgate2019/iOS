//
//  ProfileService.swift
//  Sound Gate
//
//  Created by Matheus Martins on 12/10/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import Alamofire

class ProfileService {
    static let shared = ProfileService()
    
    func refreshInfos(email: String, phone: Int, address: String, onComplete: @escaping(Int?, Error?) -> Void) {
        let link = "https://soundgate.herokuapp.com/SoundGateWB/Usuario/atualizar"
        guard let url = URL(string: link) else { return }
        Alamofire.request(url, method: .put, parameters: ["cd" : LoginService.userApp!.cd, "login" : email, "senha" : LoginService.userApp!.senha, "nome" : LoginService.userApp!.nome, "cpf" : LoginService.userApp!.cpf, "rg" : LoginService.userApp!.rg, "nascimento" : LoginService.userApp!.nascimento, "telefone" : phone, "saldo" : LoginService.userApp!.saldo, "endereco" : ["cep" : LoginService.userApp!.endereco.cep, "logradouro" : address, "descricao" : LoginService.userApp!.endereco.descricao]], encoding: JSONEncoding.default).response { response in
            if response.response?.statusCode == 200 {
                LoginService.shared.login(user: email, password: LoginService.userApp!.senha) { (user, err) in
                    if user != nil {
                        onComplete(response.response?.statusCode, nil)
                    }
                    if let erro = err {
                        onComplete(nil, erro)
                    }
                }
            }
            if let erro = response.error {
                onComplete(nil, erro)
            }
        }
    }
}
