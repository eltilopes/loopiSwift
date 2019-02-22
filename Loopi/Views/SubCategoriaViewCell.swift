//
//  SubCategoriaViewCell.swift
//  Loopi
//
//  Created by Loopi on 05/02/19.
//  Copyright © 2019 Loopi. All rights reserved.
//


import UIKit

class SubCategoriaViewCell: UICollectionViewCell{

    let descricao: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        label.textColor = GMColor.textColorPrimaryDark()
        label.tintColor = GMColor.textColorPrimaryDark()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let urlImagemImageView: UIImageView = {
        let image = UIImage(named: "logo_loopi")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    func addViews(){
        backgroundColor = GMColor.backgroundColorLoopiTextField()
        let width = frame.width - 20
        addSubview(descricao)
        addSubview(urlImagemImageView)
        _ = urlImagemImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width , heightConstant: frame.height)
        //urlImagemImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //urlImagemImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        _ = descricao.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 20, rightConstant: 10, widthConstant: width , heightConstant: 30)
        descricao.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descricao.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
