//
//  CardViewController.swift
//  Loopi
//
//  Created by Loopi on 23/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class CardViewController: BaseViewController {
    
    @IBOutlet weak var cardNomeProfissional: UILabel?
    @IBOutlet weak var cardImageView: UIImageView?
    @IBOutlet weak var cardCategoria: UILabel?
    @IBOutlet weak var cardSubCategoria: UILabel?
    @IBOutlet weak var cardEspecialidade: UILabel?
    @IBOutlet weak var cardTempo: UILabel?
    @IBOutlet weak var cardDistancia: UILabel?
    
    // This variable will hold the data being passed from the First View Controller
    var servicoCard = ServicoCard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFooterLocation()
        showFooterLocation()
        cardNomeProfissional?.text = servicoCard.profissional.usuario.nome
        cardCategoria?.text = servicoCard.categoria.descricao
        cardSubCategoria?.text = servicoCard.subCategoria.descricao
        cardEspecialidade?.text = servicoCard.especialidade.descricao
        cardTempo?.text = servicoCard.duracao
        cardDistancia?.text = servicoCard.latitude
        
        let imageURL = URL(string: servicoCard.thumbnail!)
        var image: UIImage?
        if let url = imageURL {
            //All network operations has to run on different thread(not on main thread).
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                //All UI operations has to run on main thread.
                DispatchQueue.main.async {
                    if imageData != nil {
                        image = UIImage(data: imageData! as Data)
                        self.cardImageView?.image = image
                        self.cardImageView?.contentMode = .center;
                        
                    } else {
                        image = nil
                    }
                }
            }
        }
    }
    
}


