//
//  UsuarioRest.swift
//  Loopi
//
//  Created by Loopi on 03/12/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit
import SwiftyJSON

class UsuarioRest : RestAdapeter {
    
    var usuario = Usuario()
    
    @discardableResult
    func editarUsuario(usuario : Usuario, completionHandler: @escaping (Usuario?,NSError?) -> Void ) -> URLSessionTask {
        print(usuario.toJSONString(prettyPrint: true)!)
        let usuarioDict = convertToDictionary(jsonString: usuario.toJSONString(prettyPrint: true)! )!
        print(usuarioDict.jsonString!)
        let url = NSURL(string: API_URL + URL_EDITAR_USUARIO )!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = POST_METHOD
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 100.0
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_CONTENT_TYPE)
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_ACCEPT)
        request.addValue("Bearer " + UserDefaults.standard.getToken(), forHTTPHeaderField: HTTP_HEADER_FIELD_AUTHORIZATION)
        if let jsonData = try? JSONSerialization.data(withJSONObject: usuarioDict, options: []) {
            request.httpBody = jsonData
        }
        
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                completionHandler(nil, error as NSError?)
                return
            }
            
            
            let jsonString = String(data: data!, encoding: .utf8)
            if jsonString?.isNotEmptyAndContainsNoWhitespace() ?? false {
                self.usuario = Usuario.deserialize(from: jsonString!)!
            }
            completionHandler(self.usuario,nil)
        }
        task.resume()
        return task
    }
    
    @discardableResult
    func resgatarSenha(usuario : Usuario, completionHandler: @escaping (Usuario?,NSError?) -> Void ) -> URLSessionTask {
        print(usuario.toJSONString(prettyPrint: true)!)
        let usuarioDict = convertToDictionary(jsonString: usuario.toJSONString(prettyPrint: true)! )!
        print(UserDefaults.standard.getToken())
        let cpf = usuario.cpf
        let url = NSURL(string: API_URL + URL_RESGATAR_SENHA)!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = POST_METHOD
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 100.0
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_CONTENT_TYPE)
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_ACCEPT)
        //request.addValue("Bearer " + UserDefaults.standard.getToken(), forHTTPHeaderField: HTTP_HEADER_FIELD_AUTHORIZATION)
        if let jsonData = try? JSONSerialization.data(withJSONObject: usuarioDict, options: []) {
            request.httpBody = jsonData
        }
        
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                completionHandler(nil, error as NSError?)
                return
            }
            
            
            let jsonString = String(data: data!, encoding: .utf8)
            if jsonString?.isNotEmptyAndContainsNoWhitespace() ?? false {
                self.usuario = Usuario.deserialize(from: jsonString!)!
            }
            completionHandler(self.usuario,nil)
        }
        task.resume()
        return task
    }
    
    @discardableResult
    func alterarSenha(alterarSenhaVo : AlterarSenhaVo, completionHandler: @escaping (Usuario?,String,NSError?) -> Void ) -> URLSessionTask {
        let alterarSenhaVoDict = convertToDictionary(jsonString: alterarSenhaVo.toJSONString(prettyPrint: true)! )!
        print(alterarSenhaVoDict.jsonString!)
        let url = NSURL(string: API_URL + URL_ALTERAR_SENHA)!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = POST_METHOD
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 100.0
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_CONTENT_TYPE)
        request.addValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_ACCEPT)
        //request.addValue("Bearer " + UserDefaults.standard.getToken(), forHTTPHeaderField: HTTP_HEADER_FIELD_AUTHORIZATION)
        if let jsonData = try? JSONSerialization.data(withJSONObject: alterarSenhaVoDict, options: []) {
            request.httpBody = jsonData
        }
        
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                completionHandler(nil,"", error as NSError?)
                return
            }
            
            
            let jsonString = String(data: data!, encoding: .utf8)
            let erro = self.getError(jsonString: jsonString!)
            if (erro?.erro.isBlank())! {
                if jsonString?.isNotEmptyAndContainsNoWhitespace() ?? false {
                    self.usuario = Usuario.deserialize(from: jsonString!)!
                    completionHandler(self.usuario,"",nil)
                }
            }else {
                completionHandler(nil,(erro?.erro)!, nil)
            }
        }
        task.resume()
        return task
    }
    
}


