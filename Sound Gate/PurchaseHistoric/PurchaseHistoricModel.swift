//
//  PurchaseHistoricModel.swift
//  Sound Gate
//
//  Created by Matheus Martins on 21/09/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

struct PurchaseHistoricModel: Codable {
    let cd: Int
    let usuario: User
    let data: String
    let descricao: String
    let valor: Double
}
