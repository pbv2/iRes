//
//  sala.swift
//  iRes
//
//  Created by student on 25/04/19.
//  Copyright © 2019 iRes. All rights reserved.
//

import Foundation

struct Reservas {
    var pessoa: String?
    var motivo: String?
    var horario: String?
    
    init(json: [String: AnyObject]){
        self.pessoa = json["pessoa"] as? String ?? ""
        self.motivo = ""//json["motivo"] as? String ?? ""
        self.horario = json["horario"] as? String ?? ""
    }
}

class Sala {
    
    var nome: String?
    var bloco: String?
    var descricao: String?
    var especificacoes: [String : String]?
    
    var reserva: [Reservas]
    
    init(json: [String: AnyObject]) {
        self.nome = json["nome"] as? String ?? ""
        self.bloco = json["bloco"] as? String ?? ""
        self.descricao = json["descricao"] as? String ?? ""
        //self.especificacoes = json["especificacoes"] as? [String : String] ?? [:]
        
        self.reserva = [Reservas]()
        if let reserva = json["reservas"] as? [[String: AnyObject]]{
            for jsonReserva in reserva{
                let novaReserva = Reservas(json: jsonReserva)
                self.reserva.append(novaReserva)
            }
        }
        
        self.especificacoes = [String : String]()
        if let especificacao = json["especificacoes"] as? [[String: String]]{
            for i in especificacao{
                for j in i {
                    self.especificacoes?.updateValue(j.value, forKey: j.key)
                }
            }
            
        }
        
    }
}

