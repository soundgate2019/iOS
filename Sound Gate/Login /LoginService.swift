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
    
    func login(user: String, password: String) {
        guard let url = URL(string: "") else { return }
        Alamofire.request(url, method: .post, parameters: ["login" : user, "senha" : password], encoding: JSONEncoding.default, headers: nil).responseJSON { (Response) in
            switch Response.result {
            case .success:
            let teste = try! JSONDecoder().decode(User.self, from: Response.data!)
                print(teste)
            case .failure(_):
                print(user)
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
