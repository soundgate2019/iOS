//
//  WhereToUseService.swift
//  Sound Gate
//
//  Created by Matheus Martins on 09/10/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import Alamofire

class WhereToUseService {
    var events: [Evento] = []
    var tickets: [Ingresso] = []
    static let shared = WhereToUseService()
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    func loadEvents(onComplete: @escaping (_ isLoading: Bool) -> Bool) {
        let link = "https://soundgate.herokuapp.com/SoundGateWB/Evento/eventos"//
        guard let url = URL(string: link) else { return }
        Alamofire.request(url).responseJSON { response in
            if let data = response.data {
                let teste = try! JSONDecoder().decode([Evento].self, from: data)
                self.events = teste
                onComplete(true)
            } else {
                print("deu ruim")
            }
        }
    }
    func addTicket(idEvent: Int, idUser: Int, data: String, onComplete: @escaping (_ isLoading: Bool) -> Bool) {
        let link = "https://soundgate.herokuapp.com/SoundGateWB/Usuario/adicionarIngresso"
        guard let url = URL(string: link) else { return }
        Alamofire.request(url, method: .post, parameters: ["usuarioCd" : idUser, "eventoCd" : idEvent, "data" : data], encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                print("deu bom")
                onComplete(true)
            case .failure(_):
                print("deu ruim")
                onComplete(false)
            }
        }
    }
    
    func loadTickets() {
        let link = "https://soundgate.herokuapp.com/SoundGateWB/Usuario/ingressos"
        guard let url = URL(string: link) else { return }
        Alamofire.request(url, method: .post, parameters: ["cd" : LoginService.userApp!.cd, "login" : LoginService.userApp!.login, "senha" : LoginService.userApp!.senha, "nome" : LoginService.userApp!.nome, "cpf" : LoginService.userApp!.cpf, "rg" : LoginService.userApp!.rg, "nascimento" : LoginService.userApp!.nascimento, "telefone" : LoginService.userApp!.telefone, "saldo" : LoginService.userApp!.saldo, "endereco" : ["cep" : LoginService.userApp!.endereco.cep, "logradouro" : LoginService.userApp!.endereco.logradouro, "descricao" : LoginService.userApp!.endereco.descricao]], encoding: JSONEncoding.default).responseJSON { response in
            if let data = response.data {
                let teste = try! JSONDecoder().decode([Ingresso].self, from: data)
                self.tickets = teste
//                onComplete(true)
            } else {
                print("deu ruim")
            }
        }
    }
    
    func deleteTicket(ticketId: Int, eventId: Int) {
        let link = "https://soundgate.herokuapp.com/SoundGateWB/Usuario/extornarIngresso"
        guard let url = URL(string: link) else { return }
        Alamofire.request(url, method: .post, parameters: ["usuarioLogin" : LoginService.userApp!.login, "usuarioSenha" : LoginService.userApp!.senha, "ingressoCd" : ticketId, "eventoCd": eventId], encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                print("deu bom")
            case .failure(_):
                print("deu ruim")
            }
        }
    }
    func downloadImage(from url: String, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let imageURL = URL(string: url) else { return }
        
        //It has to be a NSString because NSString conforms to expected type AnyObject
        let stringObject = NSString(string: url)
        
        //check if we have image cached
        if let cachedImage = imageCache.object(forKey: stringObject) as? UIImage {
            completion(cachedImage, nil)
            return
        }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            
            guard let imageData = data else {
                completion(nil, error)
                return
            }
            
            guard let image = UIImage(data: imageData) else { return }
            
            self.imageCache.setObject(image, forKey: stringObject)
            completion(image, nil)
            }.resume()
    }
}