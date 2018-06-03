//
//  PickerButton.swift
//  Loopi
//
//  Created by Loopi on 19/04/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class PickerButton: UIButton {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.layer.borderColor = GMColor.whiteColor().cgColor
        self.layer.borderWidth = CGFloat(ConstraintsView.widthBorderLoopiTextField())
        self.backgroundColor = GMColor.backgroundAppColor()
        self.tintColor = GMColor.textColorPrimary()
        let image = UIImage(named: "ic_arrow_drop_down")
        self.setImage(image, for: .normal)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        view.addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: 1
            )
        )
        
        addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .left,
            relatedBy: .equal,
            toItem: self,
            attribute: .left,
            multiplier: 1,
            constant: 0
            )
        )
        
        addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .right,
            relatedBy: .equal,
            toItem: self,
            attribute: .right,
            multiplier: 1,
            constant: 0
            )
        )
        
        addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
            )
        )
    }
    
}

