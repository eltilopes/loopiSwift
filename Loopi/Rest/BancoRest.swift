//
//  BancoRest.swift
//  Loopi
//
//  Created by Loopi on 20/04/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit
import SwiftyJSON

class BancoRest : RestAdapeter {
    
    var bancos: [Banco] = []
    
    /*
    @discardableResult
    func carregarBancos( completionHandler: @escaping ([Banco]?,NSError?) -> Void ) -> URLSessionTask {
        let url = NSURL(string: API_URL + URL_LISTAR_CATEGORIA )!
        let request = NSMutableURLRequest(url: url as URL)
        let bodyStr = "login=eltilopes"
        
        request.httpMethod = GET_METHOD
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 10.0
        request.addValue("Bearer 75edac51-1365-4ab0-8d56-ce01cc33b85b", forHTTPHeaderField: HTTP_HEADER_FIELD_AUTHORIZATION)
        request.httpBody = bodyStr.data(using: String.Encoding.utf8)!
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                completionHandler(nil, error as NSError?)
                return
            }
            
            let jsonString = String(data: data!, encoding: .utf8)
            self.categorias = [Categoria].deserialize(from: jsonString!)! as! [Categoria]
            completionHandler(self.categorias,nil)
            
        }
        task.resume()
        return task
    }
 */
    public func getBancos() -> [Banco] {
        var b = Banco()
        b.descricao = "Banco Brasil"
        b.id = 1
        bancos.append(b)
        b = Banco()
        b.descricao = "CEF"
        b.id = 2
        bancos.append(b)
        b = Banco()
        b.descricao = "BNB"
        b.id = 3
        bancos.append(b)
        
        return bancos
    }
}



