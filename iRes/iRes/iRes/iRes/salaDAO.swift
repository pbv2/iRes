//
//  salaDAO.swift
//  iRes
//
//  Created by student on 25/04/19.
//  Copyright © 2019 iRes. All rights reserved.
//

import Foundation

class salaDAO {
    
    static func getSalas(codigo:String) -> [Sala] {
        var salas:[Sala] = []
        
        let jsonUrlString = "https://projetov1-1.mybluemix.net/buscabloco?bloco=" + codigo
        guard let url = URL(string: jsonUrlString) else { return []}
        
        let urlRequest = URLRequest(url: url)
        
        var done = false
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            //let responseString = String(data: data!, encoding: String.Encoding.utf8)
            //print("responseString = \(String(describing: responseString))")
            DispatchQueue.main.async() {
            do{
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
                    for salasIndex in json{
                        let salinha = Sala(json: salasIndex)
                        salas.append(salinha)
                    }
                        done = true
                    }
                }catch let jsonErr{
                    print("error during serialization", jsonErr)
                }
            }
        })
            
        task.resume()
        
        repeat {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while !done
        return salas
        
    }
    static func getSalas() -> [Sala] {
        var salas:[Sala] = []
        
        let jsonUrlString = "https://projetov1-1.mybluemix.net/buscadb"
        guard let url = URL(string: jsonUrlString) else { return []}
        
        let urlRequest = URLRequest(url: url)
        
        var done = false
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            DispatchQueue.main.async() {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
                        for salasIndex in json{
                            let salinha = Sala(json: salasIndex)
                            salas.append(salinha)
                        }
                        done = true
                    }
                }catch let jsonErr{
                    print("error during serialization", jsonErr)
                }
            }
        })
        
        task.resume()
        
        repeat {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while !done
        return salas
        
    }
    
    static func getSala(codigo:String) -> Sala {
        var sala:Sala = Sala(json: ["a" : "b" as AnyObject])
        
        let jsonUrlString = "https://projetov1-1.mybluemix.net/buscasala?nome=" + codigo
        guard let url = URL(string: jsonUrlString) else { return sala}
        
        let urlRequest = URLRequest(url: url)
        
        var done = false
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in

            DispatchQueue.main.async() {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
                        sala = Sala(json: json[0])
                        done = true
                    }
                }catch let jsonErr{
                    print("error during serialization", jsonErr)
                }
            }
        })
        
        task.resume()
        
        repeat {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while !done
        return sala
        
    }
}
