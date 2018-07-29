//
//  DocumentosViewCell.swift
//  Loopi
//
//  Created by Loopi on 11/07/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit

class DocumentosViewCell: UITableViewCell {
    
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var fileImage: UIImageView!
    @IBOutlet weak var photoImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
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



