//
//  PedirConviteViewController.swift
//  Loopi
//
//  Created by Loopi on 16/10/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class PedirConviteViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate  {


    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewPedirConvite: UIView!
    @IBOutlet weak var labelPedirConvite: UILabel!
    @IBOutlet weak var imagemLogo: UIImageView!
    @IBOutlet weak var nome: LoopiTextField!
    @IBOutlet weak var telefone: LoopiTextField!
    @IBOutlet weak var email: LoopiTextField!
    @IBOutlet weak var cpf: LoopiTextField!
    @IBOutlet weak var codigoConvite: LoopiTextField!
    @IBOutlet weak var buttonVoltar: UIButton!
    @IBOutlet weak var buttonPedirConvite: UIButton!
    @IBOutlet weak var buttonTemConvite: CheckBox!
    
    
    let activityProgressLoopi = ActivityProgressLoopi()
    var indicator:UIActivityIndicatorView!
    var solicitarConvite : SolicitarConvite = SolicitarConvite()
    let solicitarConviteRest = SolicitarConviteRest()
    var usuario : Usuario = Usuario()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dialogViewWidth = view.frame.width
        self.view.backgroundColor = GMColor.backgroundAppColor()
        self.viewPedirConvite.backgroundColor = GMColor.backgroundAppColor()
        self.scrollView.backgroundColor = GMColor.backgroundAppColor()
        self.scrollView.isScrollEnabled = true
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.alwaysBounceHorizontal = false
        self.scrollView.delegate = self
        
        let image = UIImage(named: "logo_loopi")
        imagemLogo.image = image
        imagemLogo.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 1/3)).isActive = true
        imagemLogo.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel() * 2)).isActive = true
        
        labelPedirConvite.text = "Solicite seu convite para ter acesso aos servicos"
        labelPedirConvite.textColor = GMColor.textColorPrimary()
        labelPedirConvite.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 2/3)).isActive = true
        labelPedirConvite.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel() * 2)).isActive = true
        
        nome.validations = [.OBRIGATORIO,.NOME_COMPLETO]
        nome.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        nome.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontMedium()))
        nome.text = "Elton Lopes e Silva"
        
        telefone.validations = [.OBRIGATORIO,.NUMERO]
        telefone.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        telefone.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontMedium()))
        telefone.text = "85989214075"
        
        email.validations = [.OBRIGATORIO,.EMAIL]
        email.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        email.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontMedium()))
        email.text = "eltilopes@gmail.com"
        
        cpf.validations = [.OBRIGATORIO,.NUMERO]
        cpf.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        cpf.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontMedium()))
        cpf.text = "92871259372"
        
        codigoConvite.validations = [.OBRIGATORIO, .CODIGO_CONVITE]
        codigoConvite.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        codigoConvite.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontMedium()))
        codigoConvite.isHidden = true
        
        buttonPedirConvite.setTitle("PEDIR CONVITE", for: .normal)
        buttonPedirConvite.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonPedirConvite.backgroundColor = GMColor.colorPrimary()
        buttonPedirConvite.addTarget(self, action: #selector(pedirConvite), for: .touchUpInside)
        buttonPedirConvite.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonPedirConvite.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightLeftPaddedTextField() )).isActive = true
        
        buttonVoltar.setTitle("VOLTAR", for: .normal)
        buttonVoltar.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonVoltar.backgroundColor = GMColor.buttonOrangeColor()
        buttonVoltar.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        buttonVoltar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonVoltar.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightLeftPaddedTextField() )).isActive = true
        
        
        buttonTemConvite.semanticContentAttribute = .forceLeftToRight
        buttonTemConvite.contentHorizontalAlignment = .left
        buttonTemConvite.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightCheckBoxButton())).isActive = true
        buttonTemConvite.addTarget(self, action:#selector(temConvite(sender:)), for: .touchUpInside)
       
    }
    
    
    
    @objc func backAction() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func temConvite(sender: UIButton) {
        
        if buttonTemConvite.isChecked == true{
            codigoConvite.isHidden = false
        } else {
            codigoConvite.isHidden = true
        }

    }
   
    @objc func pedirConvite() {
        let nomeIsEmpty = nome.text?.isEmptyAndContainsNoWhitespace()
        let telefoneIsEmpty = telefone.text?.isEmptyAndContainsNoWhitespace()
        let emailIsEmpty = email.text?.isEmptyAndContainsNoWhitespace()
        let cpfIsEmpty = cpf.text?.isEmptyAndContainsNoWhitespace()
        let codigoConviteIsEmpty = buttonTemConvite.isChecked == true && (codigoConvite.text?.isEmptyAndContainsNoWhitespace())!
        if nomeIsEmpty! {
            nome.setError(erro: "Campo Obrigatorio")
        }
        if telefoneIsEmpty! {
            telefone.setError(erro: "Campo Obrigatorio")
        }
        if emailIsEmpty! {
            email.setError(erro: "Campo Obrigatorio")
        }
        if cpfIsEmpty! {
            cpf.setError(erro: "Campo Obrigatorio")
        }
        if codigoConviteIsEmpty {
            codigoConvite.setError(erro: "Campo Obrigatorio")
        }
        if (nomeIsEmpty! == false) && (telefoneIsEmpty! == false) && (emailIsEmpty! == false) && (cpfIsEmpty! == false) && (codigoConviteIsEmpty == false){
            //dismiss(animated: true)
            indicator = activityProgressLoopi.startActivity(controller: self)
            self.solicitarConvite.nome = nome.text
            self.solicitarConvite.telefone = telefone.text
            self.solicitarConvite.email = email.text
            self.solicitarConvite.cpf = cpf.text
            //self.solicitarConvite.codigoConvite = codigoConvite.text
            pedirConviteRest()
            /*
            let cardsServiceController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardsServiceController") as! CardsServiceController
            present(cardsServiceController, animated: true, completion: nil)
            */
            //perform(#selector(presentCardsServiceController), with: nil, afterDelay: 0.01)
        }
    }
    
    @objc func presentCardsServiceController() {
        //let cardsServiceController = CardsServiceController()
        let cardsServiceController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardsServiceController") as! CardsServiceController
        present(cardsServiceController, animated: true, completion: nil)
    }
    
    func loginController() {
        //self.perform(#selector(self.presentLoginController), with: nil, afterDelay: 0.0)
        self.activityProgressLoopi.stopActivity(controller: self,indicator: self.indicator)
        //dismiss(animated: true)
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
        //let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //appDel.window?.rootViewController = loginController
    }
    
    func pedirConviteRest() {
        
        solicitarConviteRest.solicitarConvite(solicitarConvite: solicitarConvite ){  usuario, error in
            if error == nil {
                self.usuario = usuario!
                self.loginController()
            }else{
                self.activityProgressLoopi.stopActivity(controller: self,indicator: self.indicator)
                self.showToast(message: (error?.localizedDescription)!)
            }
        }
    }
    
   
    
    func animatePage() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
  
}


