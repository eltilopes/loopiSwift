//
//  ServicoCardRest.swift
//  Loopi
//
//  Created by Loopi on 02/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import SwiftyJSON

class ServicoCardRest : RestAdapeter {
    
    var servicoCards: [ServicoCard] = []
    
    @discardableResult
    func carregarCardsServicos(filtro : Filtro, completionHandler: @escaping ([ServicoCard]?,NSError?) -> Void ) -> URLSessionTask {
        let usuario = UserDefaults.standard.getUsuario()
        filtro.idUsuario = usuario.id
        let filtroDict = convertToDictionary(jsonString: filtro.toJSONString(prettyPrint: true)! )!
        let url = NSURL(string: API_URL + URL_LISTAR_SERVICO )!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = POST_METHOD
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 10.0
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_CONTENT_TYPE)
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_ACCEPT)
        if let jsonData = try? JSONSerialization.data(withJSONObject: filtroDict, options: []) {
            request.httpBody = jsonData
        }
        
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                completionHandler(nil, error as NSError?)
                return
            }
            
            let jsonString = String(data: data!, encoding: .utf8)
            if (jsonString?.isEmptyAndContainsNoWhitespace())! {
                self.servicoCards = []
            }else{
                self.servicoCards = [ServicoCard].deserialize(from: jsonString!)! as! [ServicoCard]
                self.prepareServicoCards()
            }
            
            completionHandler(self.servicoCards,nil)
            
        }
        task.resume()
        return task
    }
    
    func prepareServicoCards() {
        
        for sc in servicoCards {
            let directionUtilsRest = GoogleDirectionsRest()
            var googleDirectionsResponse :  GoogleDirectionsResponse = GoogleDirectionsResponse()
            if let localizacao = UserDefaults.standard.object(forKey: "localizacao") as? Dictionary<String, Any> {
                guard let lat = localizacao["lat"], let long = localizacao["long"] else { return }
                let start = LatLng(lat: lat as! Double, lng: long as! Double )
                let end = LatLng(lat: (sc.latitude! as NSString).doubleValue, lng: (sc.longitude! as NSString).doubleValue)
                directionUtilsRest.getGoogleDirectionsResponse(start: start,end:end){ gdr, error in
                    
                    if error == nil {
                        googleDirectionsResponse = gdr!
                        sc.duracao = googleDirectionsResponse.getDuration()
                        sc.distancia = googleDirectionsResponse.getDistance()
                        //print(googleDirectionsResponse.getBairro())
                    }else{
                        print(error?.localizedDescription)
                    }
                }
            }
            
        }
    }
    
    
    @discardableResult
    func solicitarServico(servico : ServicoCard, completionHandler: @escaping (Bool?,NSError?) -> Void ) -> URLSessionTask {
        let solicitarPedido = SolicitarPedido(servicoCard: servico)
        let jsonString = solicitarPedido.toJSONString(prettyPrint: true)!
        let solicitarPedidoDict = convertToDictionary(jsonString: jsonString )!
        let url = NSURL(string: API_URL + URL_SOLICITAR_SERVICO )!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = POST_METHOD
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 10.0
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_CONTENT_TYPE)
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_ACCEPT)
        if let jsonData = try? JSONSerialization.data(withJSONObject: solicitarPedidoDict, options: []) {
            request.httpBody = jsonData
        }
        
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                completionHandler(nil, error as NSError?)
                return
            }
            
            let jsonString = String(data: data!, encoding: .utf8)
            let solicitarPedido = SolicitarPedido.deserialize(from: jsonString!)! 
            completionHandler(solicitarPedido.solicitado,nil)
            
        }
        task.resume()
        return task
    }
    
}

