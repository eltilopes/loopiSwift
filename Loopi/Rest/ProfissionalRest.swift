//
//  ProfissionalRest.swift
//  Loopi
//
//  Created by Loopi on 12/11/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit
import SwiftyJSON

class ProfissionalRest : RestAdapeter {
    
    var favoritos: [FavoritoProfissionalUsuario] = []
    var favorito = FavoritoProfissionalUsuario()
    
    @discardableResult
    func getFavoritosProfissional(favoritoProfissionalUsuario : FavoritoProfissionalUsuario, completionHandler: @escaping ([FavoritoProfissionalUsuario]?,NSError?) -> Void ) -> URLSessionTask {
        let favoritoProfissionalUsuarioDict = convertToDictionary(jsonString: favoritoProfissionalUsuario.toJSONString(prettyPrint: true)! )!
        let url = NSURL(string: API_URL + URL_LISTAR_FAVORITO )!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = POST_METHOD
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 100.0
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_CONTENT_TYPE)
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_ACCEPT)
        if let jsonData = try? JSONSerialization.data(withJSONObject: favoritoProfissionalUsuarioDict, options: []) {
            request.httpBody = jsonData
        }
        
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                print(error)
                completionHandler(nil, error as NSError?)
                return
            }
            
            let jsonString = String(data: data!, encoding: .utf8)
            if jsonString?.isNotEmptyAndContainsNoWhitespace() ?? false {
                self.favoritos = [FavoritoProfissionalUsuario].deserialize(from: jsonString!)! as! [FavoritoProfissionalUsuario]
            }
            completionHandler(self.favoritos,nil)
            
        }
        task.resume()
        return task
    }
    
    
    @discardableResult
    func setFavoritoProfissional(favoritoProfissionalUsuario : FavoritoProfissionalUsuario, completionHandler: @escaping (FavoritoProfissionalUsuario?,NSError?) -> Void ) -> URLSessionTask {
        let favoritoProfissionalUsuarioDict = convertToDictionary(jsonString: favoritoProfissionalUsuario.toJSONString(prettyPrint: true)! )!
        let url = NSURL(string: API_URL + URL_SALVAR_FAVORITO )!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = POST_METHOD
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 100.0
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_CONTENT_TYPE)
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_ACCEPT)
        if let jsonData = try? JSONSerialization.data(withJSONObject: favoritoProfissionalUsuarioDict, options: []) {
            request.httpBody = jsonData
        }
        
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                print(error)
                completionHandler(nil, error as NSError?)
                return
            }
            
            let jsonString = String(data: data!, encoding: .utf8)
            if jsonString?.isNotEmptyAndContainsNoWhitespace() ?? false {
                self.favorito = FavoritoProfissionalUsuario.deserialize(from: jsonString!)!
            }
            completionHandler(self.favorito,nil)
            
        }
        task.resume()
        return task
    }
    
    @discardableResult
    func removerFavoritoProfissional(favoritoProfissionalUsuario : FavoritoProfissionalUsuario, completionHandler: @escaping (Bool,NSError?) -> Void ) -> URLSessionTask {
        let favoritoProfissionalUsuarioDict = convertToDictionary(jsonString: favoritoProfissionalUsuario.toJSONString(prettyPrint: true)! )!
        let url = NSURL(string: API_URL + URL_REMOVER_FAVORITO )!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = POST_METHOD
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 100.0
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_CONTENT_TYPE)
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_ACCEPT)
        if let jsonData = try? JSONSerialization.data(withJSONObject: favoritoProfissionalUsuarioDict, options: []) {
            request.httpBody = jsonData
        }
        
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                print(error)
                completionHandler(false, error as NSError?)
                return
            }
            
            let jsonString = String(data: data!, encoding: .utf8)
            print(jsonString)
            completionHandler(true,nil)
            
        }
        task.resume()
        return task
    }
    
    
    
    
    
}

