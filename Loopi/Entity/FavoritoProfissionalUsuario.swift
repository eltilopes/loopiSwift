//
//  FavoritoProfissionalUsuario.swift
//  Loopi
//
//  Created by Loopi on 12/11/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit
import HandyJSON

class FavoritoProfissionalUsuario : HandyJSON {
    required init() {}
    
    var id : Int?
    var dataCriacao :  Date!
    var favorito : Bool?
    var usuario = UsuarioSession()
    var profissional  = Profissional()
    
}
