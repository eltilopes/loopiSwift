//
//  HeaderCollectionViewServicos.swift
//  Loopi
//
//  Created by Loopi on 07/05/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class HeaderCollectionViewServicos: UICollectionReusableView {
    
    @IBOutlet weak var title: UILabel!
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let hitView = super.hitTest(point, with: event) {
            if hitView is UICollectionViewCell {
                return nil
            } else {
                return hitView
            }
        } else {
            return nil
        }
    }
    
}



