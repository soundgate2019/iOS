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
    func login(user: String, password: String, view: UIViewController) {
        loading.playAnimations(view: view.view)
        let link = "http://localhost:8080/SoundGateWB/Usuario/logar"
        guard let url = URL(string: link) else { return }
        Alamofire.request(url, method: .post, parameters: ["login" : user, "senha" : password], encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    let teste = try! JSONDecoder().decode(User.self, from: response.data!)
                    LoginService.userApp = teste
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! UITabBarController
                    view.present(newViewController, animated: true, completion: nil)
                }
            
            case .failure(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    self.loading.stopAnimation()
                    let login = view as! LoginViewController
                    login.userTextField.layer.cornerRadius = login.userTextField.frame.height / 2
                    login.userTextField.layer.borderWidth = 2
                    login.userTextField.layer.borderColor = UIColor.red.cgColor
                    login.userTextField.text = ""
                    login.userTextField.placeholder = "Usuario ou senha incorretos"
                    login.passwordTextField.layer.borderWidth = 2
                    login.passwordTextField.layer.borderColor = UIColor.red.cgColor
                    login.passwordTextField.text = ""
                }
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
