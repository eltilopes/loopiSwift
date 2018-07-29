//
//  ImagemAlertController.swift
//  Loopi
//
//  Created by Loopi on 11/07/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit

class ImagemAlertController: UIView, Modal{
    var backgroundView = UIView()
    var dialogView = UIStackView()
    
    let sizeImage = 20
    let sizeUIImage = 100
    let marginTitle = CGFloat(55)
    var dialogViewHeight = CGFloat(0)
    var dialogViewWidth = CGFloat(0)
    
    var imagem = UIImage(named: "ic_file")
    convenience init(imagem: UIImage ) {
        self.init(frame: UIScreen.main.bounds)
        initialize(imagem: imagem )
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize(imagem: UIImage ){
        self.imagem = imagem
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
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getImageView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        //dialogView.addArrangedSubview(getControllerButtonsView())
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        dialogView.layer.masksToBounds = true
        
        
        let x = frame.width/2 - dialogViewWidth/2 - CGFloat(sizeImage )
        let y = frame.height/2 - dialogViewHeight/2
        let width = dialogViewWidth + CGFloat(sizeImage * 2)
        let height = dialogViewHeight
        
        let viewBorder = UIView(frame: CGRect(x: x, y: y, width: width , height: height))
        viewBorder.backgroundColor = GMColor.whiteColor()
        viewBorder.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        viewBorder.layer.masksToBounds = true
        //addSubview(viewBorder)
        addSubview(dialogView)
        dialogView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dialogView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
  
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
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
    
    
    func getImageView() -> UIStackView {
        
        dialogViewHeight = dialogViewHeight +  CGFloat(sizeUIImage)
        
        let imagemSelecionadaView = UIStackView()
        imagemSelecionadaView.clipsToBounds = true
        imagemSelecionadaView.axis  = UILayoutConstraintAxis.vertical
        imagemSelecionadaView.distribution  = UIStackViewDistribution.equalSpacing
        imagemSelecionadaView.alignment = UIStackViewAlignment.center
        
        let imagemSelecionada = UIImageView()
        imagemSelecionada.image = self.imagem
        imagemSelecionada.contentMode = .scaleAspectFit
        //imagemSelecionada.frame = CGRect(x: 10, y: 10, width: CGFloat(sizeUIImage)  , height: CGFloat(sizeUIImage))
        imagemSelecionada.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth*2/3)).isActive = true
        imagemSelecionada.heightAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth*2/3)).isActive = true
        imagemSelecionada.layer.masksToBounds = true
        imagemSelecionadaView.addArrangedSubview(imagemSelecionada)
        
        imagemSelecionadaView.translatesAutoresizingMaskIntoConstraints = false
        imagemSelecionadaView.backgroundColor = UIColor.white
        imagemSelecionadaView.layer.cornerRadius = 6
        
        
        return imagemSelecionadaView
    }
    func getControllerButtonsView() -> UIStackView {
        dialogViewHeight = dialogViewHeight + CGFloat(ConstraintsView.heightHeaderTitleLabel() )
        let controllerButtonsView = UIStackView()
        controllerButtonsView.clipsToBounds = true
        controllerButtonsView.axis  = UILayoutConstraintAxis.horizontal
        controllerButtonsView.distribution  = UIStackViewDistribution.equalSpacing
        controllerButtonsView.alignment = UIStackViewAlignment.center
        
        let viewPadding = UIView()
        viewPadding.backgroundColor = GMColor.whiteColor()
        viewPadding.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth/2)).isActive = true
        viewPadding.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        viewPadding.layer.masksToBounds = true
        controllerButtonsView.addArrangedSubview(viewPadding)
        
        let completeView = UIView()
        completeView.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth/2)).isActive = true
        completeView.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        completeView.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        completeView.layer.masksToBounds = true
        completeView.backgroundColor = GMColor.whiteColor()
        controllerButtonsView.addArrangedSubview(completeView)
        
        let buttonOK = UIButton()
        buttonOK.backgroundColor = GMColor.colorPrimary()
        //buttonOK.addTarget(self, action: #selector(didTappedOnBackgroundView), for: .touchUpInside)
        buttonOK.setTitle("OK", for: UIControlState.normal)
        buttonOK.setTitle("OK", for: UIControlState.selected)
        buttonOK.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonOK.setTitleColor(GMColor.whiteColor(), for: .selected)
        buttonOK.titleLabel?.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        buttonOK.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth/2)).isActive = true
        buttonOK.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        buttonOK.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonOK.layer.masksToBounds = true
        controllerButtonsView.addArrangedSubview(buttonOK)
        
        
        
        controllerButtonsView.translatesAutoresizingMaskIntoConstraints = false
        controllerButtonsView.backgroundColor = UIColor.white
        controllerButtonsView.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        return controllerButtonsView
    }
  
}

