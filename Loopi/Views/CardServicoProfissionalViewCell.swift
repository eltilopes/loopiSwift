//
//  CardServicoProfissionalViewCell.swift
//  Loopi
//
//  Created by Loopi on 26/02/19.
//  Copyright © 2019 Loopi. All rights reserved.
//


import UIKit

class CardServicoProfissionalViewCell: UICollectionViewCell {
    
    var servicoCard = ServicoCard()
    
    lazy var cardSelecionadoLabel: UILabel = {
        let label = UILabel()
        label.textColor = GMColor.textColorPrimary()
        label.font =  UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        return label
    }()
    
    lazy var cardSelecionadoImageView: UIImageView = {
        let image = UIImage(named: "perfil")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    
    lazy var cardSelecionadoCategoria: UILabel = {
        let label = UILabel()
        label.textColor = GMColor.colorPrimary()
        label.font =  UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        return label
    }()
    
    
    lazy var cardSelecionadoEspecialidade: UILabel = {
        let label = UILabel()
        label.textColor = GMColor.textColorPrimary()
        label.font =  UIFont.systemFont(ofSize: ConstraintsView.fontMedium())
        return label
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let width = frame.width - 20
        let widthImage = width * 2 / 5
        let widthLabel = width * 3 / 5
        let height = frame.height - 20
        let heightImage = height / 4
        addSubview(cardSelecionadoImageView)
        addSubview(cardSelecionadoLabel)
        addSubview(cardSelecionadoCategoria)
        addSubview(cardSelecionadoEspecialidade)
        _ = cardSelecionadoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: widthImage , heightConstant: heightImage )
        _ = cardSelecionadoLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: widthLabel , heightConstant: heightImage / 5)
        _ = cardSelecionadoCategoria.anchor(top: cardSelecionadoLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: widthLabel , heightConstant: heightImage / 5)
        _ = cardSelecionadoEspecialidade.anchor(top: cardSelecionadoCategoria.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: widthLabel , heightConstant: heightImage / 5)
        //cardSelecionadoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
}

