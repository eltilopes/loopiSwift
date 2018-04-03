//
//  GoogleDirectionsResponse.swift
//  Loopi
//
//  Created by Loopi on 12/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import HandyJSON

class GoogleDirectionsResponse : HandyJSON {
    var routes : [Route]?
    
    required init() {   }
    
    func getDuration() -> String{
        return routes!.isEmpty ? "1 min" : routes![0].legs![0].duration!.text!;
    }
    
    func getDistance()-> String{
        if(routes!.isEmpty){
            return "Alguns metros";
        }
        let bairro :String = getBairro(endereco :routes![0].legs![0].end_address!);
        let distancia :String = routes![0].legs![0].distance!.text!;
        return bairro + " - " + distancia;
    }
    
    func getDistanceMeters() -> Int{
        return routes!.isEmpty ? 0 : routes![0].legs![0].distance!.value!;
    }
    
    func getBairro( endereco :String) -> String{
        var enderecos : [String] = endereco.components(separatedBy: ",");
        //retorno = enderecos[1].substring(enderecos[1].range(of: "-", options: .backwards)?.lowerBound ,enderecos[1].count).trim();
        return  enderecos[1];
    }

   
}
