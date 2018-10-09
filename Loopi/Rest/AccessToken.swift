//
//  AccessToken.swift
//  Loopi
//
//  Created by Loopi on 07/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class AccessToken : RestAdapeter {
    
    var token = ""
    
    @discardableResult
    func getAccessToken(completionHandler: @escaping (String?, NSError?) -> Void ) -> URLSessionTask {
        
        let bodyStr = "username=eltilopes@gmail.com&password=12345678&scope=read&client_id=smemobile&client_secret=lamperouge&grant_type=password"

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
                    
                    let usuario = Usuario.init(dictionary: user!)
                    
                    UserDefaults.standard.setUsuario(usuario: usuario)
                    let login = (user![self.LOGIN] as? String)!
                    self.token = (tokenDictionary[self.ACCESS_TOKEN] as? String)!
                    UserDefaults.standard.setLogin(login: login)
                    UserDefaults.standard.setIsLoggedIn(value: true)
                    UserDefaults.standard.setToken(token: self.token)
                    completionHandler(self.token,nil)
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
}
