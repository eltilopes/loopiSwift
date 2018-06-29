//
//  Solicitacao.swift
//  Loopi
//
//  Created by Loopi on 12/06/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit
import HandyJSON

protocol SolicitacaoStatusEnum  {
    var descricao: String { get }
    var cor: UIColor { get }
}

enum SolicitacaoStatusType : Int, SolicitacaoStatusEnum {
    case CANCELADO = 0
    case EM_ABERTO = 1
    case CONCLUIDO = 2
    
    var descricao: String {
        switch self {
        case .CANCELADO:
            return "Cancelado"
        case .EM_ABERTO:
            return "Em Aberto"
        case .CONCLUIDO:
            return "Concluido"
        }
    }
    
    var cor: UIColor {
        switch self {
        case .CANCELADO:
            return GMColor.textColorRed()
        case .EM_ABERTO:
            return GMColor.textColorYellow()
        case .CONCLUIDO:
            return GMColor.textColorGreen()
        }
    }
}

class Solicitacao : HandyJSON {
    required init() {}
    
    var numero : String!
    var cliente : String!
    var data : Date!
    var status : SolicitacaoStatusType!
    
    init(numero : String, cliente : String, data : Date, status : SolicitacaoStatusType) {
        self.data = data
        self.cliente = cliente
        self.status = status
        self.numero = numero
    }
    
    func dataFormatada() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/aaaa"
        return formatter.string(from: data)
    }
}

