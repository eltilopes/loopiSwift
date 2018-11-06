//
//  CriarContaViewController.swift
//  Loopi
//
//  Created by Loopi on 22/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class CriarContaViewController: UIViewController , UITextFieldDelegate, UIScrollViewDelegate  {
   
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
        buttonPedirConvite.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        return buttonPedirConvite
    }()
    
    lazy var buttonVoltar: UIButton = {
        let buttonVoltar = UIButton(type: .system)
        buttonVoltar.setTitle("VOLTAR", for: .normal)
        buttonVoltar.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonVoltar.backgroundColor = GMColor.buttonOrangeColor()
        buttonVoltar.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        buttonVoltar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        return buttonVoltar
    }()
  
    @objc func backAction() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    let scrollView = UIScrollView()
    
    /*
    lazy var  scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        scrollView.backgroundColor = GMColor.backgroundHeaderColor()
        scrollView.widthAnchor.constraint(equalToConstant: CGFloat(screenWidth)).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: CGFloat(screenHeight) ).isActive = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: screenWidth, height: 2000)
        return scrollView
    }()
    */
    @objc func pedirConvite() {
        animatePage()
    }
    
    
    func animatePage() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func aplicarScrollView() {
        
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width - 60
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.delegate = self
        scrollView.scrollsToTop = false
        scrollView.bounces = true
        scrollView.backgroundColor = GMColor.backgroundAppColor()
        scrollView.canCancelContentTouches = true
        scrollView.addSubview(nome)
        scrollView.addSubview(telefone)
        scrollView.addSubview(email)
        scrollView.addSubview(cpf)
        scrollView.addSubview(codigoConvite)
        scrollView.addSubview(buttonVoltar)
        scrollView.addSubview(buttonPedirConvite)
        
        _ = nome.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, topConstant: 35, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: screenWidth, heightConstant: 50)
        
        _ = telefone.anchor(top: nome.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: screenWidth, heightConstant: 50)
        
        _ = email.anchor(top: telefone.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: screenWidth, heightConstant: 50)
        
        _ = cpf.anchor(top: email.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: screenWidth, heightConstant: 50)
        
        _ = codigoConvite.anchor(top: cpf.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: screenWidth, heightConstant: 50)
        
        _ = buttonVoltar.anchor(top: codigoConvite.bottomAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: nil, topConstant: 40, leftConstant: 10, bottomConstant: 30, rightConstant: 5, widthConstant: screenWidth / 2 , heightConstant: 50)
        
        _ = buttonPedirConvite.anchor(top: codigoConvite.bottomAnchor, left: buttonVoltar.rightAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, topConstant: 40, leftConstant: 5, bottomConstant: 30, rightConstant: 10, widthConstant: screenWidth / 2 , heightConstant: 50)
    }
    
    func aplicarLayout() {
        view.backgroundColor = GMColor.backgroundAppColor()
        let screensize: CGRect = UIScreen.main.bounds
        let screenHeight = screensize.height
        let screenWidth = screensize.width - 80
        view.addSubview(headerView)
        view.addSubview(scrollView)
        aplicarScrollView()
       
        _ = headerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = scrollView.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 10, rightConstant: 20, widthConstant: screenWidth, heightConstant: screenHeight * 2 )
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

