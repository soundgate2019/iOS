//
//  SignInService.swift
//  Sound Gate
//
//  Created by Matheus Martins on 21/09/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import Alamofire

class SignInService {
    static let shared = SignInService()
    
    func registerNewUser(login: String, password: String, name: String, cpf: Int, rg: String, birthday: String, phone: Int, cep: String, street: String, number: String) {
        let link = "https://soundgate.herokuapp.com/SoundGateWB/Usuario/cadastrar"
        guard let url = URL(string: link) else { return }
        Alamofire.request(url, method: .post, parameters: ["login" : login, "senha" : password, "nome" : name, "cpf" : cpf, "rg" : rg, "nascimento" : birthday, "telefone" : phone, "saldo" : 0, "endereco" : ["cep" : cep, "logradouro" : street, "descricao" : number]], encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                print("registrado com sucesso")
            case .failure(_):
                print("deu ruim")
            }
        }
    }
}
