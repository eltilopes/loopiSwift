//
//  SolicitacaoTableViewCell.swift
//  Loopi
//
//  Created by Loopi on 12/06/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class SolicitacaoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numero: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var cliente: UILabel!
    @IBOutlet weak var status: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


