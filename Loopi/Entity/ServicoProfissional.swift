//
//  ServicoProfissional.swift
//  Loopi
//
//  Created by Loopi on 27/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit
import HandyJSON

class ServicoProfissional : Equatable,HandyJSON {
    required init() {   }
    
    var id : Int?
    var nome : String?
    var descricao : String?
    var valor : Double?
    var tempo : Int?
    var especialidade : Especialidade = Especialidade()
    var profissional : Profissional = Profissional()
    
}

func == (o1: ServicoProfissional, o2: ServicoProfissional) -> Bool {
    return o1.id == o2.id
}


