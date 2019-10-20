//
//  LoginService.swift
//  Sound Gate
//
//  Created by Matheus Martins on 14/09/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import Foundation
import Alamofire

class LoginService {
    static let shared = LoginService()
    static var userApp: User?
    let loading = Loading()
    func login(user: String, password: String, onCompletion: @escaping (User?, Error?) -> Void) {
        let link = "https://soundgate.herokuapp.com/SoundGateWB/Usuario/logar"
        guard let url = URL(string: link) else { return }
        Alamofire.request(url, method: .post, parameters: ["login" : user, "senha" : password], encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                let user = try! JSONDecoder().decode(User.self, from: response.data!)
                LoginService.userApp = user
                onCompletion(LoginService.userApp, nil)
            case .failure:
                print("Erro ao parsear o json")
                onCompletion(nil, response.error)
            }
        }
    }
    func login(user: String, password: String) {
        let link = "https://soundgate.herokuapp.com/SoundGateWB/Usuario/logar"
        guard let url = URL(string: link) else { return }
        Alamofire.request(url, method: .post, parameters: ["login" : user, "senha" : password], encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
                case .success:
                    let user = try! JSONDecoder().decode(User.self, from: response.data!)
                    LoginService.userApp = user
                    
                case .failure(_):
                    self.loading.stopAnimation()
                    }
                }
    }
    func feedUser(url: String, completion: @escaping (User?, Error?) -> ()) {
        let urlString = ""
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            if let error = error {
                completion(nil, error)
                print("Failed to fetch User:", error)
                return
            }
            
            //Check response
            guard let data = data else { return }
            do {
                let joke = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    completion(joke, nil)
                }
            } catch let jsonError {
                print("Failed to decode:", jsonError)
            }
            
            }
            
            task.resume()
    }
    
    

}

