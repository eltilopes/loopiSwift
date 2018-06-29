//
//  UserDefaultsExtension.swift
//  Loopi
//
//  Created by Loopi on 07/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
    }
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func setToken(token: String) {
        set(token, forKey: RestConfig().TOKEN)
        synchronize()
    }
    
    func getToken() -> String {
        if let token = string(forKey: RestConfig().TOKEN) {
            return token
        }
        return ""
    }
    
    func setLogin(login: String) {
        set(login, forKey: RestConfig().LOGIN)
        synchronize()
    }
    
    func getLogin() -> String {
        if let login = string(forKey: RestConfig().LOGIN) {
            return login
        }
        return ""
    }
    
    func setLocalizacao(localizacao: String) {
        set(localizacao, forKey: RestConfig().LOCALIZACAO)
        synchronize()
    }
    
    func getLocalizacao() -> String {
        if let localizacao = string(forKey: RestConfig().LOCALIZACAO) {
            return localizacao
        }
        return ""
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}

