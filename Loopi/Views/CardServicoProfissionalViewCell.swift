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
    var widthLabel = CGFloat(0)
    var widthImage = CGFloat(0)
    var heightImage = CGFloat(0)
    
    lazy var cardSelecionadoLabel: UILabel = {
        let label = UILabel()
        label.textColor = GMColor.textColorPrimary()
        label.font =  UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        label.textAlignment = .left
        label.widthAnchor.constraint(equalToConstant: widthLabel ).isActive = true
        label.heightAnchor.constraint(equalToConstant: ConstraintsView.heightTitleLabel()).isActive = true
        label.clipsToBounds = true
        return label
    }()
    
    lazy var cardSelecionadoImageView: UIImageView = {
        let image = UIImage(named: "perfil")
        let imageView = UIImageView(image: image)
        imageView.widthAnchor.constraint(equalToConstant: widthImage ).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: heightImage).isActive = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    lazy var cardSelecionadoCategoria: UILabel = {
        let label = UILabel()
        label.textColor = GMColor.colorPrimary()
        label.font =  UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        label.textAlignment = .left
        label.widthAnchor.constraint(equalToConstant: widthLabel ).isActive = true
        label.heightAnchor.constraint(equalToConstant: ConstraintsView.heightTitleLabel()).isActive = true
        label.clipsToBounds = true
        return label
    }()
    
    
    lazy var cardSelecionadoEspecialidade: UILabel = {
        let label = UILabel()
        label.textColor = GMColor.textColorPrimary()
        label.font =  UIFont.systemFont(ofSize: ConstraintsView.fontMedium())
        label.textAlignment = .left
        label.widthAnchor.constraint(equalToConstant: widthLabel ).isActive = true
        label.heightAnchor.constraint(equalToConstant: ConstraintsView.heightTitleLabel()).isActive = true
        label.clipsToBounds = true
        return label
    }()
    
    lazy var cardView: UIStackView = {
        let cardView = UIStackView()
        cardView.clipsToBounds = true
        cardView.axis  = UILayoutConstraintAxis.horizontal
        cardView.distribution  = UIStackViewDistribution.equalSpacing
        cardView.alignment = UIStackViewAlignment.center
        cardView.addArrangedSubview(cardImageView)
        cardView.addArrangedSubview(cardTextView)
        //cardView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = UIColor.white
        cardView.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        cardView.layer.masksToBounds = true
        
        return cardView
    }()
    
    lazy var cardImageView: UIStackView = {
        let cardImageView = UIStackView()
        cardImageView.clipsToBounds = true
        cardImageView.axis  = UILayoutConstraintAxis.vertical
        cardImageView.distribution  = UIStackViewDistribution.equalSpacing
        cardImageView.alignment = UIStackViewAlignment.center
        cardImageView.addArrangedSubview(cardSelecionadoImageView)
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.backgroundColor = UIColor.white
        cardImageView.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        cardImageView.layer.masksToBounds = true
        
        return cardImageView
    }()
    
    lazy var cardTextView: UIStackView = {
        let cardTextView = UIStackView()
        cardTextView.clipsToBounds = true
        cardTextView.axis  = UILayoutConstraintAxis.vertical
        cardTextView.distribution  = UIStackViewDistribution.equalSpacing
        cardTextView.alignment = UIStackViewAlignment.center
        cardTextView.addArrangedSubview(cardSelecionadoLabel)
        cardTextView.addArrangedSubview(cardSelecionadoCategoria)
        cardTextView.addArrangedSubview(cardSelecionadoEspecialidade)
        //cardTextView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        cardTextView.translatesAutoresizingMaskIntoConstraints = false
        cardTextView.backgroundColor = UIColor.white
        cardTextView.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        cardTextView.layer.masksToBounds = true
        
        return cardTextView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewCard()
        
    }
    
    func loadViewCard() {
        
        widthImage = frame.width * 2 / 5
        widthLabel = frame.width * 3 / 5
        heightImage = frame.height 
        addSubview(cardView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

