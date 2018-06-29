//
//  FiltroAlertController.swift
//  Loopi
//
//  Created by Loopi on 06/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit

class FiltroAlertController: UIView, Modal{
    var backgroundView = UIView()
    var dialogView = UIStackView()
    var buttonnOrdemAlfabeticaAZ = UIButton()
    var buttonnOrdemAlfabeticaZA = UIButton()
    var buttonnValorMenor = UIButton()
    var buttonnValorMaior = UIButton()
    
    var ordemAlfabeticaAZ = Bool()
    var ordemAlfabeticaZA = Bool()
    var valorMenor = Bool()
    var valorMaior = Bool()
    
    let sizeImage = 20
    let sizeUIImage = 30
    let marginTitle = CGFloat(55)
    var dialogViewHeight = CGFloat(0)
    var dialogViewWidth = CGFloat(0)
    
    var filtro : Filtro = Filtro()
    convenience init(filtro: Filtro ) {
        self.init(frame: UIScreen.main.bounds)
        initialize(filtro: filtro )
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize(filtro: Filtro ){
        filtro.distanciaMenor = true
        self.filtro = filtro
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
        //dialogView.addArrangedSubview(getTitleLabel(title: "Filtro", dialogViewWidth: Int(dialogViewWidth)))
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getOrdemAlfabeticaView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getDistanciaCheckBoxView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getValorView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getControllerButtonsView())
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
        addSubview(viewBorder)
        addSubview(dialogView)
        dialogView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dialogView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }
    
    @objc func buttonAction(sender: UIButton!) {
        switch sender.tag {
        case 1:
            if buttonnOrdemAlfabeticaAZ.isSelected == true{
                buttonnOrdemAlfabeticaAZ.isSelected = false
                ordemAlfabeticaAZ = false
                ordemAlfabeticaZA = false
            }
            else{
                buttonnOrdemAlfabeticaAZ.isSelected = true
                buttonnOrdemAlfabeticaZA.isSelected = false
                ordemAlfabeticaAZ = true
                ordemAlfabeticaZA = false
            }
            break
        case 2:
            if buttonnOrdemAlfabeticaZA.isSelected == true{
                buttonnOrdemAlfabeticaZA.isSelected = false
                ordemAlfabeticaAZ = false
                ordemAlfabeticaZA = false
            }
            else{
                buttonnOrdemAlfabeticaZA.isSelected = true
                buttonnOrdemAlfabeticaAZ.isSelected = false
                ordemAlfabeticaAZ = false
                ordemAlfabeticaZA = true
            }
            break
        default:
            break
        }
    }
    
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
    func defaultRadioButtonImage(full: Bool ) -> UIImage {
        
        var defaultRadioButtonEmptyImage = UIImage()
        UIGraphicsBeginImageContextWithOptions(CGSize(width: sizeUIImage, height: sizeUIImage), false, 0.0)
        GMColor.colorRadioAndCheckButtonFill().setFill()
        let ovalInRect = CGRect(x: 5, y: 5, width: sizeImage, height: sizeImage)
        GMColor.colorRadioAndCheckButtonFill().setFill()
        UIBezierPath(ovalIn: ovalInRect).fill()
        if full {
            GMColor.whiteColor().setFill()
            UIBezierPath(ovalIn: CGRect(x: 10, y: 10, width: 10, height: 10)).fill()
            GMColor.textColorPrimary().setFill()
            UIBezierPath(ovalIn: CGRect(x: 11.5, y: 11.5, width: 7, height: 7)).fill()
        }
        
        defaultRadioButtonEmptyImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return defaultRadioButtonEmptyImage;
    }
    
   
    
    func defaultCheckBoxButtonImage(full: Bool ) -> UIImage {
        var defaultRadioButtonEmptyImage = UIImage()
        UIGraphicsBeginImageContextWithOptions(CGSize(width: sizeUIImage, height: sizeUIImage), false, 0.0)
        GMColor.colorRadioAndCheckButtonFill().setFill()
        UIBezierPath(rect: CGRect(x: 5, y: 5, width: sizeImage, height: sizeImage)).fill()
        if full {
            GMColor.whiteColor().setFill()
            UIBezierPath(rect: CGRect(x: 10, y: 10, width: 10, height: 10)).fill()
            GMColor.textColorPrimary().setFill()
            UIBezierPath(rect: CGRect(x: 11.5, y: 11.5, width: 7, height: 7)).fill()
        }
        
        defaultRadioButtonEmptyImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return defaultRadioButtonEmptyImage;
    }
    
