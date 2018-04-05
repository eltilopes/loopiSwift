import Foundation
import EVReflection
import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit

struct AuthenticationManager
{
    static func authenticate(username:String!, password:String!) -> Promise<Void>
    {
        let request = TokenRequest(username: username, password: password)
        
        return TokenManager.requestToken(request: request)
    }
}
