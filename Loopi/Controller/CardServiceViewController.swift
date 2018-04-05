//
//  CardServiceViewController.swift
//  Loopi
//
//  Created by Loopi on 22/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit

class CardServiceViewController: UIViewController {
    
    @IBOutlet weak var cardNomeProfissional: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardCategoria: UILabel!
    @IBOutlet weak var cardSubCategoria: UILabel!
    @IBOutlet weak var cardEspecialidade: UILabel!
    @IBOutlet weak var cardTempo: UILabel!
    @IBOutlet weak var cardDistancia: UILabel!
    
    // This variable will hold the data being passed from the First View Controller
    var cardServico = CardServico(idServico : 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardNomeProfissional.text = cardServico.myLabel
        cardCategoria.text = cardServico.cardCategoria
        cardSubCategoria.text = cardServico.cardSubCategoria
        cardEspecialidade.text = cardServico.cardEspecialidade
        cardTempo.text = cardServico.cardTempo
        cardDistancia.text = cardServico.cardDistancia
        
        let imageURL = URL(string: cardServico.imageViewPath)
        var image: UIImage?
        if let url = imageURL {
            //All network operations has to run on different thread(not on main thread).
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                //All UI operations has to run on main thread.
                DispatchQueue.main.async {
                    if imageData != nil {
                        image = UIImage(data: imageData! as Data)
                        self.cardImageView.image = image
                        self.cardImageView.contentMode = .center;
                        if (self.cardImageView.bounds.size.width > (image?.size.width)! && self.cardImageView.bounds.size.height > (image?.size.height)!) {
                            self.cardImageView.contentMode = .scaleAspectFill;
                            print(self.cardServico.myLabel)
                        }
                    } else {
                        image = nil
                    }
                }
            }
        }
    }
    
}

