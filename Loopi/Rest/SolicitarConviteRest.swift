//
//  SolicitarConviteRest.swift
//  Loopi
//
//  Created by Loopi on 20/10/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit
import SwiftyJSON

class SolicitarConviteRest : RestAdapeter {
    
    
    @discardableResult
    func solicitarConvite(solicitarConvite : SolicitarConvite, completionHandler: @escaping (Usuario?,NSError?) -> Void ) -> URLSessionTask {
        let solicitarConviteDict = convertToDictionary(jsonString: solicitarConvite.toJSONString(prettyPrint: true)! )!
        let url = NSURL(string: API_URL + URL_SOLICITAR_CONVITE )!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = POST_METHOD
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 100.0
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_CONTENT_TYPE)
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_ACCEPT)
        if let jsonData = try? JSONSerialization.data(withJSONObject: solicitarConviteDict, options: []) {
            request.httpBody = jsonData
        }
        
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                print(error)
                completionHandler(nil, error as NSError?)
                return
            }
            
            let jsonString = String(data: data!, encoding: .utf8)
            let usuario = Usuario.deserialize(from: jsonString!)!
            //UserDefaults.standard.setTemConvite(value: true)
            completionHandler(usuario,nil)
            
        }
        task.resume()
        return task
    }
    
   
    
   
    
}

