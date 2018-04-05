//
//  ServicoCard.swift
//  Loopi
//
//  Created by Loopi on 27/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import HandyJSON

class ServicoCard : Equatable,HandyJSON {
    required init() {}
    
    var id : Int?
    var title : String?
    var thumbnail : String?
    var latitude : String?
    var longitude : String?
    // var distancia : String = "Distância não calculada"
    // var distanciaMetros : Int = 0
    // var quantidadeFavorito : Int = 0
    var duracao : String = "Tempo não calculado"
    // var pesquisaOtimizada : String?
    var tempo : Int?
    var estrelas : Int?
    var favorito : Bool?
    // var favorito : Int?
    var categoria : Categoria = Categoria()
    var subCategoria : SubCategoria = SubCategoria()
    var especialidade : Especialidade = Especialidade()
    var profissional : Profissional = Profissional()
  
}

func == (sc1: ServicoCard, sc2: ServicoCard) -> Bool {
    return sc1.id == sc2.id
}
