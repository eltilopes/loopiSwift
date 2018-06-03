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
    
    func startActivity(obj:UIViewController) -> UIActivityIndicatorView
    {
        
        self.progressLoopiIndicator = UIActivityIndicatorView(frame:CGRect(x:100,y:100, width:100, height:100)) as UIActivityIndicatorView;
        
        //self.progressLoopiIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.progressLoopiIndicator.color = GMColor.colorPrimaryDark()
        self.progressLoopiIndicator.center = obj.view.center;
        
        obj.view.addSubview(progressLoopiIndicator);
        
        self.progressLoopiIndicator.startAnimating();
        return self.progressLoopiIndicator;
    }
    
    func stopActivity(obj:UIViewController,indicator:UIActivityIndicatorView)-> Void
    {
        indicator.removeFromSuperview();
    }
    
    
}
