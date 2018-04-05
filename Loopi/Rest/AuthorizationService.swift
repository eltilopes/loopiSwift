import Foundation
import EVReflection
import Alamofire
import SwiftyJSON
import PromiseKit
import UIKit

struct AuthorizationService: NetworkService
{
    private static var authorizedHeader:[String: String]
    {
        guard let accessToken = TokenManager.token?.accessToken else
        {
            return ["Authorization": ""]
        }
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    // MARK: - POST
    
    static func POST<T:EVObject> (URL: String, parameters: [String: AnyObject], encoding: ParameterEncoding) -> Promise<T>
    {
        return firstly
            {
                return POST(URL: URL, parameters: parameters, headers: authorizedHeader, encoding: encoding)
                
            }.catch { error in
                
                switch ((error as NSError).code)
                {
                case 401:
                    _ = TokenManager.refreshToken().then { return POST(URL: URL, parameters: parameters, encoding: encoding) }
                default: break
                }
        }
    }
}
