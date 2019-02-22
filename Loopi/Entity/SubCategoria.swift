//
//  SubCategoria.swift
//  Loopi
//
//  Created by Loopi on 27/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import HandyJSON

class SubCategoria : Equatable,HandyJSON {
    required init() {   }
    
    var id : Int?
    var descricao : String?
    var categoria : Categoria?
    var urlImagem : String?
    
}

func == (o1: SubCategoria, o2: SubCategoria) -> Bool {
    return o1.id == o2.id
}

