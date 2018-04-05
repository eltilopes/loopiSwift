
import EVReflection
import Alamofire
import SwiftyJSON
import PromiseKit
import AlamofireObjectMapper

protocol NetworkService
{
    static func POST<T:EVObject>(URL: String, parameters: [String: AnyObject]?, headers: [String: String]?, encoding: ParameterEncoding) -> Promise<T>
    
}

extension NetworkService
{
    // MARK: - POST
    
    static func POST<T:EVObject>(URL: String,
                                 parameters: [String: AnyObject]? = nil,
                                 headers: [String: String]? = nil, encoding: ParameterEncoding) -> Promise<T>
    {
        return Alamofire.request(URL,
                                 method: .post,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: headers).responseObject()
    }
}
