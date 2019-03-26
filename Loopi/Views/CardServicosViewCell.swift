//
//  CardServicosViewCell.swift
//  Loopi
//
//  Created by Loopi on 15/03/19.
//  Copyright © 2019 Loopi. All rights reserved.
//



import UIKit

class CardServicosViewCell: UICollectionViewCell {
    
    var servicoCard = ServicoProfissional()
    
    var dialogViewWidth = CGFloat(0)
    var dialogViewHeight = CGFloat(0)
    
    lazy var nomeServicoLabel: UILabel = {
        let label = UILabel()
        label.textColor = GMColor.textColorPrimary()
        label.font =  UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        label.textAlignment = .left
        label.widthAnchor.constraint(equalToConstant: dialogViewWidth ).isActive = true
        label.heightAnchor.constraint(equalToConstant: dialogViewHeight).isActive = true
        label.clipsToBounds = true
        label.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 20)
        return label
    }()
    
    lazy var descricaoServicoLabel: UILabel = {
        let label = UILabel()
        label.textColor = GMColor.colorPrimary()
        label.font =  UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        label.textAlignment = .left
        label.widthAnchor.constraint(equalToConstant: dialogViewWidth ).isActive = true
        label.heightAnchor.constraint(equalToConstant: dialogViewHeight).isActive = true
        label.clipsToBounds = true
        label.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 20)
        return label
    }()
    
    
    lazy var valorServicoLabel: UILabel = {
        let label = UILabel()
        label.textColor = GMColor.textColorPrimary()
        label.font =  UIFont.systemFont(ofSize: ConstraintsView.fontMedium())
        label.textAlignment = .left
        label.widthAnchor.constraint(equalToConstant: dialogViewWidth ).isActive = true
        label.heightAnchor.constraint(equalToConstant: dialogViewHeight).isActive = true
        //label.clipsToBounds = true
        //label.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 20)
        return label
    }()
    
 
    lazy var dialogView: UIStackView = {
        let dialogView = UIStackView()
        dialogView.clipsToBounds = true
        dialogView.axis  = UILayoutConstraintAxis.vertical
        dialogView.distribution  = UIStackViewDistribution.equalSpacing
        dialogView.alignment = UIStackViewAlignment.center
        dialogView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        dialogView.addArrangedSubview(nomeServicoLabel)
        dialogView.addArrangedSubview(descricaoServicoLabel)
        dialogView.addArrangedSubview(valorServicoLabel)
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        dialogView.layer.masksToBounds = true
        
        //dialogView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //dialogView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        return dialogView
    }()
    
    
    func loadViewCardServicos() {
        dialogViewWidth = frame.width*2/3
        dialogViewHeight = CGFloat(ConstraintsView.heightHeaderTitleLabel())
        addSubview(dialogView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewCardServicos()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

