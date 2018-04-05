//
//  ExtratoTableViewCell.swift
//  Loopi
//
//  Created by Loopi on 16/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class ExtratoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var historico: UILabel!
    @IBOutlet weak var valor: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

