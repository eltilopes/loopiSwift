//
//  CardServicoAnuncioViewCell.swift
//  Loopi
//
//  Created by Loopi on 13/06/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit

class CardServicoAnuncioViewCell: UICollectionViewCell{
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cardCategoria: UILabel!
    @IBOutlet weak var cardEspecialidade: UILabel!
    @IBOutlet weak var cardTempo: UILabel!
    @IBOutlet weak var cardDistancia: UILabel!
    @IBOutlet weak var cardLikeQuantidade: UILabel!
    @IBOutlet weak var cardLike: UIImageView!
    @IBOutlet weak var cardStar1: UIImageView!
    @IBOutlet weak var cardStar2: UIImageView!
    @IBOutlet weak var cardStar3: UIImageView!
    @IBOutlet weak var cardStar4: UIImageView!
    @IBOutlet weak var cardStar5: UIImageView!
    
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

