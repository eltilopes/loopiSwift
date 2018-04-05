//
//  CategoriaViewCell.swift
//  Loopi
//
//  Created by Loopi on 05/04/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit

class CategoriaViewCell: UICollectionViewCell{
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
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

