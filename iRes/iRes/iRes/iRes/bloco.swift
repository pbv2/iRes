//
//  bloco.swift
//  iRes
//
//  Created by student on 25/04/19.
//  Copyright © 2019 iRes. All rights reserved.
//

import Foundation

class bloco {
    
    var nome: String
    var codigo: String
    var salas: [Sala]
    
    init(nome: String, salas: [Sala], codigo: String) {
        self.nome = nome
        self.codigo = codigo
        self.salas = salas
    }
}
