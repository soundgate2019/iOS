//
//  LoginConfigurator.swift
//  Sound Gate
//
//  Created by Matheus Martins on 11/08/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

class LoginConfigurator {
    static let shared = LoginConfigurator()
    
//    private override init() {}
    
    func configure(_ viewController: LoginViewController) {
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
//        let router = LoginRouter()
        
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}
