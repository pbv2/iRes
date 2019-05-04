//
//  blocoDAO.swift
//  iRes
//
//  Created by student on 25/04/19.
//  Copyright © 2019 iRes. All rights reserved.
//

import Foundation

class blocoDAO {
    static func getBlocos() -> [bloco]{
        return [
            bloco(nome: "Salas CIn", salas: [], codigo:"CIn"),
            //bloco(nome: "Salas CCEN", salas: [], codigo:"CCEN"),
            bloco(nome: "Salas Bloco E", salas: [], codigo:"E"),
            bloco(nome: "Salas Bloco D", salas: [], codigo:"D")
        ]
    }
}
