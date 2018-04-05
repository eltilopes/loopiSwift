//
//  Localizacao.swift
//  Loopi
//
//  Created by Loopi on 27/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit
import HandyJSON

class Localizacao : Equatable,HandyJSON {
    required init() {   }
    
    var id : Int?
    var nome : String?
    var ultimaLocalizacao : String?
    var latitude : Double?
    var longitude : Double?
    var dataLocalizacao : Int?
    var tipoLocalizacao : TipoLocalizacao?
}

func == (o1: Localizacao, o2: Localizacao) -> Bool {
    return o1.id == o2.id
}

