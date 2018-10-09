//
//  CategoriaRest.swift
//  Loopi
//
//  Created by Loopi on 05/04/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import SwiftyJSON

class CategoriaRest : RestAdapeter {
    
    var categorias: [Categoria] = []
    
    @discardableResult
    func carregarCategorias( completionHandler: @escaping ([Categoria]?,NSError?) -> Void ) -> URLSessionTask {
        var task = URLSessionTask()
        task = carregarCategoriasAcesso { (categorias, error) in
            if error == nil {
                self.categorias = categorias!
                completionHandler(self.categorias,nil)
            }else{
                task = self.carregarCategoriasAcesso { (categorias, error) in
                    if error == nil {
                        self.categorias = categorias!
                        completionHandler(self.categorias,nil)
                    }
                }
            }
            
          
        }
        task.resume()
        return task
    }
    
    @discardableResult
    func carregarCategoriasAcesso( completionHandler: @escaping ([Categoria]?,NSError?) -> Void ) -> URLSessionTask {
        let bodyStr = "?login=eltilopes"
        let url = NSURL(string: "http://loopi.online" + URL_LISTAR_CATEGORIA + bodyStr )!
        let request = NSMutableURLRequest(url: url as URL)
        let login = Login()
        let token = UserDefaults.standard.getToken()
        login.login = "eltilopes"
        request.httpMethod = GET_METHOD
        request.timeoutInterval = 10.0
        
        //request.addValue("Bearer " + token, forHTTPHeaderField: HTTP_HEADER_FIELD_AUTHORIZATION)
        //request.httpBody = bodyStr.data(using: String.Encoding.utf8)!
        request.setValue("Bearer " + token, forHTTPHeaderField: HTTP_HEADER_FIELD_AUTHORIZATION)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                completionHandler(nil, error as NSError?)
                return
            }
            
            let jsonString = String(data: data!, encoding: .utf8)
            let erro = self.getError(jsonString: jsonString!)
            if (erro?.erro.isBlank())! {
                self.categorias = [Categoria].deserialize(from: jsonString!)! as! [Categoria]
                completionHandler(self.categorias,nil)
            }else if (erro?.erro == self.INVALID_ACCESS_TOKEN){
                completionHandler(nil, error as NSError?)
            }
            
            
        }
        task.resume()
        return task
    }
    
}


