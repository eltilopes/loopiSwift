//
//  SubCategoriaViewCell.swift
//  Loopi
//
//  Created by Loopi on 05/02/19.
//  Copyright © 2019 Loopi. All rights reserved.
//


import UIKit

class SubCategoriaViewCell: UICollectionViewCell{

    var descricao: UILabel!

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
