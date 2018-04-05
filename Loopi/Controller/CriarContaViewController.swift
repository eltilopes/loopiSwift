//
//  CriarContaViewController.swift
//  Loopi
//
//  Created by Loopi on 22/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class CriarContaViewController: UIViewController , UITextFieldDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        aplicarLayout()
    }
   
    let nome: LeftPaddedTextField = LeftPaddedTextField(placeHolder: "Nome")
    let telefone: LeftPaddedTextField = LeftPaddedTextField(placeHolder: "Telefone")
    let email: LeftPaddedTextField =  LeftPaddedTextField(placeHolder: "E-mail")
    let cpf: LeftPaddedTextField = LeftPaddedTextField(placeHolder: "CPF")
    let codigoConvite: LeftPaddedTextField = LeftPaddedTextField(placeHolder: "Codigo do Convite")
    
    lazy var headerView: UIStackView = {
        let headerView = UIStackView()
        headerView.clipsToBounds = true
        headerView.axis  = UILayoutConstraintAxis.horizontal
        headerView.distribution  = UIStackViewDistribution.equalSpacing
        headerView.alignment = UIStackViewAlignment.center
        
        let dialogViewWidth = view.frame.width
        
        let backgroundView = UIView()
        backgroundView.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth)).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel() * 4)).isActive = true
        backgroundView.backgroundColor = GMColor.backgroundHeaderColor()
        headerView.addArrangedSubview(backgroundView)
        
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        imageView.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 1/3)).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel() * 2)).isActive = true
        headerView.addArrangedSubview(imageView)
        
        let headerText = UILabel()
        headerText.text = "Faca seu cadastro para ter acesso aos servicos"
        headerText.textColor = GMColor.textColorPrimary()
        headerText.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 2/3)).isActive = true
        headerText.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel() * 2)).isActive = true
        headerView.addArrangedSubview(headerText)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = GMColor.backgroundHeaderColor()
        return headerView
    }()
    
    lazy var buttonPedirConvite: UIButton = {
        let buttonPedirConvite = UIButton(type: .system)
        buttonPedirConvite.setTitle("PEDIR CONVITE", for: .normal)
        buttonPedirConvite.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonPedirConvite.backgroundColor = GMColor.colorPrimary()
        buttonPedirConvite.addTarget(self, action: #selector(pedirConvite), for: .touchUpInside)
        buttonPedirConvite.layer.cornerRadius = 5.0
        return buttonPedirConvite
    }()
    
    @objc func pedirConvite() {
        animatePage()
    }
    
    
    func animatePage() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func aplicarLayout() {
        view.backgroundColor = GMColor.backgroundAppColor()
        view.addSubview(nome)
        view.addSubview(headerView)
        view.addSubview(telefone)
        view.addSubview(email)
        view.addSubview(cpf)
        view.addSubview(codigoConvite)
        view.addSubview(buttonPedirConvite)
       
        _ = headerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = nome.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 60, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50)
        
        _ = telefone.anchor(top: nome.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 40, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50)
        
        _ = email.anchor(top: telefone.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 40, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50)
        
        _ = cpf.anchor(top: email.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 40, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50)
        
        _ = codigoConvite.anchor(top: cpf.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 40, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50)
        
        _ = buttonPedirConvite.anchor(top: codigoConvite.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 60, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

