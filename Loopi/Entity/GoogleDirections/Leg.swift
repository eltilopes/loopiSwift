//
//  Leg.swift
//  Loopi
//
//  Created by Loopi on 12/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//
import HandyJSON

class Leg : HandyJSON{
    
    required init() {}
    
    var  distance:Distance?
    var  duration:Duration?
    var  end_address:String?
    var  steps: [Step]?
    
    func  getStepList()  -> [Step] {
        var result :[Step] = []
        for step in steps! {
            result.append(step)
        }
        return result
    }
   
}
