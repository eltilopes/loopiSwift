//
//  AccessToken.swift
//  Loopi
//
//  Created by Loopi on 07/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import CommonCrypto

class AccessToken : RestAdapeter {
    
    var token = ""
    var controller: UIViewController = PedirConviteViewController()
    var usuarioSession = Usuario()
    @discardableResult
    func getAccessToken(usuario : Usuario,controller: UIViewController, completionHandler: @escaping (String?, NSError?) -> Void ) -> URLSessionTask {
        self.controller = controller
        self.usuarioSession = usuario
        let login: String = usuario.cpf ?? ""
        let senha: String = usuario.senha ?? ""
        let bodyStr = "username=\(String(describing: login))&password=\(String(describing: senha))&scope=read&client_id=appLoopi&client_secret=lamperouge&grant_type=password"
        
        print(bodyStr)
        let url = NSURL(string: API_URL + URL_OAUTH_TOKEN )!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = POST_METHOD
        request.setValue(HTTP_HEADER_VALUE_APPLICATION_FORM, forHTTPHeaderField: HTTP_HEADER_FIELD_CONTENT_TYPE)
        request.setValue(HTTP_HEADER_VALUE_APPLICATION_JSON, forHTTPHeaderField: HTTP_HEADER_FIELD_ACCEPT)
        request.httpBody = bodyStr.data(using: String.Encoding.utf8)!
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in
            if error != nil {
                self.token =  ""
                completionHandler(nil, error as NSError?)
                return
            }
            
            
            if let unwrappedData = data {
                
                do {
                    let tokenDictionary:NSDictionary = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    let user = tokenDictionary[self.USER] as? NSDictionary
                    if  !(self.isNull(someObject: user)){
                        //let usuario = Usuario.init(dictionary: user!)
                        let usuario = self.usuarioSession.getUsuario(dictionary: user!)
                        usuario.senha = self.usuarioSession.senha
                        UserDefaults.standard.setUsuario(usuario: usuario)
                        let login = (user![self.LOGIN] as? String)!
                        self.token = (tokenDictionary[self.ACCESS_TOKEN] as? String)!
                        UserDefaults.standard.setLogin(login: login)
                        //UserDefaults.standard.setIsLoggedIn(value: true)
                        UserDefaults.standard.setToken(token: self.token)
                        completionHandler(self.token,nil)
                    }else{
                        self.token =  ""
                        completionHandler(self.token,nil)
                    }
                    
                }
                catch {
                    self.token =  ""
                    completionHandler(self.token,nil)
                }
            }
        }
        task.resume()
        return task
    }
    
    @discardableResult
    func logoutUsuario(usuario : Usuario, completionHandler: @escaping (String?, NSError?) -> Void ) -> URLSessionTask {

        let cpf: String = usuario.cpf ?? ""
        let bodyStr = "?cpf=\(String(describing: cpf))"
        //let url = NSURL(string: "http://loopi.online/loopi" + URL_LISTAR_CATEGORIA + bodyStr )!
        var apiUrl = getApiUrl()
        let url = NSURL(string: apiUrl + URL_LOGOUT + bodyStr )!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = GET_METHOD
        let token = UserDefaults.standard.getToken()
        request.timeoutInterval = 10.0
        request.setValue("Bearer " + token, forHTTPHeaderField: HTTP_HEADER_FIELD_AUTHORIZATION)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                completionHandler(nil, error as NSError?)
                return
            }
            
            let jsonString = String(data: data!, encoding: .utf8)
            print(jsonString)
            completionHandler("OK",nil)
            
        }
        task.resume()
        return task
    }
    
    
    func md5(_ string: String) -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = string.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
    
    func isNull(someObject: AnyObject?) -> Bool {
        guard let someObject = someObject else {
            return true
        }
        
        return (someObject is NSNull)
    }
}
