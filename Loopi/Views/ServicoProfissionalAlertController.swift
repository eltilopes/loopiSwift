//
//  ServicoProfissionalAlertController.swift
//  Loopi
//
//  Created by Loopi on 07/08/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit

class ServicoProfissionalAlertController: UIView, Modal{
    var backgroundView = UIView()
    var dialogView = UIStackView()
    var nomeTextField = LoopiTextField()
    var descricaoTextField = LoopiTextField()
    var valorTextField = LoopiTextField()
    var buttonSalvar = UIButton()
    
    let sizeImage = 20
    let sizeUIImage = 30
    let marginTitle = CGFloat(55)
    var dialogViewHeight = CGFloat(0)
    var dialogViewWidth = CGFloat(0)
    
    var profissionalCardViewController : ProfissionalCardViewController = ProfissionalCardViewController()
    var servicoProfissional : ServicoProfissional = ServicoProfissional()
    convenience init(servicoProfissional: ServicoProfissional, profissionalCardViewController : ProfissionalCardViewController ) {
        self.init(frame: UIScreen.main.bounds)
        initialize(servicoProfissional: servicoProfissional , profissionalCardViewController : profissionalCardViewController)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize(servicoProfissional: ServicoProfissional, profissionalCardViewController : ProfissionalCardViewController ){
        self.servicoProfissional = servicoProfissional
        self.profissionalCardViewController = profissionalCardViewController
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
    
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
    @objc func onSalvarServicoButtonPressed(){
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
            self.servicoProfissional.nome = nomeTextField.text
            self.servicoProfissional.descricao = descricaoTextField.text
            self.servicoProfissional.valor = NumberFormatter().number(from: valorTextField.text!)?.doubleValue
            self.profissionalCardViewController.servicoProfissional = self.servicoProfissional
            self.profissionalCardViewController.onSalvarServicoButtonPressed( )
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
        buttonSalvar.addTarget(self, action: #selector(onSalvarServicoButtonPressed), for: .touchUpInside)
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
        nomeTextField.labelString = "NOME DO SERVICO"
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
        descricaoTextField.labelString = "DESCRICAO DO SERVICO"
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
        valorTextField.labelString = "VALOR DO SERVICO"
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


