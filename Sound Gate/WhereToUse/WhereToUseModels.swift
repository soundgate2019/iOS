//
//  WhereToUseModels.swift
//  Sound Gate
//
//  Created by Matheus Martins on 06/10/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

struct Ingresso: Codable {
    let cd: Int
    let evento: Evento
    let data: String
    let valido: Bool
    let usuario: User
}

struct Eventos: Codable {
    let evento: Evento
}
struct Evento: Codable {
    let cd: Int
    let nome: String
    let primeiroDia: String
    let ultimoDia: String
    let empresa: Empresa
    let endereco: Endereco
    let preco: Double
    let lugaresPorDia: Int
    let horarioInicial: String
    let horarioLimite: String
    let fotoEvento: String
}

struct Empresa: Codable {
    let cd: Int
    let cnpj: Int
    let nome: String
    let endereco: Endereco
}
