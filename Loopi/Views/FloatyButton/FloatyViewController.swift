//
//  FloatyViewController.swift
//  Loopi
//
//  Created by Loopi on 08/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

/**
 KCFloatingActionButton dependent on UIWindow.
 */
open class FloatyViewController: UIViewController {
    open let floaty = Floaty()
    var statusBarStyle: UIStatusBarStyle = .default
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(floaty)
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return statusBarStyle
        }
    }
}


