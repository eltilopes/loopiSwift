//
//  Bairro.swift
//  Loopi
//
//  Created by Loopi on 19/07/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import HandyJSON

class Bairro : HandyJSON {
    required init() {   }
    
    var id : Int?
    var nome : String?
    var selecionado = false
    
    
    init(id : Int, nome : String) {
        self.nome = nome
        self.id = id
    }
    
}


