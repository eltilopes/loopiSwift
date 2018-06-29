//
//  HorizontalLayout.swift
//  Loopi
//
//  Created by Loopi on 19/06/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import Foundation
import UIKit

class HorizontalLayout: UIView {
    
    var xOffsets: [CGFloat] = []
    
    init(height: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: height) )
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        var width: CGFloat = 0
        
        for i in 0..<subviews.count {
            let view = subviews[i] as UIView
            view.layoutSubviews()
            width += xOffsets[i]
            view.frame.origin.x = width
            width += view.frame.width
        }
        
        self.frame.size.width = width
        
    }
    
    override func addSubview(_ view: UIView) {
        
        xOffsets.append(view.frame.origin.x)
        super.addSubview(view)
        
    }
    
    func removeAll() {
        
        for view in subviews {
            view.removeFromSuperview()
        }
        xOffsets.removeAll(keepingCapacity: false)
        
    }
    
}
