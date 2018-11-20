//
//  ActivityIndicator.swift
//  Loopi
//
//  Created by Loopi on 23/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class ActivityProgressLoopi: NSObject {
    
    var progressLoopiIndicator:UIActivityIndicatorView!
    
    func startActivity(controller:UIViewController) -> UIActivityIndicatorView
    {
        let x = controller.view.bounds.midX
        let y = controller.view.bounds.midY
        //let width = controller.view.bounds.width * 2/3
        //let height = controller.view.bounds.height * 1/3
        let width = controller.view.bounds.width
        let height = controller.view.bounds.height
        self.progressLoopiIndicator = UIActivityIndicatorView(frame:CGRect(x:x,y:y, width:width, height:height)) as UIActivityIndicatorView;
        self.progressLoopiIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.progressLoopiIndicator.color = GMColor.colorPrimaryDark()
        self.progressLoopiIndicator.backgroundColor = GMColor.backgroundAppColor().withAlphaComponent(0.5)
        self.progressLoopiIndicator.center = controller.view.center;
        /*
        self.progressLoopiIndicator.layer.cornerRadius = ConstraintsView.borderCornerIndicatorView()
        self.progressLoopiIndicator.layer.borderColor = GMColor.colorPrimaryDark().cgColor
        self.progressLoopiIndicator.layer.borderWidth = ConstraintsView.borderCornerIndicatorView()
        */
        controller.view.addSubview(progressLoopiIndicator);
        
        self.progressLoopiIndicator.startAnimating();
        return self.progressLoopiIndicator;
    }
    
    func stopActivity(controller:UIViewController,indicator:UIActivityIndicatorView)-> Void
    {
        indicator.removeFromSuperview();
    }
    
  
    
}
