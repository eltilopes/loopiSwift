//
//  UsuarioSession.swift
//  Loopi
//
//  Created by Loopi on 27/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//
import UIKit
import HandyJSON

class UsuarioSession : Equatable,HandyJSON {
    required init() {}
    
    var id : Int?
    var nome : String?
    var senha : String?
    
}

func == (c1: UsuarioSession, c2: UsuarioSession) -> Bool {
    return c1.id == c2.id
}
