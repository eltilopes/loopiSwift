//
//  LoopiAlertController.swift
//  Loopi
//
//  Created by Loopi on 08/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class LoopiAlertController : UIAlertController {
    
    let margin:CGFloat = 10.0
    var backgroundColorLoopiAlert = GMColor.backgroundAlertColor()
    func setBackgroundColorLoopiAlert (backgroundColorLoopiAlert : UIColor) {
        self.backgroundColorLoopiAlert = backgroundColorLoopiAlert
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.superview?.isUserInteractionEnabled = true
        self.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        let subview = (self.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        let width = self.view.bounds.width
        let height = UIScreen.main.bounds.height
        subview.backgroundColor = self.backgroundColorLoopiAlert
        self.view.frame = CGRect(x:margin * 2.0, y:height*0.7, width: width - margin , height:height*0.2)
        
    }
    
    @objc func alertControllerBackgroundTapped(){
        self.dismiss(animated: true, completion: nil)
    }
}
