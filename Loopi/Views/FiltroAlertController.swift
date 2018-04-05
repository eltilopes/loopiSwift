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
        let dialogViewWidth = frame.width-64
        dialogView.addArrangedSubview(getTitleLabel(title: "Filtro", dialogViewWidth: Int(dialogViewWidth)))
        dialogView.addArrangedSubview(getSeparatorLineView(dialogViewWidth: Int(dialogViewWidth)))
        dialogView.addArrangedSubview(getOrdemAlfabeticaView(dialogViewWidth: Int(dialogViewWidth)))
        dialogView.addArrangedSubview(getSeparatorLineView(dialogViewWidth: Int(dialogViewWidth)))
        dialogView.addArrangedSubview(getDistanciaCheckBoxView(dialogViewWidth: Int(dialogViewWidth)))
        dialogView.addArrangedSubview(getSeparatorLineView(dialogViewWidth: Int(dialogViewWidth)))
        dialogView.addArrangedSubview(getValorView(dialogViewWidth: Int(dialogViewWidth)))
        dialogView.addArrangedSubview(getSeparatorLineView(dialogViewWidth: Int(dialogViewWidth)))
        dialogView.addArrangedSubview(getControllerButtonsView(dialogViewWidth: Int(dialogViewWidth)))
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 6
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
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 30), false, 0.0)
        UIColor.white.setFill()
        let path = UIBezierPath(ovalIn: CGRect(x: 5, y: 5, width: 20, height: 20))
        if full {
            GMColor.cyan300Color().setFill()
        }else{
            GMColor.whiteColor().setFill()
        }
        GMColor.cyan300Color().setStroke()
        path.lineWidth = 5
        path.stroke()
        path.fill()
        defaultRadioButtonEmptyImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return defaultRadioButtonEmptyImage;
    }
    
    func defaultCheckBoxButtonImage(full: Bool ) -> UIImage {
        var defaultRadioButtonEmptyImage = UIImage()
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 30), false, 0.0)
        UIColor.white.setFill()
        let path = UIBezierPath(rect: CGRect(x: 5, y: 5, width: 20, height: 20))
        if full {
            GMColor.cyan300Color().setFill()
        }else{
            GMColor.whiteColor().setFill()
        }
        GMColor.cyan300Color().setStroke()
        path.lineWidth = 5
        path.stroke()
        path.fill()
        defaultRadioButtonEmptyImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return defaultRadioButtonEmptyImage;
    }
    
    func getTitleLabel(title: String,dialogViewWidth : Int) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.tintColor = GMColor.whiteColor()
        titleLabel.backgroundColor = GMColor.cyan300Color()
        titleLabel.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        titleLabel.textAlignment = .center
        return titleLabel
    }
    
    func getSeparatorLineView(dialogViewWidth : Int) -> UIView {
        let separatorLineView = UIView()
        separatorLineView.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightSeparatorLineView())).isActive = true
        separatorLineView.backgroundColor = GMColor.whiteColor()
        return separatorLineView
    }
    
    
    func getOrdemAlfabeticaView(dialogViewWidth : Int) -> UIStackView {
        
        let ordemAlfabeticaView = UIStackView()
        ordemAlfabeticaView.clipsToBounds = true
        ordemAlfabeticaView.axis  = UILayoutConstraintAxis.vertical
        ordemAlfabeticaView.distribution  = UIStackViewDistribution.equalSpacing
        ordemAlfabeticaView.alignment = UIStackViewAlignment.center
        
        ordemAlfabeticaAZ = false
        ordemAlfabeticaZA = false
        
        let titleOrdemAlfabetica = UILabel()
        titleOrdemAlfabetica.tintColor = GMColor.grey500Color()
        titleOrdemAlfabetica.backgroundColor = GMColor.whiteColor()
        titleOrdemAlfabetica.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        titleOrdemAlfabetica.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        titleOrdemAlfabetica.text = "Nome do Prestador"
        titleOrdemAlfabetica.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleOrdemAlfabetica.textAlignment = .center
        ordemAlfabeticaView.addArrangedSubview(titleOrdemAlfabetica)
        
        buttonnOrdemAlfabeticaAZ = UIButton()
        buttonnOrdemAlfabeticaAZ.backgroundColor = GMColor.whiteColor()
        buttonnOrdemAlfabeticaAZ.tag = 1
        buttonnOrdemAlfabeticaAZ.setImage(self.defaultRadioButtonImage(full: false), for: UIControlState.normal)
        buttonnOrdemAlfabeticaAZ.setImage(self.defaultRadioButtonImage(full: true), for: UIControlState.selected)
        buttonnOrdemAlfabeticaAZ.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        buttonnOrdemAlfabeticaAZ.setTitle("A - Z", for: UIControlState.normal)
        buttonnOrdemAlfabeticaAZ.setTitle("A - Z", for: UIControlState.selected)
        buttonnOrdemAlfabeticaAZ.setTitleColor(GMColor.grey500Color(), for: .normal)
        buttonnOrdemAlfabeticaAZ.setTitleColor(GMColor.grey500Color(), for: .selected)
        buttonnOrdemAlfabeticaAZ.semanticContentAttribute = .forceLeftToRight
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
        buttonnOrdemAlfabeticaZA.setTitleColor(GMColor.grey500Color(), for: .normal)
        buttonnOrdemAlfabeticaZA.setTitleColor(GMColor.grey500Color(), for: .selected)
        buttonnOrdemAlfabeticaZA.semanticContentAttribute = .forceLeftToRight
        buttonnOrdemAlfabeticaZA.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        buttonnOrdemAlfabeticaZA.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        
        ordemAlfabeticaView.addArrangedSubview(buttonnOrdemAlfabeticaZA)
        ordemAlfabeticaView.translatesAutoresizingMaskIntoConstraints = false
        ordemAlfabeticaView.backgroundColor = UIColor.white
        ordemAlfabeticaView.layer.cornerRadius = 6
        return ordemAlfabeticaView
    }
    
    func getValorView(dialogViewWidth : Int) -> UIStackView {
        
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
        titleValor.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        titleValor.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        titleValor.text = "Valor"
        titleValor.textAlignment = .center
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
        buttonnValorMenor.setTitleColor(GMColor.grey500Color(), for: .normal)
        buttonnValorMenor.setTitleColor(GMColor.grey500Color(), for: .selected)
        buttonnValorMenor.semanticContentAttribute = .forceLeftToRight
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
        buttonnValorMaior.setTitleColor(GMColor.grey500Color(), for: .normal)
        buttonnValorMaior.setTitleColor(GMColor.grey500Color(), for: .selected)
        buttonnValorMaior.semanticContentAttribute = .forceLeftToRight
        buttonnValorMaior.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        buttonnValorMaior.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        
        valorView.addArrangedSubview(buttonnValorMaior)
        valorView.translatesAutoresizingMaskIntoConstraints = false
        valorView.backgroundColor = UIColor.white
        valorView.layer.cornerRadius = 6
        return valorView
    }
    
    
    func getDistanciaCheckBoxView(dialogViewWidth : Int) -> UIStackView {
        
        let distanciaCheckBoxView = UIStackView()
        distanciaCheckBoxView.clipsToBounds = true
        distanciaCheckBoxView.axis  = UILayoutConstraintAxis.vertical
        distanciaCheckBoxView.distribution  = UIStackViewDistribution.equalSpacing
        distanciaCheckBoxView.alignment = UIStackViewAlignment.center
        
        let titleDistanciaCheckBoxView = UILabel()
        titleDistanciaCheckBoxView.tintColor = GMColor.grey500Color()
        titleDistanciaCheckBoxView.backgroundColor = GMColor.whiteColor()
        titleDistanciaCheckBoxView.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        titleDistanciaCheckBoxView.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        titleDistanciaCheckBoxView.text = "Distancia"
        titleDistanciaCheckBoxView.textAlignment = .center
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
        buttonnDistanciaCheckBoxView.setTitleColor(GMColor.grey500Color(), for: .normal)
        buttonnDistanciaCheckBoxView.setTitleColor(GMColor.grey500Color(), for: .selected)
        buttonnDistanciaCheckBoxView.semanticContentAttribute = .forceLeftToRight
        buttonnDistanciaCheckBoxView.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        buttonnDistanciaCheckBoxView.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        distanciaCheckBoxView.addArrangedSubview(buttonnDistanciaCheckBoxView)
        
        distanciaCheckBoxView.translatesAutoresizingMaskIntoConstraints = false
        distanciaCheckBoxView.backgroundColor = UIColor.white
        distanciaCheckBoxView.layer.cornerRadius = 6
        return distanciaCheckBoxView
    }
    
    func getControllerButtonsView(dialogViewWidth : Int) -> UIStackView {
        
        let controllerButtonsView = UIStackView()
        controllerButtonsView.clipsToBounds = true
        controllerButtonsView.axis  = UILayoutConstraintAxis.horizontal
        controllerButtonsView.distribution  = UIStackViewDistribution.equalSpacing
        controllerButtonsView.alignment = UIStackViewAlignment.center
        
        
        let buttonFiltrar = UIButton()
        buttonFiltrar.backgroundColor = GMColor.cyan300Color()
        buttonFiltrar.addTarget(self, action: #selector(didTappedOnBackgroundView), for: .touchUpInside)
        buttonFiltrar.setTitle("Filtrar", for: UIControlState.normal)
        buttonFiltrar.setTitle("Filtrar", for: UIControlState.selected)
        buttonFiltrar.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonFiltrar.setTitleColor(GMColor.whiteColor(), for: .selected)
        buttonFiltrar.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth/2)).isActive = true
        buttonFiltrar.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        controllerButtonsView.addArrangedSubview(buttonFiltrar)
        
        let buttonCancelar = UIButton()
        buttonCancelar.backgroundColor = GMColor.red300Color()
        buttonCancelar.addTarget(self, action: #selector(didTappedOnBackgroundView), for: .touchUpInside)
        buttonCancelar.setTitle("Cancelar", for: UIControlState.normal)
        buttonCancelar.setTitle("Cancelar", for: UIControlState.selected)
        buttonCancelar.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonCancelar.setTitleColor(GMColor.whiteColor(), for: .selected)
        buttonCancelar.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth/2)).isActive = true
        buttonCancelar.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        controllerButtonsView.addArrangedSubview(buttonCancelar)
        
        controllerButtonsView.translatesAutoresizingMaskIntoConstraints = false
        controllerButtonsView.backgroundColor = UIColor.white
        controllerButtonsView.layer.cornerRadius = 6
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
