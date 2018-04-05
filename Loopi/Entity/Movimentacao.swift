//
//  Movimentacao.swift
//  Loopi
//
//  Created by Loopi on 16/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import HandyJSON

class Movimentacao : HandyJSON {
    required init() {}
    
    var data : Date!
    var historico : String!
    var valor : Double!
    
    init(data : Date,historico : String,valor : Double) {
        self.data = data
        self.historico = historico
        self.valor = valor
    }
    
    func dataFormatada() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM"
        return formatter.string(from: data)
    }
}
