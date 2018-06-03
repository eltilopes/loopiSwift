//
//  LocationViewCell.swift
//  Loopi
//
//  Created by Loopi on 06/04/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit

class LocationViewCell: UICollectionViewCell{
    
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var descricao: UITextView!
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var imageViewAction: UIImageView!
    
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


