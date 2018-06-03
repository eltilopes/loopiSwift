//
//  ServicoViewCell.swift
//  Loopi
//
//  Created by Loopi on 03/05/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit

class ServicoViewCell: UICollectionViewCell{
    
    @IBOutlet weak var checkButton: UIImageView!
    @IBOutlet weak var servicoNome: UILabel!
    @IBOutlet weak var servicoDescricao: UILabel!
    @IBOutlet weak var servicoValor: UILabel!
    
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
    
    override func draw(_ rect: CGRect) {
        super.draw(CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height))
        servicoNome.font = UIFont.boldSystemFont(ofSize:  ConstraintsView.fontMedium())
        servicoDescricao.font = UIFont.systemFont(ofSize: ConstraintsView.fontSmall())
        servicoValor.font = UIFont.systemFont(ofSize:  ConstraintsView.fontMedium())
    }
}

