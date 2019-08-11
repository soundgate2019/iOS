//
//  LoginInteractor.swift
//  Sound Gate
//
//  Created by Matheus Martins on 11/08/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

protocol LoginBusinessLogic {
    func handleLogin(request: FetchLoginInfos.Request)
}

class LoginInteractor: LoginBusinessLogic {
    var presenter: LoginPresentationLogic?
    
    func handleLogin(request: FetchLoginInfos.Request) {
        presenter?.presentLogin(response: FetchLoginInfos.Response(labelText: "Login", cellType: [FetchLoginInfos.Response.CellType.textField(textField: "Usuário"), FetchLoginInfos.Response.CellType.textField(textField: "Senha"), FetchLoginInfos.Response.CellType.buttonAction(actionText: "Esqueceu a senha"), FetchLoginInfos.Response.CellType.buttonAction(actionText: "Cadastrar"), FetchLoginInfos.Response.CellType.buttonFinalization(finalizationText: "Entrar")]))
    }
}
