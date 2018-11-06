//
//  NovaContaViewController.swift
//  Loopi
//
//  Created by Loopi on 10/10/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class NovaContaViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate  {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewNovaConta: UIView!
    @IBOutlet weak var labelCriarConta: UILabel!
    @IBOutlet weak var imagemLogo: UIImageView!
    @IBOutlet weak var nome: LeftPaddedTextField!
    @IBOutlet weak var telefone: LeftPaddedTextField!
    @IBOutlet weak var email: LeftPaddedTextField!
    @IBOutlet weak var cpf: LeftPaddedTextField!
    @IBOutlet weak var codigoConvite: LeftPaddedTextField!
    @IBOutlet weak var buttonPedirConvite: UIButton!
    @IBOutlet weak var buttonVoltar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dialogViewWidth = view.frame.width
        self.view.backgroundColor = GMColor.backgroundAppColor()
        self.viewNovaConta.backgroundColor = GMColor.backgroundAppColor()
        self.scrollView.backgroundColor = GMColor.backgroundAppColor()
        self.scrollView.isScrollEnabled = true
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.alwaysBounceHorizontal = false
        self.scrollView.delegate = self
        
        let image = UIImage(named: "logo")
        imagemLogo.image = image
        imagemLogo.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 1/3)).isActive = true
        imagemLogo.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel() * 2)).isActive = true
        
        labelCriarConta.text = "Faca seu cadastro para ter acesso aos servicos"
        labelCriarConta.textColor = GMColor.textColorPrimary()
        labelCriarConta.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 2/3)).isActive = true
        labelCriarConta.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel() * 2)).isActive = true
        
        nome.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightLeftPaddedTextField() )).isActive = true
        telefone.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightLeftPaddedTextField() )).isActive = true
        email.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightLeftPaddedTextField() )).isActive = true
        cpf.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightLeftPaddedTextField() )).isActive = true
        codigoConvite.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightLeftPaddedTextField() )).isActive = true
        
        /*
        nome.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 2/3)).isActive = true
        telefone.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 2/3)).isActive = true
        email.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 2/3)).isActive = true
        cpf.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 2/3)).isActive = true
        codigoConvite.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 2/3)).isActive = true
        */
        
        buttonPedirConvite.setTitle("CRIAR CONTA", for: .normal)
        buttonPedirConvite.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonPedirConvite.backgroundColor = GMColor.colorPrimary()
        buttonPedirConvite.addTarget(self, action: #selector(pedirConvite), for: .touchUpInside)
        buttonPedirConvite.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonPedirConvite.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightLeftPaddedTextField() )).isActive = true
        
        //buttonPedirConvite.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 1/3)).isActive = true
        
        buttonVoltar.setTitle("VOLTAR", for: .normal)
        buttonVoltar.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonVoltar.backgroundColor = GMColor.buttonOrangeColor()
        buttonVoltar.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        buttonVoltar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonVoltar.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightLeftPaddedTextField() )).isActive = true
        
        //buttonVoltar.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 1/3)).isActive = true
    }
    
    
    
    @objc func backAction() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func pedirConvite() {
        animatePage()
    }
    
    
    func animatePage() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}
