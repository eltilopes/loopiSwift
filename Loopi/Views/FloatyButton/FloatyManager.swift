//
//  FloatyManager.swift
//  Loopi
//
//  Created by Loopi on 08/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

open class FloatyManager: NSObject {
    private static var __once: () = {
        StaticInstance.instance = FloatyManager()
    }()
    struct StaticInstance {
        static var dispatchToken: Int = 0
        static var instance: FloatyManager?
    }
    
    class func defaultInstance() -> FloatyManager {
        _ = FloatyManager.__once
        return StaticInstance.instance!
    }
    
    var _floatyWindow: FloatyWindow? = nil
    var floatyWindow: FloatyWindow {
        get {
            if _floatyWindow == nil {
                _floatyWindow = FloatyWindow(frame: UIScreen.main.bounds)
                _floatyWindow?.rootViewController = floatyController
            }
            return _floatyWindow!
        }
    }
    
    var _floatyController: FloatyViewController? = nil
    var floatyController: FloatyViewController {
        get {
            if _floatyController == nil {
                _floatyController = FloatyViewController()
            }
            return _floatyController!
        }
    }
    
    open var button: Floaty {
        get {
            return floatyController.floaty
        }
    }
    
    private var _font = UIFont()
    open var font: UIFont {
        get {
            return _font
        }
        set {
            _font = newValue
        }
    }
    
    private var _rtlMode = false
    open var rtlMode: Bool {
        get {
            return _rtlMode
        }
        set{
            _rtlMode = newValue
        }
    }
    
    open func show(_ animated: Bool = true) {
        if animated == true {
            floatyWindow.isHidden = false
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.floatyWindow.alpha = 1
            })
        } else {
            floatyWindow.isHidden = false
        }
    }
    
    open func hide(_ animated: Bool = true) {
        if animated == true {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.floatyWindow.alpha = 0
            }, completion: { finished in
                self.floatyWindow.isHidden = true
            })
        } else {
            floatyWindow.isHidden = true
        }
    }
    
    open func toggle(_ animated: Bool = true) {
        if floatyWindow.isHidden == false {
            self.hide(animated)
        } else {
            self.show(animated)
        }
    }
    
    open var hidden: Bool {
        get {
            return floatyWindow.isHidden
        }
    }
}


