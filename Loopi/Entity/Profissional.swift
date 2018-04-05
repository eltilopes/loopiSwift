//
//  Profissional.swift
//  Loopi
//
//  Created by Loopi on 27/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import HandyJSON

class Profissional : Equatable,HandyJSON {
    required init() {   }
  
    var id : Int?
    var usuario : UsuarioSession = UsuarioSession()
    var categoria : Categoria = Categoria()
    var subCategoria : SubCategoria = SubCategoria()
    var especialidade : Especialidade = Especialidade()
    var servicos : [ServicoProfissional]?
    var localizacao : Localizacao = Localizacao()
    
}

func == (o1: Profissional, o2: Profissional) -> Bool {
    return o1.id == o2.id
}



