//
//  LoginCell.swift
//  Loopi
//
//  Created by Loopi on 07/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    var usuario = Usuario()
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "logo_loopi")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    lazy var usuarioTextField: LoopiTextField = {
        let textField = LoopiTextField()
        textField.backgroundColor = GMColor.backgroundColorLoopiTextField()
        //textField.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        textField.labelString = "CPF / CNPJ"
        textField.textAlignment = .left
        textField.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.backgroundColorLoopiTextField())
        textField.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontMedium()))
        textField.horizontalInset = CGFloat(5)
        textField.verticalInset = CGFloat(5)
        textField.validations = [.OBRIGATORIO,.CPF_CNPJ]
        textField.keyboardType = .namePhonePad
        textField.tamanhoCampo = 18
        textField.setInstanceController(instanceController: true)
        textField.text = LoopiTextFieldUtil.mask(valorMask: usuario.cpf!)
        textField.setTitle()
        return textField
    }()
    
    lazy var senhaTextField: LoopiTextField = {
        let textField = LoopiTextField()
        textField.backgroundColor = GMColor.backgroundColorLoopiTextField()
        //textField.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        textField.labelString = "SENHA"
        textField.textAlignment = .left
        textField.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.backgroundColorLoopiTextField())
        textField.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontMedium()))
        textField.horizontalInset = CGFloat(5)
        textField.verticalInset = CGFloat(5)
        textField.validations = [.OBRIGATORIO]
        textField.isSecureTextEntry = true
        textField.setInstanceController(instanceController: true)
        textField.setTitle()
        textField.text = (usuario.senha?.isEmptyAndContainsNoWhitespace())! ? "" : usuario.senha
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        button.backgroundColor = GMColor.colorPrimary()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("ENTRAR", for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var pedirConviteView: UIStackView = {
        let pedirConviteView = UIStackView()
        pedirConviteView.clipsToBounds = true
        pedirConviteView.axis  = UILayoutConstraintAxis.horizontal
        pedirConviteView.distribution  = UIStackViewDistribution.equalSpacing
        pedirConviteView.alignment = UIStackViewAlignment.center
        
        let dialogViewWidth = frame.width-64
        
        let buttonPedirConvite = UIButton()
        buttonPedirConvite.backgroundColor = GMColor.grey300Color()
        buttonPedirConvite.addTarget(self, action: #selector(pedirConvite), for: .touchUpInside)
        buttonPedirConvite.setTitleColor(GMColor.colorPrimary(), for: .normal)
        buttonPedirConvite.setTitle("PEDIR CONVITE", for: .normal)
        buttonPedirConvite.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        buttonPedirConvite.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        pedirConviteView.addArrangedSubview(buttonPedirConvite)
        
        pedirConviteView.translatesAutoresizingMaskIntoConstraints = false
        pedirConviteView.backgroundColor = UIColor.white
        pedirConviteView.layer.cornerRadius = 6
        return pedirConviteView
    }()
    
    weak var delegate: LoginControllerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        usuario = UserDefaults.standard.getUsuario()
        addSubview(logoImageView)
        addSubview(usuarioTextField)
        //addSubview(loginTextField)
        addSubview(senhaTextField)
        addSubview(loginButton)
        addSubview(pedirConviteView)
        
        _ = logoImageView.anchor(top: centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -200, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 120, heightConstant: 120)
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        _ = usuarioTextField.anchor(top: logoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: ConstraintsView.marginTopLoopiTextField(), leftConstant: ConstraintsView.marginLoopiTextField(), bottomConstant: 0, rightConstant: ConstraintsView.marginLoopiTextField(), widthConstant: 0, heightConstant: ConstraintsView.heightLoopiTextField())
        
        //_ = loginTextField.anchor(top: usuarioTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50)
        
        _ = senhaTextField.anchor(top: usuarioTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: ConstraintsView.marginTopLoopiTextField(), leftConstant: ConstraintsView.marginLoopiTextField(), bottomConstant: 0, rightConstant: ConstraintsView.marginLoopiTextField(), widthConstant: 0, heightConstant: ConstraintsView.heightLoopiTextField())
        
        _ = loginButton.anchor(top: senhaTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: ConstraintsView.marginTopButtonLogin(), leftConstant:ConstraintsView.marginButtonLogin() , bottomConstant: 0, rightConstant: ConstraintsView.marginButtonLogin(), widthConstant: 0, heightConstant: ConstraintsView.heightLoopiTextField())
        
        _ = pedirConviteView.anchor(top: loginButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: ConstraintsView.marginTopButtonLogin(), leftConstant: ConstraintsView.marginButtonLogin(), bottomConstant: 0, rightConstant: ConstraintsView.marginButtonLogin(), widthConstant: 0, heightConstant: ConstraintsView.heightLoopiTextField())
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleLogin() {
        let usuario = Usuario()
        usuario.cpf = usuarioTextField.existeErro  ? "" : LoopiTextFieldUtil.unmask(string: usuarioTextField.text!)
        usuario.senha = senhaTextField.existeErro  ? "" : senhaTextField.text
        delegate?.finishedLogIn(usuario: usuario)
    }
    
    @objc func pedirConvite() {
        delegate?.pedirConvite()
    }
    
}

