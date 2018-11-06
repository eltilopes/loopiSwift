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
    var controller: UIViewController = PedirConviteViewController()
    
    @discardableResult
    func getAccessToken(usuario : Usuario,controller: UIViewController, completionHandler: @escaping (String?, NSError?) -> Void ) -> URLSessionTask {
        self.controller = controller
        let login: String = usuario.login ?? ""
        let senha: String = usuario.senha ?? ""
        let bodyStr = "username=\(String(describing: login))&password=\(String(describing: senha))&scope=read&client_id=smemobile&client_secret=lamperouge&grant_type=password"

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
                    //UserDefaults.standard.setIsLoggedIn(value: true)
                    UserDefaults.standard.setToken(token: self.token)
                    DispatchQueue.main.async(execute: {
                        //UserDefaults.standard.setTemConvite(value: false)
                        //controller.present(CardsServiceController.fromStoryboard(), animated: true, completion: nil)
                        
                        /*
                         
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle:  Bundle.main)
                        // "MiniGameView" is the ID given to the ViewController in the interfacebuilder
                        // MiniGameViewController is the CLASS name of the ViewController.swift file acosiated to the ViewController
                        let setViewController = mainStoryboard.instantiateViewController(withIdentifier: "CardsServiceController") as! CardsServiceController
                        controller.navigationController?.setViewControllers([setViewController], animated: true)
                        
                         
                         //UserDefaults.standard.setTemConvite(value: true)
                         //let viewController = controller.storyboard?.instantiateViewController(withIdentifier: "CardsServiceController") as! CardsServiceController
                         let viewController = controller.storyboard?.instantiateViewController(withIdentifier: "mainNavigationController") as! MainNavigationController
                         controller.navigationController?.pushViewController(viewController, animated: true)
                         
                         
                         
                         
                         
                         let cardsServiceController = CardsServiceController()
                         controller.present(cardsServiceController, animated: true, completion: nil)
                         
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "mainNavigationController")
                        controller.present(vc, animated: true, completion: nil)
                        */
                        
                    })
                    //controller.performSegue(withIdentifier: "mainSegue", sender: usuario)
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
