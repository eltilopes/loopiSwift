//
//  Polyline.swift
//  Loopi
//
//  Created by Loopi on 12/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//
import HandyJSON

class Polyline : HandyJSON{
    
    required init() {}
    var points : String?
    
    func decodePoints() -> [RoutePoint]{
        var ret : [RoutePoint] = []
        return ret
    }
    
}
