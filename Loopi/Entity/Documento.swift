//
//  Documento.swift
//  Loopi
//
//  Created by Loopi on 11/07/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import HandyJSON

class Documento : HandyJSON {
    required init() {}
    
    var nome : String!
    
    init(nome : String) {
        self.nome = nome
    }
  
}

