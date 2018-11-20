//
//  FavoritoAlertController.swift
//  Loopi
//
//  Created by Loopi on 12/11/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit

class FavoritoAlertController: UIView, Modal{
    var backgroundView = UIView()
    var dialogView = UIStackView()
    let marginTitle = CGFloat(30)
    var dialogViewHeight = CGFloat(0)
    var dialogViewWidth = CGFloat(0)
    var favoritos: [FavoritoProfissionalUsuario] = []
    
    convenience init(favoritos: [FavoritoProfissionalUsuario] ) {
        self.init(frame: UIScreen.main.bounds)
        initialize(favoritos: favoritos )
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize(favoritos: [FavoritoProfissionalUsuario] ){
        self.favoritos = favoritos
        dialogView.clipsToBounds = true
        dialogView.axis  = UILayoutConstraintAxis.vertical
        dialogView.distribution  = UIStackViewDistribution.equalSpacing
        dialogView.alignment = UIStackViewAlignment.center
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        //dialogViewWidth = frame.width-64
        dialogViewWidth = frame.width*2/3
        dialogView.addArrangedSubview(getTitleLabel(title: "FAVORITOS"))
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        for f in favoritos{
            dialogView.addArrangedSubview(getInfoLabel(title: f.usuario.nome!))
        }
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        dialogView.layer.masksToBounds = true
        
        
        let x = frame.width/2 - dialogViewWidth/2
        let y = frame.height/2 - dialogViewHeight/2
        let width = dialogViewWidth
        let height = dialogViewHeight
        
        /*
         let border = ConstraintsView.heightSeparatorLineView() * 2
         let x = frame.width/2 - dialogViewWidth/2 - CGFloat(border )
         let y = frame.height/2 - dialogViewHeight/2
         let width = dialogViewWidth + CGFloat(border * 2)
         let height = dialogViewHeight
        */
        
        let viewBorder = UIView(frame: CGRect(x: x, y: y, width: width , height: height))
        viewBorder.backgroundColor = GMColor.whiteColor()
        viewBorder.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        viewBorder.layer.masksToBounds = true
        addSubview(viewBorder)
        addSubview(dialogView)
        dialogView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dialogView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
   
   
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
    func getTitleLabel(title: String) -> UILabel {
        dialogViewHeight = dialogViewHeight + CGFloat(ConstraintsView.heightHeaderTitleLabel())
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        titleLabel.tintColor = GMColor.whiteColor()
        titleLabel.backgroundColor = GMColor.cyan300Color()
        titleLabel.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        titleLabel.textAlignment = .center
        return titleLabel
    }
    
    func getInfoLabel(title: String) -> UILabel {
        dialogViewHeight = dialogViewHeight + CGFloat(ConstraintsView.heightHeaderTitleLabel())
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: ConstraintsView.fontSmall())
        titleLabel.tintColor = GMColor.textColorPrimary()
        titleLabel.backgroundColor = GMColor.whiteColor()
        titleLabel.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth ) - marginTitle).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        titleLabel.layoutMargins = UIEdgeInsets(top: 0, left: marginTitle,bottom: 0, right: marginTitle)
        titleLabel.textAlignment = .left
        return titleLabel
    }
    
    func getSeparatorLineView() -> UIView {
        let heightSeparatorLineView  = CGFloat(ConstraintsView.heightSeparatorLineView() )
        dialogViewHeight = dialogViewHeight + heightSeparatorLineView
        let separatorLineView = UIView()
        separatorLineView.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: heightSeparatorLineView).isActive = true
        separatorLineView.backgroundColor = GMColor.whiteColor()
        return separatorLineView
    }
    
  
    
}
