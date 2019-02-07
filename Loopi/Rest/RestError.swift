//
//  RestError.swift
//  Loopi
//
//  Created by Loopi on 21/05/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit
import HandyJSON

class RestError : HandyJSON {
    required init() {}
    
    var erro = ""
    var descricao = ""
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.erro <-- RestConfig().ERROR
        mapper <<<
            self.descricao <-- RestConfig().ERROR_DESCRIPTION
    }
}


