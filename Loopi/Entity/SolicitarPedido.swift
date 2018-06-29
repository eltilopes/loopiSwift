//
//  SolicitarPedido.swift
//  Loopi
//
//  Created by Loopi on 04/06/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit
import HandyJSON

class SolicitarPedido : HandyJSON {
    required init() {}
    
    var loginSolicitante : String?
    var idProfissional : Int?
    var idServicos : [Int] = []
    var solicitado = false
    
    init(servicoCard : ServicoCard) {
        self.idProfissional = servicoCard.id
        self.loginSolicitante = UserDefaults.standard.getLogin()
        for s in servicoCard.servicos! {
            if(s.selecionado){
                self.idServicos.append(s.id!)
            }
        }
    }
}
