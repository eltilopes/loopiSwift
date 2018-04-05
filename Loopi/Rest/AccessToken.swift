//
//  AccessToken.swift
//  Loopi
//
//  Created by Loopi on 07/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class AccessToken{
    
    var token = ""
    
    @discardableResult
    func getAccessToken(completionHandler: @escaping (String?, NSError?) -> Void ) -> URLSessionTask {
        
        let bodyStr = "username=eltilopes@gmail.com&password=12345678&scope=read&client_id=smemobile&client_secret=lamperouge&grant_type=password"

        let myURL = NSURL(string: "http://192.168.0.13:8080/allinoneserver/oauth/token")!

        let request = NSMutableURLRequest(url: myURL as URL)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
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
                    
                    self.token = (tokenDictionary["access_token"] as? String)!
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
