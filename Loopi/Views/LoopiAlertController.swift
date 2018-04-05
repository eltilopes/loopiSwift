//
//  LoopiAlertController.swift
//  Loopi
//
//  Created by Loopi on 08/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class LoopiAlertController : UIAlertController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenBounds = UIScreen.main.bounds
        
        self.view.frame = CGRect(x:screenBounds.size.width*0.2, y:screenBounds.size.height*0.8, width:screenBounds.size.width*0.6, height:20)
    }
}
