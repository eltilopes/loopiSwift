//
//  TermosViewController.swift
//  Loopi
//
//  Created by Loopi on 28/06/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class TermosViewController: UIViewController{
    
    @IBOutlet weak var labelTermos : UILabel!
    @IBOutlet weak var labelInfoTermos : UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        self.view.backgroundColor = GMColor.backgroundAppColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
  
    func setupLabels() {
        
        self.labelTermos.backgroundColor = GMColor.backgroundAppColor()
        self.labelTermos.textColor = GMColor.textColorPrimary()
        self.labelTermos.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        
        self.labelInfoTermos.backgroundColor = GMColor.backgroundAppColor()
        self.labelInfoTermos.textColor = GMColor.textColorPrimary()
        self.labelInfoTermos.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        let stringTermos = "<h4>Taxas de Anúncio conforme tipo de pagamento recebido</h4><small> - Cartão de crédito/débito   15%</small><br><small> - Cashback   15%</small><br><h4>Para pagamentos realizados via:</h4><strong><small>Cartão de crédito/débito</small></strong><br><small> * Depósito será realizado na sua conta bancária após 30 dias.</small><br><br><strong><small>Cashback</small></strong><br><small> ** Depósito será realizado no seu saldo cashback imediatamente.</small><br><br> "
        self.labelInfoTermos.attributedText = stringTermos.htmlAttributedString()
    }
    
    
}
extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
}


