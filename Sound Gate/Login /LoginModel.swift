//
//  LoginModel.swift
//  Sound Gate
//
//  Created by Matheus Martins on 14/09/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

struct Login: Codable {
    let login: String
    let senha: String
}

struct User: Codable {
    let cd: Int
    let login: String
    let senha: String
    let nome: String
    let cpf: Int
    let rg: String
    let nascimento: String
    let telefone: Int
    let saldo: Double
    let endereco: Endereco
}

struct Endereco: Codable {
    let cd: Int
    let cep: String
    let logradouro: String
    let descricai: String
}
