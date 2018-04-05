//
//  Especialidade.swift
//  Loopi
//
//  Created by Loopi on 27/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import HandyJSON

class Especialidade : Equatable,HandyJSON {
    required init() {   }
    
    var id : Int?
    var descricao : String?
    var subCategoria : SubCategoria?
    
}

func == (o1: Especialidade, o2: Especialidade) -> Bool {
    return o1.id == o2.id
}


