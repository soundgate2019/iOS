//
//  LoginModel.swift
//  Sound Gate
//
//  Created by Matheus Martins on 11/08/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

enum FetchLoginInfos {
    struct Request { }
    struct Response {
        let labelText: String
        let cellType: [CellType]
        
        enum CellType {
            case textField(textField: String)
            case buttonAction(actionText: String)
            case buttonFinalization(finalizationText: String)
        }
    }
    struct VO {
        let labelText: String
        let cellType: [FetchLoginInfos.Response.CellType]
    }
}
