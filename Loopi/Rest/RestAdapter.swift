//
//  RestAdapter.swift
//  Loopi
//
//  Created by Loopi on 13/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import SwiftyJSON

class RestAdapeter : RestConfig{
    
    func convertToDictionary(jsonString: String) -> [String: Any]? {
        if let data = jsonString.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func getError(jsonString: String,controller: UIViewController)->RestError?{
        
        if jsonString.contains(ERROR) &&  jsonString.contains(ERROR_DESCRIPTION)  &&  jsonString.contains(INVALID_ACCESS_TOKEN) {
            reLogIn(controller: controller)
            return RestError.deserialize(from: jsonString)
        }
        if jsonString.contains(ERROR) &&  jsonString.contains(ERROR_DESCRIPTION) {
            return RestError.deserialize(from: jsonString)
        }
        //UserDefaults.standard.setToken(token: "b10680c7-9439-471c-a1e3-e051960f1000")
        return RestError()
    }
    
    
    func reLogIn(controller: UIViewController) {
        let accessToken = AccessToken()
        var retorno = ""
        let u = Usuario()
        accessToken.getAccessToken(usuario : u, controller: controller){ tok, error in
            if error == nil {
                retorno = tok!
                if !retorno.isEmpty {
                    //UserDefaults.standard.setIsLoggedIn(value: true)
                    UserDefaults.standard.setToken(token: retorno)
                }
            }
        }   
    }
}


