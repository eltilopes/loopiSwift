//
//  CheckBox.swift
//  Loopi
//
//  Created by Loopi on 02/11/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "ic_check_box")! as UIImage
    let uncheckedImage = UIImage(named: "ic_check_box_blank")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControlState.normal)
                self.tintColor = GMColor.colorPrimary()
                self.contentMode = .center;
            } else {
                self.setImage(uncheckedImage, for: UIControlState.normal)
                self.tintColor = GMColor.colorPrimary()
                self.contentMode = .center;
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
