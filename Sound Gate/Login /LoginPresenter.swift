//
//  LoginPresenter.swift
//  Sound Gate
//
//  Created by Matheus Martins on 11/08/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

protocol LoginPresentationLogic {
    func presentLogin(response: FetchLoginInfos.Response)
}

class LoginPresenter: LoginPresentationLogic {
    var viewController: LoginDisplayLogic?
    
    func presentLogin(response: FetchLoginInfos.Response) {
        viewController?.displayLogin(viewObject: FetchLoginInfos.VO(labelText: response.labelText, cellType: response.cellType))
    }
    
    
}
