
//  ItemServicoAlertController.swift
//  Loopi
//
//  Created by Loopi on 31/07/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit

class ItemServicoAlertController: UIView, Modal{
    var backgroundView = UIView()
    var dialogView = UIStackView()
    var nomeTextField = LoopiTextField()
    var descricaoTextField = LoopiTextField()
    var valorTextField = LoopiTextField()
    var buttonSalvar = UIButton()
    
    var buttonOpcional = UIButton()
    var buttonObrigatorio = UIButton()
    var buttonUm = UIButton()
    var buttonMuitos = UIButton()
    
    var opcional = Bool()
    var obrigatorio = Bool()
    var um = Bool()
    var muitos = Bool()
    
    let sizeImage = 20
    let sizeUIImage = 30
    let marginTitle = CGFloat(55)
    var dialogViewHeight = CGFloat(0)
    var dialogViewWidth = CGFloat(0)
    
    var itemServico : ItemServico = ItemServico()
    var servicoProfissionalViewController : ServicoProfissionalViewController = ServicoProfissionalViewController()
    convenience init(itemServico: ItemServico, servicoProfissionalViewController : ServicoProfissionalViewController ) {
        self.init(frame: UIScreen.main.bounds)
        initialize(itemServico: itemServico , servicoProfissionalViewController : servicoProfissionalViewController)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize(itemServico: ItemServico, servicoProfissionalViewController : ServicoProfissionalViewController  ){
        self.itemServico = itemServico
        self.servicoProfissionalViewController = servicoProfissionalViewController
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
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getNomeTextFieldView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getDescricaoTextFieldView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getValorTextFieldView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getOpcionalObrigatorioView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getUmMuitosView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getControllerButtonsView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.addArrangedSubview(getSeparatorLineView())
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        dialogView.backgroundColor = GMColor.backgroundAppColor()
        dialogView.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        dialogView.layer.masksToBounds = true
        
        
        let x = frame.width/2 - dialogViewWidth/2 - CGFloat(sizeImage )
        let y = frame.height/2 - dialogViewHeight/2
        let width = dialogViewWidth + CGFloat(sizeImage * 2)
        let height = dialogViewHeight
        
        let viewBorder = UIView(frame: CGRect(x: x, y: y, width: width , height: height))
        viewBorder.backgroundColor = GMColor.backgroundAppColor()
        viewBorder.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        viewBorder.layer.masksToBounds = true
        addSubview(viewBorder)
        addSubview(dialogView)
        dialogView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dialogView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
    }
   
    
    @objc func buttonActionObrigatorio(sender: UIButton!) {
        switch sender.tag {
        case 1:
            if buttonOpcional.isSelected == true{
                buttonOpcional.isSelected = false
                opcional = false
                obrigatorio = false
            }
            else{
                buttonOpcional.isSelected = true
                buttonObrigatorio.isSelected = false
                opcional = true
                obrigatorio = false
            }
            break
        case 2:
            if buttonObrigatorio.isSelected == true{
                buttonObrigatorio.isSelected = false
                opcional = false
                obrigatorio = false
            }
            else{
                buttonObrigatorio.isSelected = true
                buttonOpcional.isSelected = false
                opcional = false
                obrigatorio = true
            }
            break
        default:
            break
        }
    }
    
    @objc func buttonActionUmMuitos(sender: UIButton!) {
        switch sender.tag {
        case 1:
            if buttonUm.isSelected == true{
                buttonUm.isSelected = false
                um = false
                muitos = false
            }
            else{
                buttonUm.isSelected = true
                buttonMuitos.isSelected = false
                um = true
                muitos = false
            }
            break
        case 2:
            if buttonMuitos.isSelected == true{
                buttonMuitos.isSelected = false
                um = false
                muitos = false
            }
            else{
                buttonMuitos.isSelected = true
                buttonUm.isSelected = false
                um = false
                muitos = true
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
        GMColor.textColorPrimary().setFill()
        let ovalInRect = CGRect(x: 5, y: 5, width: sizeImage, height: sizeImage)
        GMColor.textColorPrimary().setFill()
        UIBezierPath(ovalIn: ovalInRect).fill()
        if full {
            GMColor.whiteColor().setFill()
            UIBezierPath(ovalIn: CGRect(x: 10, y: 10, width: 10, height: 10)).fill()
            GMColor.colorPrimary().setFill()
            UIBezierPath(ovalIn: CGRect(x: 11.5, y: 11.5, width: 7, height: 7)).fill()
        }
        
        defaultRadioButtonEmptyImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return defaultRadioButtonEmptyImage;
    }
    
    
    func getOpcionalObrigatorioView() -> UIStackView {
        
        dialogViewHeight = dialogViewHeight + CGFloat(ConstraintsView.heightHeaderTitleLabel())
        dialogViewHeight = dialogViewHeight +  CGFloat(sizeUIImage)
        dialogViewHeight = dialogViewHeight +  CGFloat(sizeUIImage)
        
        let opcionalObrigatorioView = UIStackView()
        opcionalObrigatorioView.clipsToBounds = true
        opcionalObrigatorioView.axis  = UILayoutConstraintAxis.vertical
        opcionalObrigatorioView.distribution  = UIStackViewDistribution.equalSpacing
        opcionalObrigatorioView.alignment = UIStackViewAlignment.center
        
        opcional = false
        obrigatorio = false
        
        let titleOpcionalObrigatorio = UILabel()
        titleOpcionalObrigatorio.tintColor = GMColor.textColorPrimary()
        titleOpcionalObrigatorio.backgroundColor = GMColor.backgroundAppColor()
        titleOpcionalObrigatorio.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        titleOpcionalObrigatorio.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        titleOpcionalObrigatorio.text = "SELECAO"
        titleOpcionalObrigatorio.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        titleOpcionalObrigatorio.textAlignment = .left
        opcionalObrigatorioView.addArrangedSubview(titleOpcionalObrigatorio)
        
        buttonOpcional = UIButton()
        buttonOpcional.backgroundColor = GMColor.backgroundAppColor()
        buttonOpcional.tag = 1
        buttonOpcional.setImage(self.defaultRadioButtonImage(full: false), for: UIControlState.normal)
        buttonOpcional.setImage(self.defaultRadioButtonImage(full: true), for: UIControlState.selected)
        buttonOpcional.addTarget(self, action: #selector(buttonActionObrigatorio), for: .touchUpInside)
        buttonOpcional.setTitle("Opcional", for: UIControlState.normal)
        buttonOpcional.setTitle("Opcional", for: UIControlState.selected)
        buttonOpcional.setTitleColor(GMColor.textColorPrimary(), for: .normal)
        buttonOpcional.setTitleColor(GMColor.colorPrimary(), for: .selected)
        buttonOpcional.isSelected = true
        buttonOpcional.semanticContentAttribute = .forceLeftToRight
        buttonOpcional.contentHorizontalAlignment = .left
        buttonOpcional.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        buttonOpcional.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        opcionalObrigatorioView.addArrangedSubview(buttonOpcional)
        
        buttonObrigatorio = UIButton()
        buttonObrigatorio.backgroundColor = GMColor.backgroundAppColor()
        buttonObrigatorio.tag = 2
        buttonObrigatorio.setImage(self.defaultRadioButtonImage(full: false), for: UIControlState.normal)
        buttonObrigatorio.setImage(self.defaultRadioButtonImage(full: true), for: UIControlState.selected)
        buttonObrigatorio.addTarget(self, action: #selector(buttonActionObrigatorio), for: .touchUpInside)
        buttonObrigatorio.setTitle("Obrigatorio", for: UIControlState.normal)
        buttonObrigatorio.setTitle("Obrigatorio", for: UIControlState.selected)
        buttonObrigatorio.setTitleColor(GMColor.textColorPrimary(), for: .normal)
        buttonObrigatorio.setTitleColor(GMColor.colorPrimary(), for: .selected)
        buttonObrigatorio.semanticContentAttribute = .forceLeftToRight
        buttonObrigatorio.contentHorizontalAlignment = .left
        buttonObrigatorio.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        buttonObrigatorio.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        
        opcionalObrigatorioView.addArrangedSubview(buttonObrigatorio)
        opcionalObrigatorioView.translatesAutoresizingMaskIntoConstraints = false
        opcionalObrigatorioView.backgroundColor = UIColor.white
        opcionalObrigatorioView.layer.cornerRadius = 6
        
        
        return opcionalObrigatorioView
    }
    
    func getUmMuitosView() -> UIStackView {
        dialogViewHeight = dialogViewHeight + CGFloat(ConstraintsView.heightHeaderTitleLabel() )
        dialogViewHeight = dialogViewHeight +  CGFloat(sizeUIImage)
        dialogViewHeight = dialogViewHeight +  CGFloat(sizeUIImage)
        let umMuitosView = UIStackView()
        umMuitosView.clipsToBounds = true
        umMuitosView.axis  = UILayoutConstraintAxis.vertical
        umMuitosView.distribution  = UIStackViewDistribution.equalSpacing
        umMuitosView.alignment = UIStackViewAlignment.center
        
        um = false
        muitos = false
        
        let titleUmMuitos = UILabel()
        titleUmMuitos.tintColor = GMColor.grey500Color()
        titleUmMuitos.backgroundColor = GMColor.backgroundAppColor()
        titleUmMuitos.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        titleUmMuitos.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        titleUmMuitos.text = "SELECIONAR"
        titleUmMuitos.textAlignment = .left
        titleUmMuitos.font = UIFont.boldSystemFont(ofSize: 20.0)
        umMuitosView.addArrangedSubview(titleUmMuitos)
        
        buttonUm = UIButton()
        buttonUm.backgroundColor = GMColor.backgroundAppColor()
        buttonUm.tag = 1
        buttonUm.setImage(self.defaultRadioButtonImage(full: false), for: UIControlState.normal)
        buttonUm.setImage(self.defaultRadioButtonImage(full: true), for: UIControlState.selected)
        buttonUm.addTarget(self, action: #selector(buttonActionUmMuitos), for: .touchUpInside)
        buttonUm.setTitle("Um", for: UIControlState.normal)
        buttonUm.setTitle("Um", for: UIControlState.selected)
        buttonUm.setTitleColor(GMColor.textColorPrimary(), for: .normal)
        buttonUm.setTitleColor(GMColor.colorPrimary(), for: .selected)
        buttonUm.isSelected = true
        buttonUm.semanticContentAttribute = .forceLeftToRight
        buttonUm.contentHorizontalAlignment = .left
        buttonUm.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        buttonUm.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        umMuitosView.addArrangedSubview(buttonUm)
        
        buttonMuitos = UIButton()
        buttonMuitos.backgroundColor = GMColor.backgroundAppColor()
        buttonMuitos.tag = 2
        buttonMuitos.setImage(self.defaultRadioButtonImage(full: false), for: UIControlState.normal)
        buttonMuitos.setImage(self.defaultRadioButtonImage(full: true), for: UIControlState.selected)
        buttonMuitos.addTarget(self, action: #selector(buttonActionUmMuitos), for: .touchUpInside)
        buttonMuitos.setTitle("Muitos", for: UIControlState.normal)
        buttonMuitos.setTitle("Muitos", for: UIControlState.selected)
        buttonMuitos.setTitleColor(GMColor.textColorPrimary(), for: .normal)
        buttonMuitos.setTitleColor(GMColor.colorPrimary(), for: .selected)
        buttonMuitos.semanticContentAttribute = .forceLeftToRight
        buttonMuitos.contentHorizontalAlignment = .left
        buttonMuitos.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        buttonMuitos.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        
        umMuitosView.addArrangedSubview(buttonMuitos)
        umMuitosView.translatesAutoresizingMaskIntoConstraints = false
        umMuitosView.backgroundColor = UIColor.white
        umMuitosView.layer.cornerRadius = 6
        return umMuitosView
    }
    
    
   
    @objc func onSalvarItemButtonPressed(){
        let nomeIsEmpty = nomeTextField.text?.isEmptyAndContainsNoWhitespace()
        let descricaoIsEmpty = descricaoTextField.text?.isEmptyAndContainsNoWhitespace()
        let valorIsEmpty = valorTextField.text?.isEmptyAndContainsNoWhitespace()
        if nomeIsEmpty! {
            nomeTextField.setError(erro: "Campo Obrigatorio")
        }
        if descricaoIsEmpty! {
            descricaoTextField.setError(erro: "Campo Obrigatorio")
        }
        if valorIsEmpty! {
            valorTextField.setError(erro: "Campo Obrigatorio")
        }
        if (nomeIsEmpty! == false) && (descricaoIsEmpty! == false) && (valorIsEmpty! == false){
            dismiss(animated: true)
            self.itemServico.nome = nomeTextField.text
            self.itemServico.descricao = descricaoTextField.text
            self.itemServico.valor = NumberFormatter().number(from: valorTextField.text!)?.doubleValue
            self.servicoProfissionalViewController.itemServico = self.itemServico
            self.servicoProfissionalViewController.onSalvarItemButtonPressed( )
        }
    }
    
    
    
    
    func getControllerButtonsView() -> UIStackView {
        dialogViewHeight = dialogViewHeight + CGFloat(ConstraintsView.heightHeaderTitleLabel() )
        let controllerButtonsView = UIStackView()
        controllerButtonsView.clipsToBounds = true
        controllerButtonsView.axis  = UILayoutConstraintAxis.horizontal
        controllerButtonsView.distribution  = UIStackViewDistribution.equalSpacing
        controllerButtonsView.alignment = UIStackViewAlignment.center
        
        let viewPadding = UIView()
        viewPadding.backgroundColor = GMColor.backgroundAppColor()
        viewPadding.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth/2)).isActive = true
        viewPadding.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        viewPadding.layer.masksToBounds = true
        controllerButtonsView.addArrangedSubview(viewPadding)
        
        buttonSalvar = UIButton()
        buttonSalvar.backgroundColor = GMColor.colorPrimary()
        buttonSalvar.addTarget(self, action: #selector(onSalvarItemButtonPressed), for: .touchUpInside)
        buttonSalvar.setTitle("SALVAR", for: UIControlState.normal)
        buttonSalvar.setTitle("SALVAR", for: UIControlState.selected)
        buttonSalvar.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonSalvar.setTitleColor(GMColor.whiteColor(), for: .selected)
        buttonSalvar.titleLabel?.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        buttonSalvar.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth/2)).isActive = true
        buttonSalvar.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        buttonSalvar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonSalvar.layer.masksToBounds = true
        //buttonSalvar.isEnabled = false
        controllerButtonsView.addArrangedSubview(buttonSalvar)
        
        controllerButtonsView.translatesAutoresizingMaskIntoConstraints = false
        controllerButtonsView.backgroundColor = UIColor.white
        controllerButtonsView.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        return controllerButtonsView
    }
    
    func getSeparatorLineView() -> UIView {
        let heightSeparatorLineView  = CGFloat(ConstraintsView.heightSeparatorLineView() )
        dialogViewHeight = dialogViewHeight + heightSeparatorLineView
        let separatorLineView = UIView()
        separatorLineView.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: heightSeparatorLineView).isActive = true
        separatorLineView.backgroundColor = GMColor.backgroundAppColor()
        return separatorLineView
    }
    
    
    func getNomeTextFieldView() -> UIStackView {
        
        dialogViewHeight = dialogViewHeight + CGFloat(ConstraintsView.heightHeaderTitleLabel())
        
        let nomeTextFieldView = UIStackView()
        nomeTextFieldView.clipsToBounds = true
        nomeTextFieldView.axis  = UILayoutConstraintAxis.vertical
        nomeTextFieldView.distribution  = UIStackViewDistribution.equalSpacing
        nomeTextFieldView.alignment = UIStackViewAlignment.center
        
        nomeTextField = LoopiTextField()
        nomeTextField.tintColor = GMColor.textColorPrimary()
        nomeTextField.backgroundColor = GMColor.whiteColor()
        nomeTextField.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        nomeTextField.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        nomeTextField.labelString = "NOME DO ITEM"
        nomeTextField.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        nomeTextField.textAlignment = .left
        nomeTextField.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        nomeTextField.horizontalInset = CGFloat(5)
        nomeTextField.verticalInset = CGFloat(5)
        nomeTextField.validations = [.OBRIGATORIO,.NOME_COMPLETO]
        nomeTextField.setTitle()
        nomeTextFieldView.addArrangedSubview(nomeTextField)
        
        
        nomeTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        nomeTextFieldView.backgroundColor = GMColor.whiteColor()
        nomeTextFieldView.layer.cornerRadius = 6
        
        
        return nomeTextFieldView
    }
    
    func getDescricaoTextFieldView() -> UIStackView {
        
        dialogViewHeight = dialogViewHeight + CGFloat(ConstraintsView.heightHeaderTitleLabel())
        
        let descricaoTextFieldView = UIStackView()
        descricaoTextFieldView.clipsToBounds = true
        descricaoTextFieldView.axis  = UILayoutConstraintAxis.vertical
        descricaoTextFieldView.distribution  = UIStackViewDistribution.equalSpacing
        descricaoTextFieldView.alignment = UIStackViewAlignment.center
        
        descricaoTextField = LoopiTextField()
        descricaoTextField.tintColor = GMColor.textColorPrimary()
        descricaoTextField.backgroundColor = GMColor.whiteColor()
        descricaoTextField.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        descricaoTextField.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        descricaoTextField.labelString = "DESCRICAO DO ITEM"
        descricaoTextField.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        descricaoTextField.textAlignment = .left
        descricaoTextField.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        descricaoTextField.horizontalInset = CGFloat(5)
        descricaoTextField.verticalInset = CGFloat(5)
        descricaoTextField.validations = [.OBRIGATORIO]
        descricaoTextField.setTitle()
        descricaoTextFieldView.addArrangedSubview(descricaoTextField)
        
        
        descricaoTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        descricaoTextFieldView.backgroundColor = UIColor.white
        descricaoTextFieldView.layer.cornerRadius = 6
        
        
        return descricaoTextFieldView
    }
    
    func getValorTextFieldView() -> UIStackView {
        
        dialogViewHeight = dialogViewHeight + CGFloat(ConstraintsView.heightHeaderTitleLabel())
        
        let valorTextFieldView = UIStackView()
        valorTextFieldView.clipsToBounds = true
        valorTextFieldView.axis  = UILayoutConstraintAxis.vertical
        valorTextFieldView.distribution  = UIStackViewDistribution.equalSpacing
        valorTextFieldView.alignment = UIStackViewAlignment.center
        
        valorTextField = LoopiTextField()
        valorTextField.tintColor = GMColor.textColorPrimary()
        valorTextField.backgroundColor = GMColor.whiteColor()
        valorTextField.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        valorTextField.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        valorTextField.labelString = "VALOR DO ITEM"
        valorTextField.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        valorTextField.textAlignment = .left
        valorTextField.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        valorTextField.horizontalInset = CGFloat(5)
        valorTextField.verticalInset = CGFloat(5)
        valorTextField.setTitle()
        valorTextFieldView.addArrangedSubview(valorTextField)
        
        
        valorTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        valorTextFieldView.backgroundColor = UIColor.white
        valorTextFieldView.layer.cornerRadius = 6
        
        
        return valorTextFieldView
    }
    
}

