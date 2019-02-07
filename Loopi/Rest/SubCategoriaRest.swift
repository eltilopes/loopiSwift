//
//  SubCategoriaRest.swift
//  Loopi
//
//  Created by Loopi on 05/02/19.
//  Copyright © 2019 Loopi. All rights reserved.
//


import UIKit
import SwiftyJSON

class SubCategoriaRest : RestAdapeter {
    
    var subs: [SubCategoria] = []
    
    @discardableResult
    func carregarSubCategorias( completionHandler: @escaping ([SubCategoria]?,NSError?) -> Void ) -> URLSessionTask {
        var task = URLSessionTask()
        task = carregarSubCategoriasAcesso { (subCategorias, error) in
            if error == nil {
                self.subs = subCategorias!
                completionHandler(self.subs,nil)
            }else{
                task = self.carregarSubCategoriasAcesso { (subCategorias, error) in
                    if error == nil {
                        self.subs = subCategorias!
                        completionHandler(self.subs,nil)
                    }
                }
            }
            
            
        }
        task.resume()
        return task
    }
    
    @discardableResult
    func carregarSubCategoriasAcesso( completionHandler: @escaping ([SubCategoria]?,NSError?) -> Void ) -> URLSessionTask {
        let categoria = Categoria()
        categoria.id = 1
        categoria.descricao = ""
        categoria.urlImagem = ""
        let url = NSURL(string: API_URL + URL_LISTAR_SUB_CATEGORIA )!
        let categoriaDict = convertToDictionary(jsonString: categoria.toJSONString(prettyPrint: true)! )!
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = POST_METHOD
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 10.0
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_CONTENT_TYPE)
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_ACCEPT)
        
        let controller = PedirConviteViewController() as UIViewController
        let token = UserDefaults.standard.getToken()
        
        request.setValue("Bearer " + token, forHTTPHeaderField: HTTP_HEADER_FIELD_AUTHORIZATION)
        if let jsonData = try? JSONSerialization.data(withJSONObject: categoriaDict, options: []) {
            request.httpBody = jsonData
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                print(error?.localizedDescription ?? "errou")
                completionHandler(nil, error as NSError?)
                return
            }
            
            let jsonString = String(data: data!, encoding: .utf8)
            let erro = self.getError(jsonString: jsonString!, controller: controller)
            if (erro?.erro.isBlank())! {
                self.subs = [SubCategoria].deserialize(from: jsonString!)! as! [SubCategoria]
                completionHandler(self.subs,nil)
            }else if (erro?.erro == self.INVALID_ACCESS_TOKEN){
                completionHandler(nil, error as NSError?)
            }
            
            
        }
        task.resume()
        return task
    }
    
}


