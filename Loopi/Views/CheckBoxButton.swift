//
//  CheckBoxButton.swift
//  Loopi
//
//  Created by Loopi on 22/10/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
class CheckBoxButton: UIButton {
    
    @IBInspectable var title: String = ""
    @IBInspectable var sizeImage: Int = 20
    @IBInspectable var sizeUIImage: Int = 30
    @IBInspectable var full: Bool = false
    
    
    // MARK: Initialization
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        customInitialization()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customInitialization()
    }
    
    convenience init(frame: CGRect, full: Bool, title: String) {
        self.init(frame: frame)
        self.full = full
        self.title = title
    }
    
     func customInitialization() {
        sizeUIImage = Int(frame.width)
        sizeImage = Int(frame.width) - 10
        self.tag = 1
        self.setImage(ImagesUtil.defaultCheckBoxButtonImage(full: false, sizeImage: sizeImage, sizeUIImage: sizeUIImage), for: UIControlState.normal)
        self.setImage(ImagesUtil.defaultCheckBoxButtonImage(full: true, sizeImage: sizeImage, sizeUIImage: sizeUIImage), for: UIControlState.selected)
        self.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        self.setTitle(title, for: UIControlState.normal)
        self.setTitle(title, for: UIControlState.selected)
        self.semanticContentAttribute = .forceRightToLeft
        self.contentHorizontalAlignment = .right
        
    }
    
    
   
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(ImagesUtil.defaultCheckBoxButtonImage(full: true, sizeImage: sizeImage, sizeUIImage: sizeUIImage), for: .selected)
            } else {
                self.setImage(ImagesUtil.defaultCheckBoxButtonImage(full: false, sizeImage: sizeImage, sizeUIImage: sizeUIImage), for: .normal)
            }
        }
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if (sender == self) {
            if self.isChecked == true
            {
                self.isChecked = false
            }
            else
            {
                self.isChecked = true
            }
        }
    }
    
}
