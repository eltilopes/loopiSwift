import UIKit
import Foundation
import EVReflection
import Alamofire
import SwiftyJSON
import PromiseKit

struct TokenService: NetworkService
{
    static func requestToken (request: TokenRequest) -> Promise<Token> { return POST(request: request) }
    
    static func refreshToken (request: TokenRefresh) -> Promise<Token> { return POST(request: request) }
    
    // MARK: - POST
    
    private static func POST<T:EVReflectable>(request: T) -> Promise<Token>
    {
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        
        let parameters = request.toDictionary(.DefaultDeserialize) as! [String : AnyObject]
        
        return POST(URL: URLS.auth.token, parameters: parameters, headers: headers, encoding: URLEncoding.default)
    }
}
