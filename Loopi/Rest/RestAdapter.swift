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
    
    func getError(jsonString: String)->RestError?{
        print(jsonString)
        let restError = RestError()
        if jsonString.contains(ERRORS) &&  jsonString.contains(MESSAGE) &&  jsonString.contains(CODIGO_NAO_CONFERE) {
            restError.erro = CODIGO_NAO_CONFERE
            restError.descricao = CODIGO_NAO_CONFERE
            return restError
        }
        return restError
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
    
    func getApiUrl() -> String {
        var apiUrl = API_URL
        if API_URL.range(of:HTTPS) != nil {
            apiUrl = API_URL.replacingOccurrences(of: HTTPS, with: HTTP)
        }
        return apiUrl
    }
    
    
}


