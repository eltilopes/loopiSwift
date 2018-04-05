//
//  Route.swift
//  Loopi
//
//  Created by Loopi on 12/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

class Route {
    var legs : [Leg]
    var summary: String
    func  getAllSteps()  -> [Step] {
        var result :[Step] = [Step]
        for leg in legs {
            result.addAll(leg.getStepList())
        }
        return result
    }
}
