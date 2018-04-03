//
//  Route.swift
//  Loopi
//
//  Created by Loopi on 12/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//
import HandyJSON

class Route : HandyJSON{
    
    required init() {}
    
    var legs : [Leg]?
    var summary: String?
    func  getAllSteps()  -> [Step] {
        var result :[Step] = []
        for leg in legs! {
            result.append(contentsOf: leg.getStepList())
        }
        return result
    }
}
