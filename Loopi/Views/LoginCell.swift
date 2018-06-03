//
//  LoginCell.swift
//  Loopi
//
//  Created by Loopi on 07/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "logo_loopi")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        textField.layer.borderColor = GMColor.whiteColor().cgColor
        textField.layer.borderWidth = 2
        textField.textColor = GMColor.whiteColor()
        textField.attributedPlaceholder = NSAttributedString(string: "Cpf/Cnpj", attributes: [NSAttributedStringKey.foregroundColor : GMColor.textColorPrimary()])
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let passwordTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        textField.layer.borderColor = GMColor.whiteColor().cgColor
        textField.layer.borderWidth = 2
        textField.textColor = GMColor.whiteColor()
        textField.attributedPlaceholder = NSAttributedString(string: "Senha", attributes: [NSAttributedStringKey.foregroundColor : GMColor.textColorPrimary()])
        textField.isSecureTextEntry = true
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
    
    lazy var contaView: UIStackView = {
        let contaView = UIStackView()
        contaView.clipsToBounds = true
        contaView.axis  = UILayoutConstraintAxis.horizontal
        contaView.distribution  = UIStackViewDistribution.equalSpacing
        contaView.alignment = UIStackViewAlignment.center
        
        let dialogViewWidth = frame.width-64
        
        let buttonCriarConta = UIButton()
        buttonCriarConta.backgroundColor = GMColor.grey300Color()
        buttonCriarConta.addTarget(self, action: #selector(criarConta), for: .touchUpInside)
        buttonCriarConta.setTitleColor(GMColor.textColorPrimary(), for: .normal)
        buttonCriarConta.setTitle("CRIAR CONTA", for: .normal)
        buttonCriarConta.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 3/7)).isActive = true
        buttonCriarConta.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        contaView.addArrangedSubview(buttonCriarConta)
        
        let separatorLineView = UIView()
        separatorLineView.widthAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.widhtSeparatorLineView())).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        separatorLineView.backgroundColor = GMColor.textColorPrimary()
        contaView.addArrangedSubview(separatorLineView)
        
        let buttonPedirConvite = UIButton()
        buttonPedirConvite.backgroundColor = GMColor.grey300Color()
        buttonPedirConvite.addTarget(self, action: #selector(pedirConvite), for: .touchUpInside)
        buttonPedirConvite.setTitleColor(GMColor.textColorPrimary(), for: .normal)
        buttonPedirConvite.setTitle("PEDIR CONVITE", for: .normal)
        buttonPedirConvite.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 3/7)).isActive = true
        buttonPedirConvite.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        contaView.addArrangedSubview(buttonPedirConvite)
        
        contaView.translatesAutoresizingMaskIntoConstraints = false
        contaView.backgroundColor = UIColor.white
        contaView.layer.cornerRadius = 6
        return contaView
    }()
    
    weak var delegate: LoginControllerDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(contaView)
        
        _ = logoImageView.anchor(top: centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -200, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        _ = emailTextField.anchor(top: logoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50)
        
        _ = passwordTextField.anchor(top: emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 15, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50)
        
        _ = loginButton.anchor(top: passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 15, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50)
        
        _ = contaView.anchor(top: loginButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 15, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleLogin() {
        delegate?.finishedLogIn()
    }
    
    @objc func criarConta() {
        delegate?.criarConta()
    }
    
    @objc func pedirConvite() {
        delegate?.pedirConvite()
    }
    
}

