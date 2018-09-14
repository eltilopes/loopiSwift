//
//  ItemServicoViewCell.swift
//  Loopi
//
//  Created by Loopi on 16/08/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class ItemServicoViewCell: UICollectionViewCell{
    
    @IBOutlet weak var itemValor: UILabel!
    @IBOutlet weak var itemNome: UILabel!
    @IBOutlet weak var itemDescricao: UILabel!
    
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
