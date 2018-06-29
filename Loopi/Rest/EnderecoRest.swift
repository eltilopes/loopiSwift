//
//  EnderecoRest.swift
//  Loopi
//
//  Created by Loopi on 25/06/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit
import SwiftyJSON

class EnderecoRest : RestAdapeter {
    
    var endereco: EnderecoCEP = EnderecoCEP()
    
    @discardableResult
    func buscarEnderecoCEP(cep: String, completionHandler: @escaping (EnderecoCEP?,NSError?) -> Void ) -> URLSessionTask {
        let url = NSURL(string: BUSCAR_CEP_URL + cep )!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = GET_METHOD
        request.timeoutInterval = 10.0
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                completionHandler(nil, error as NSError?)
                return
            }
            if let data = data {
                DispatchQueue.main.async { // Correct
                    let jsonString = String(data: data, encoding: .utf8)
                    self.endereco = EnderecoCEP.deserialize(from: jsonString!)!
                    completionHandler(self.endereco,nil)
                }
            }
            
            
            
        }
        task.resume()
        return task
    }
    
  
}



