//
//  LocationFooter.swift
//  Loopi
//
//  Created by Loopi on 06/04/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import HandyJSON

class LocationFooter : HandyJSON {
    required init() {}
    
    var nome: String!
    var acao: String!
    var descricao: String!
    var imageIconName: String!
    let imageActionName = "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_more_vert_white_24px.svg?alt=media&token=aa158e57-2e46-43f4-870f-a395a672ca77"
    
    init(nome: String,acao: String,descricao: String,imageIconName: String) {
        self.nome = nome
        self.acao = acao
        self.descricao = descricao
        self.imageIconName = imageIconName
        
    }
    
}
