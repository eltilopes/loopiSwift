//
//  ProfissionalCardViewCell.swift
//  Loopi
//
//  Created by Loopi on 19/07/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class ProfissionalCardViewCell: UICollectionViewCell{

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cardCategoria: UILabel!
    @IBOutlet weak var cardEspecialidade: UILabel!
    
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
