//
//  MainNavigationController.swift
//  Loopi
//
//  Created by Loopi on 07/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    @IBOutlet var menu : UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = GMColor.colorPrimary()
        
        let logged = isLoggedIn()
        if logged {
            // let cardsServiceController = CardsServiceController()
            // viewControllers = [cardsServiceController]
            // UserDefaults.standard.setIsLoggedIn(value: true)
        } else {
            perform(#selector(presentLoginController), with: nil, afterDelay: 0.0)
        }
        UserDefaults.standard.setIsLoggedIn(value: false)
        perform(#selector(presentLoginController), with: nil, afterDelay: 0.0)
    }
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }

    @objc func presentLoginController() {
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
   
}

