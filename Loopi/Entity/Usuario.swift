//
//  Usuario.swift
//  Loopi
//
//  Created by Loopi on 20/07/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import HandyJSON

class Usuario : NSObject, HandyJSON {
    required override init() {}
    
    var id : Int64?
    var nome : String?
    var senha : String?
    var login : String?
    var cpf : String?
    
   
    init(dictionary: NSDictionary) {
      
       
        
        super.init()
        // Loop
        for (key, value) in dictionary {
            let keyName = key as! String
            
            switch(keyName){
            case "id":
                let keyValue = value as! NSNumber
                self.id = keyValue.int64Value
                break
            case "nome":
                self.nome = getKeyValue(value: value)
                break
            case "senha":
                self.senha = getKeyValue(value: value)
                break
            case "login":
                self.login = getKeyValue(value: value)
                break
            case "cpf":
                self.cpf = getKeyValue(value: value)
                break
            default:
                break
            }
        }
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