    func getTitleLabel(title: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.tintColor = GMColor.whiteColor()
        titleLabel.backgroundColor = GMColor.cyan300Color()
        titleLabel.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        titleLabel.textAlignment = .center
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
    
    
    func getOrdemAlfabeticaView() -> UIStackView {
        
        dialogViewHeight = dialogViewHeight + CGFloat(ConstraintsView.heightHeaderTitleLabel())
        dialogViewHeight = dialogViewHeight +  CGFloat(sizeUIImage)
        dialogViewHeight = dialogViewHeight +  CGFloat(sizeUIImage)
        
        let ordemAlfabeticaView = UIStackView()
        ordemAlfabeticaView.clipsToBounds = true
        ordemAlfabeticaView.axis  = UILayoutConstraintAxis.vertical
        ordemAlfabeticaView.distribution  = UIStackViewDistribution.equalSpacing
        ordemAlfabeticaView.alignment = UIStackViewAlignment.center
        
        ordemAlfabeticaAZ = false
        ordemAlfabeticaZA = false
        
        let titleOrdemAlfabetica = UILabel()
        titleOrdemAlfabetica.tintColor = GMColor.textColorPrimary()
        titleOrdemAlfabetica.backgroundColor = GMColor.whiteColor()
        titleOrdemAlfabetica.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth - marginTitle)).isActive = true
        titleOrdemAlfabetica.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        titleOrdemAlfabetica.text = "NOME DO PRESTADOR"
        titleOrdemAlfabetica.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        titleOrdemAlfabetica.textAlignment = .left
        ordemAlfabeticaView.addArrangedSubview(titleOrdemAlfabetica)
        
        buttonnOrdemAlfabeticaAZ = UIButton()
        buttonnOrdemAlfabeticaAZ.backgroundColor = GMColor.whiteColor()
        buttonnOrdemAlfabeticaAZ.tag = 1
        buttonnOrdemAlfabeticaAZ.setImage(self.defaultRadioButtonImage(full: false), for: UIControlState.normal)
        buttonnOrdemAlfabeticaAZ.setImage(self.defaultRadioButtonImage(full: true), for: UIControlState.selected)
        buttonnOrdemAlfabeticaAZ.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        buttonnOrdemAlfabeticaAZ.setTitle("A - Z", for: UIControlState.normal)
        buttonnOrdemAlfabeticaAZ.setTitle("A - Z", for: UIControlState.selected)
        buttonnOrdemAlfabeticaAZ.setTitleColor(GMColor.textColorPrimary(), for: .normal)
        buttonnOrdemAlfabeticaAZ.setTitleColor(GMColor.colorPrimary(), for: .selected)
        buttonnOrdemAlfabeticaAZ.isSelected = true
        buttonnOrdemAlfabeticaAZ.semanticContentAttribute = .forceLeftToRight
        buttonnOrdemAlfabeticaAZ.contentHorizontalAlignment = .left
        buttonnOrdemAlfabeticaAZ.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        buttonnOrdemAlfabeticaAZ.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        ordemAlfabeticaView.addArrangedSubview(buttonnOrdemAlfabeticaAZ)
        
        buttonnOrdemAlfabeticaZA = UIButton()
        buttonnOrdemAlfabeticaZA.backgroundColor = GMColor.whiteColor()
        buttonnOrdemAlfabeticaZA.tag = 2
        buttonnOrdemAlfabeticaZA.setImage(self.defaultRadioButtonImage(full: false), for: UIControlState.normal)
        buttonnOrdemAlfabeticaZA.setImage(self.defaultRadioButtonImage(full: true), for: UIControlState.selected)
        buttonnOrdemAlfabeticaZA.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        buttonnOrdemAlfabeticaZA.setTitle("Z - A", for: UIControlState.normal)
        buttonnOrdemAlfabeticaZA.setTitle("Z - A", for: UIControlState.selected)
        buttonnOrdemAlfabeticaZA.setTitleColor(GMColor.textColorPrimary(), for: .normal)
        buttonnOrdemAlfabeticaZA.setTitleColor(GMColor.colorPrimary(), for: .selected)
        buttonnOrdemAlfabeticaZA.semanticContentAttribute = .forceLeftToRight
        buttonnOrdemAlfabeticaZA.contentHorizontalAlignment = .left
        buttonnOrdemAlfabeticaZA.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        buttonnOrdemAlfabeticaZA.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        
        ordemAlfabeticaView.addArrangedSubview(buttonnOrdemAlfabeticaZA)
        ordemAlfabeticaView.translatesAutoresizingMaskIntoConstraints = false
        ordemAlfabeticaView.backgroundColor = UIColor.white
        ordemAlfabeticaView.layer.cornerRadius = 6
        

