import UIKit
import Alamofire
import PromiseKit

struct TokenManager
{
    private static var userDefaults = UserDefaults.standard
    private static var tokenKey = UserDefaults.standard.string(forKey: "tokenKey")
    static var date = Date()
    
    static var token:Token?
    {
        guard let tokenDict = userDefaults.dictionary(forKey: tokenKey!) else { return nil }
        
        let token = Token.instance(dictionary: tokenDict as NSDictionary)
        
        return token
    }
    
    static var tokenExist: Bool { return token != nil }
    
    static var tokenIsValid: Bool
    {
        if let expiringDate = userDefaults.value(forKey: "EXPIRING_DATE") as? Date
        {
            if date >= expiringDate
            {
                return false
            }else{
                return true
            }
        }
        return true
    }
    
    static func requestToken(request: TokenRequest) -> Promise<Void>
    {
        return Promise { fulFill, reject in
            
            TokenService.requestToken(request: request).then { (token: Token) -> Void in
                setToken(token: token)
                
                let today = Date()
                let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
                userDefaults.setValue(tomorrow, forKey: "EXPIRING_DATE")
                
                fulFill()
                }.catch { error in
                    reject(error)
            }
        }
    }
    
    static func refreshToken() -> Promise<Void>
    {
        return Promise { fulFill, reject in
            
            guard let token = token else { return }
            
            let  request = TokenRefresh(refreshToken: token.refreshToken)
            
            TokenService.refreshToken(request: request).then { (token: Token) -> Void in
                setToken(token: token)
                fulFill()
                }.catch { error in
                    reject(error)
            }
        }
    }
    
    private static func setToken (token:Token!)
    {
        userDefaults.setValue(token.toDictionary(), forKey: tokenKey)
    }
    
    static func deleteToken()
    {
        userDefaults.removeObject(forKey: tokenKey)
    }
}
