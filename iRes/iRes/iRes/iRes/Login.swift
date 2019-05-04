//
//  Login.swift
//  iRes
//
//  Created by Pedro da Matta on 01/05/19.
//  Copyright © 2019 iRes. All rights reserved.
//

import Foundation

class Login{
    public var isLogged:Bool
    public var nome:String

    init(nome:String){
        isLogged = false
        self.nome = nome
    }
}