        return ordemAlfabeticaView
    }
    
    func getValorView() -> UIStackView {
        dialogViewHeight = dialogViewHeight + CGFloat(ConstraintsView.heightHeaderTitleLabel() )
        dialogViewHeight = dialogViewHeight +  CGFloat(sizeUIImage)
        dialogViewHeight = dialogViewHeight +  CGFloat(sizeUIImage)
        let valorView = UIStackView()
        valorView.clipsToBounds = true
        valorView.axis  = UILayoutConstraintAxis.vertical
        valorView.distribution  = UIStackViewDistribution.equalSpacing
        valorView.alignment = UIStackViewAlignment.center
        
        valorMenor = false
        valorMaior = false
        
        let titleValor = UILabel()
        titleValor.tintColor = GMColor.grey500Color()
        titleValor.backgroundColor = GMColor.whiteColor()
        titleValor.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth - marginTitle)).isActive = true
        titleValor.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        titleValor.text = "VALOR"
        titleValor.textAlignment = .left
        titleValor.font = UIFont.boldSystemFont(ofSize: 20.0)
        valorView.addArrangedSubview(titleValor)
        
        buttonnValorMenor = UIButton()
        buttonnValorMenor.backgroundColor = GMColor.whiteColor()
        buttonnValorMenor.tag = 1
        buttonnValorMenor.setImage(self.defaultRadioButtonImage(full: false), for: UIControlState.normal)
        buttonnValorMenor.setImage(self.defaultRadioButtonImage(full: true), for: UIControlState.selected)
        buttonnValorMenor.addTarget(self, action: #selector(buttonActionValor), for: .touchUpInside)
        buttonnValorMenor.setTitle("Menor Valor", for: UIControlState.normal)
        buttonnValorMenor.setTitle("Menor Valor", for: UIControlState.selected)
        buttonnValorMenor.setTitleColor(GMColor.textColorPrimary(), for: .normal)
        buttonnValorMenor.setTitleColor(GMColor.colorPrimary(), for: .selected)
        buttonnValorMenor.isSelected = true
        buttonnValorMenor.semanticContentAttribute = .forceLeftToRight
        buttonnValorMenor.contentHorizontalAlignment = .left
        buttonnValorMenor.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        buttonnValorMenor.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        valorView.addArrangedSubview(buttonnValorMenor)
        
        buttonnValorMaior = UIButton()
        buttonnValorMaior.backgroundColor = GMColor.whiteColor()
        buttonnValorMaior.tag = 2
        buttonnValorMaior.setImage(self.defaultRadioButtonImage(full: false), for: UIControlState.normal)
        buttonnValorMaior.setImage(self.defaultRadioButtonImage(full: true), for: UIControlState.selected)
        buttonnValorMaior.addTarget(self, action: #selector(buttonActionValor), for: .touchUpInside)
        buttonnValorMaior.setTitle("Maior Valor", for: UIControlState.normal)
        buttonnValorMaior.setTitle("Maior Valor", for: UIControlState.selected)
        buttonnValorMaior.setTitleColor(GMColor.textColorPrimary(), for: .normal)
        buttonnValorMaior.setTitleColor(GMColor.colorPrimary(), for: .selected)
        buttonnValorMaior.semanticContentAttribute = .forceLeftToRight
        buttonnValorMaior.contentHorizontalAlignment = .left
        buttonnValorMaior.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        buttonnValorMaior.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        
        valorView.addArrangedSubview(buttonnValorMaior)
        valorView.translatesAutoresizingMaskIntoConstraints = false
        valorView.backgroundColor = UIColor.white
        valorView.layer.cornerRadius = 6
        return valorView
    }
    
    
    func getDistanciaCheckBoxView() -> UIStackView {
        dialogViewHeight = dialogViewHeight + CGFloat(ConstraintsView.heightHeaderTitleLabel() )
        dialogViewHeight = dialogViewHeight +  CGFloat(sizeImage)
        dialogViewHeight = dialogViewHeight +  CGFloat(sizeImage)
        let distanciaCheckBoxView = UIStackView()
        distanciaCheckBoxView.clipsToBounds = true
        distanciaCheckBoxView.axis  = UILayoutConstraintAxis.vertical
        distanciaCheckBoxView.distribution  = UIStackViewDistribution.equalSpacing
        distanciaCheckBoxView.alignment = UIStackViewAlignment.center
        
        let titleDistanciaCheckBoxView = UILabel()
        titleDistanciaCheckBoxView.tintColor = GMColor.grey500Color()
        titleDistanciaCheckBoxView.backgroundColor = GMColor.whiteColor()
        titleDistanciaCheckBoxView.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth - marginTitle)).isActive = true
        titleDistanciaCheckBoxView.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        titleDistanciaCheckBoxView.text = "DISTANCIA"
        titleDistanciaCheckBoxView.textAlignment = .left
        titleDistanciaCheckBoxView.font = UIFont.boldSystemFont(ofSize: 20.0)
        distanciaCheckBoxView.addArrangedSubview(titleDistanciaCheckBoxView)
        
        let buttonnDistanciaCheckBoxView = UIButton()
        buttonnDistanciaCheckBoxView.backgroundColor = GMColor.whiteColor()
        buttonnDistanciaCheckBoxView.tag = 1
        buttonnDistanciaCheckBoxView.setImage(self.defaultCheckBoxButtonImage(full: false), for: UIControlState.normal)
        buttonnDistanciaCheckBoxView.setImage(self.defaultCheckBoxButtonImage(full: true), for: UIControlState.selected)
        buttonnDistanciaCheckBoxView.addTarget(self, action: #selector(self.checkBoxAction(_:)), for: .touchUpInside)
        buttonnDistanciaCheckBoxView.setTitle("Mais Proximo", for: UIControlState.normal)
        buttonnDistanciaCheckBoxView.setTitle("Mais Proximo", for: UIControlState.selected)
        buttonnDistanciaCheckBoxView.setTitleColor(GMColor.textColorPrimary(), for: .normal)
        buttonnDistanciaCheckBoxView.setTitleColor(GMColor.colorPrimary(), for: .selected)
        buttonnDistanciaCheckBoxView.isSelected = true
        buttonnDistanciaCheckBoxView.semanticContentAttribute = .forceLeftToRight
        buttonnDistanciaCheckBoxView.contentHorizontalAlignment = .left
        buttonnDistanciaCheckBoxView.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        buttonnDistanciaCheckBoxView.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        distanciaCheckBoxView.addArrangedSubview(buttonnDistanciaCheckBoxView)
        
        distanciaCheckBoxView.translatesAutoresizingMaskIntoConstraints = false
        distanciaCheckBoxView.backgroundColor = UIColor.white
        distanciaCheckBoxView.layer.cornerRadius = 6
        return distanciaCheckBoxView
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
        
        let buttonFiltrar = UIButton()
        buttonFiltrar.backgroundColor = GMColor.colorPrimary()
        buttonFiltrar.addTarget(self, action: #selector(didTappedOnBackgroundView), for: .touchUpInside)
        buttonFiltrar.setTitle("APLICAR", for: UIControlState.normal)
        buttonFiltrar.setTitle("APLICAR", for: UIControlState.selected)
        buttonFiltrar.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonFiltrar.setTitleColor(GMColor.whiteColor(), for: .selected)
        buttonFiltrar.titleLabel?.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        buttonFiltrar.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth/2)).isActive = true
        buttonFiltrar.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        buttonFiltrar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonFiltrar.layer.masksToBounds = true
        controllerButtonsView.addArrangedSubview(buttonFiltrar)
        
        let buttonCancelar = UIButton()
        buttonCancelar.backgroundColor = GMColor.red300Color()
        buttonCancelar.addTarget(self, action: #selector(didTappedOnBackgroundView), for: .touchUpInside)
        buttonCancelar.setTitle("CANCELAR", for: UIControlState.normal)
        buttonCancelar.setTitle("CANCELAR", for: UIControlState.selected)
        buttonCancelar.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonCancelar.setTitleColor(GMColor.whiteColor(), for: .selected)
        buttonCancelar.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth/2)).isActive = true
        buttonCancelar.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        //controllerButtonsView.addArrangedSubview(buttonCancelar)
        
        controllerButtonsView.translatesAutoresizingMaskIntoConstraints = false
        controllerButtonsView.backgroundColor = UIColor.white
        controllerButtonsView.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        return controllerButtonsView
    }
    
    @objc func buttonActionValor(sender: UIButton!) {
        switch sender.tag {
        case 1:
            if buttonnValorMenor.isSelected == true{
                buttonnValorMenor.isSelected = false
                valorMenor = false
                valorMaior = false
            }
            else{
                buttonnValorMenor.isSelected = true
                buttonnValorMaior.isSelected = false
                valorMenor = true
                valorMaior = false
            }
            break
        case 2:
            if buttonnValorMaior.isSelected == true{
                buttonnValorMaior.isSelected = false
                valorMenor = false
                valorMaior = false
            }
            else{
                buttonnValorMaior.isSelected = true
                buttonnValorMenor.isSelected = false
                valorMenor = false
                valorMaior = true
            }
            break
        default:
            break
        }
    }
    
    @objc func checkBoxAction(_ sender: UIButton)
    {
        if sender.isSelected
        {
            sender.isSelected = false
        }else {
            sender.isSelected = true
        }
    }
}
