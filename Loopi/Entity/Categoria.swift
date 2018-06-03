//
//  Categoria.swift
//  Loopi
//
//  Created by Loopi on 27/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import HandyJSON

class Categoria : Equatable,HandyJSON {
    required init() {}
    
    var id : Int?
    var descricao : String?
    var urlImagem : String?
    
}

func == (c1: Categoria, c2: Categoria) -> Bool {
    return c1.id == c2.id
}
