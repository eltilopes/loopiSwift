//
//  ActivityIndicator.swift
//  Loopi
//
//  Created by Loopi on 23/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class ActivityProgressLoopi: NSObject {
    
    var myActivityIndicator:UIActivityIndicatorView!
    
    func StartActivityIndicator(obj:UIViewController) -> UIActivityIndicatorView
    {
        
        self.myActivityIndicator = UIActivityIndicatorView(frame:CGRect(x:100,y:100, width:100, height:100)) as UIActivityIndicatorView;
        
        self.myActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.myActivityIndicator.center = obj.view.center;
        
        obj.view.addSubview(myActivityIndicator);
        
        self.myActivityIndicator.startAnimating();
        return self.myActivityIndicator;
    }
    
    func StopActivityIndicator(obj:UIViewController,indicator:UIActivityIndicatorView)-> Void
    {
        indicator.removeFromSuperview();
    }
    
    
}
