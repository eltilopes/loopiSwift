//
//  Usuario.swift
//  Loopi
//
//  Created by Loopi on 20/07/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import HandyJSON

class Usuario :  HandyJSON {
    required init() {}
    
    var id : Int64?
    var nome : String?
    var senha : String?
    var login : String?
    var cpf : String?
    var telefone : String?
    var urlImagem : String?
    
    func  getUsuario(dictionary: NSDictionary)  -> Usuario {
        let usuario = Usuario()
        for (key, value) in dictionary {
            let keyName = key as! String
            
            switch(keyName){
            case "id":
                let keyValue = value as! NSNumber
                usuario.id = keyValue.int64Value
                break
            case "nome":
                usuario.nome = getKeyValue(value: value)
                break
            case "senha":
                usuario.senha = getKeyValue(value: value)
                break
            case "login":
                usuario.login = getKeyValue(value: value)
                break
            case "cpf":
                usuario.cpf = getKeyValue(value: value)
                break
            case "telefone":
                usuario.telefone = getKeyValue(value: value)
                break
            case "urlImagem":
                usuario.urlImagem = getKeyValue(value: value)
                break
            default:
                break
            }
        }
        return usuario
    }
   
 
    
    func getKeyValue(value: Any)  -> String {
        var valueString: String
        if let keyValue = value as? String{
            valueString = keyValue
        }else{
            valueString = ""
        }
        return valueString
    }
    
   
    
}
