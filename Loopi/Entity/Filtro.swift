//
//  Filtro.swift
//  Loopi
//
//  Created by Loopi on 02/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//
//
//  ServicoCard.swift
//  Loopi
//
//  Created by Loopi on 27/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import HandyJSON

class Filtro : HandyJSON {
    required init() {}
    
    var pesquisaToolbar : String?
    var idUsuario : Int64?
    var menorValor : Bool?
    var distanciaMenor : Bool?
    var ordemAlfabeticaCrescente : Bool?
    var categoria : Categoria = Categoria()
    var subCategoria : SubCategoria = SubCategoria()
    var especialidade : Especialidade = Especialidade()
    var minhaLatLng : LatLng = LatLng()
    
}


