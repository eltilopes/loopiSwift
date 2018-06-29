//
//  CardServicoSelecionadoViewCell.swift
//  Loopi
//
//  Created by Loopi on 02/06/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class CardServicoSelecionadoViewCell: UICollectionViewCell{
    
    @IBOutlet weak var cardSelecionadoLabel: UILabel!
    @IBOutlet weak var cardSelecionadoImageView: UIImageView!
    @IBOutlet weak var cardSelecionadoCategoria: UILabel!
    @IBOutlet weak var cardSelecionadoEspecialidade: UILabel!
    @IBOutlet weak var cardSelecionadoTempo: UILabel!
    @IBOutlet weak var cardSelecionadoDistancia: UILabel!
    @IBOutlet weak var cardSelecionadoLikeQuantidade: UILabel!
    @IBOutlet weak var cardSelecionadoLike: UIImageView!
    @IBOutlet weak var cardSelecionadoStar1: UIImageView!
    @IBOutlet weak var cardSelecionadoStar2: UIImageView!
    @IBOutlet weak var cardSelecionadoStar3: UIImageView!
    @IBOutlet weak var cardSelecionadoStar4: UIImageView!
    @IBOutlet weak var cardSelecionadoStar5: UIImageView!
    
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

