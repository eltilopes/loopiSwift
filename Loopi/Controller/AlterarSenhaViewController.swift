//
//  AlterarSenhaViewController.swift
//  Loopi
//
//  Created by Loopi on 10/12/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit



class AlterarSenhaViewController: UIViewController, UIScrollViewDelegate  {
    
    @IBOutlet var labelAlterarSenha : UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textFieldNovaSenha: LoopiTextField!
    @IBOutlet weak var textFieldConfirmacaoSenha: LoopiTextField!
    @IBOutlet weak var textFieldCodigo: LoopiTextField!
    @IBOutlet var buttonAlterarSenha: UIButton!
    @IBOutlet var buttonVoltar: UIButton!
    
    var usuario = Usuario()
    let activityProgressLoopi = ActivityProgressLoopi()
    var indicator:UIActivityIndicatorView!
    let usuarioRest = UsuarioRest()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let dialogViewWidth = view.frame.width
        self.usuario = UserDefaults.standard.getUsuario()
        self.view.backgroundColor = GMColor.backgroundAppColor()
        self.scrollView.backgroundColor = GMColor.backgroundAppColor()
        self.scrollView.isScrollEnabled = true
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.alwaysBounceHorizontal = false
        self.scrollView.delegate = self
        
        
        
        self.labelAlterarSenha.backgroundColor = GMColor.backgroundAppColor()
        self.labelAlterarSenha.textColor = GMColor.textColorPrimaryDark()
        self.labelAlterarSenha.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        self.labelAlterarSenha.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 2/3)).isActive = true
        self.labelAlterarSenha.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel() * 2)).isActive = true
        
        self.textFieldNovaSenha.validations = [.OBRIGATORIO, .SENHA]
        self.textFieldNovaSenha.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        self.textFieldNovaSenha.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontMedium()))
        self.textFieldNovaSenha.setSecureTextEntry(secureTextEntry: true)
        //self.textFieldNovaSenha.setKeyboardType(keyboardTipo: .phonePad)
        self.textFieldNovaSenha.setEditavel(editavel: true)
        self.textFieldNovaSenha.setTitle()
        
        
        self.textFieldConfirmacaoSenha.validations = [.OBRIGATORIO, .SENHA]
        self.textFieldConfirmacaoSenha.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        self.textFieldConfirmacaoSenha.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontMedium()))
        self.textFieldConfirmacaoSenha.setSecureTextEntry(secureTextEntry: true)
        //self.textFieldConfirmacaoSenha.setKeyboardType(keyboardTipo: .phonePad)
        self.textFieldConfirmacaoSenha.setEditavel(editavel: true)
        self.textFieldConfirmacaoSenha.setTitle()
        
        self.textFieldCodigo.validations = [.OBRIGATORIO,.CODIGO_ALTERAR_SENHA]
        self.textFieldCodigo.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        self.textFieldCodigo.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontMedium()))
        //self.textFieldCodigo.setKeyboardType(keyboardTipo: .phonePad)
        self.textFieldCodigo.setEditavel(editavel: true)
        self.textFieldCodigo.setTitle()
        
        
        self.buttonAlterarSenha.setTitle("ALTERAR SENHA", for: .normal)
        self.buttonAlterarSenha.setTitleColor(GMColor.whiteColor(), for: .normal)
        self.buttonAlterarSenha.backgroundColor = GMColor.colorPrimary()
        self.buttonAlterarSenha.addTarget(self, action: #selector(alterarSenhaAction), for: .touchUpInside)
        self.buttonAlterarSenha.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.buttonAlterarSenha.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightLeftPaddedTextField() )).isActive = true
        
        
        self.buttonVoltar.setTitle("VOLTAR", for: .normal)
        self.buttonVoltar.setTitleColor(GMColor.whiteColor(), for: .normal)
        self.buttonVoltar.backgroundColor = GMColor.buttonOrangeColor()
        self.buttonVoltar.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.buttonVoltar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.buttonVoltar.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightLeftPaddedTextField() )).isActive = true
        
        
        self.indicator = self.activityProgressLoopi.startActivity(controller: self)
        resgataSenhaRest()
        
    }
    
    @objc func backAction() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func resgataSenhaRest() {
        usuarioRest.resgatarSenha(usuario: self.usuario ){  usuario, error in
            if error == nil {
                self.usuario = usuario!
                self.showToast(message: "Verifique seu email para obter o codigo", backgroundColorLoopiAlert: GMColor.backgroundAlertInfoColor())
                self.activityProgressLoopi.stopActivity(controller: self,indicator: self.indicator)
                
            }else{
                print((error?.localizedDescription)!)
                self.activityProgressLoopi.stopActivity(controller: self,indicator: self.indicator)
                self.showToast(message: (error?.localizedDescription)!)
            }
        }
    }
    
  
    
    @objc func alterarSenhaAction() {
        let senhaValida = (textFieldNovaSenha.text?.isEmptyAndContainsNoWhitespace())! && !(textFieldNovaSenha.existeErro)
        let novaSenhaValida = (textFieldConfirmacaoSenha.text?.isEmptyAndContainsNoWhitespace())! && !(textFieldConfirmacaoSenha.existeErro)
        let codigoValido = (textFieldCodigo.text?.isEmptyAndContainsNoWhitespace())! && !(textFieldCodigo.existeErro)
        
        if !senhaValida  {
            textFieldNovaSenha.setError(erro: "Campo Obrigatorio")
        }
        if !novaSenhaValida {
            textFieldConfirmacaoSenha.setError(erro: "Campo Obrigatorio")
        }
        if !codigoValido {
            textFieldCodigo.setError(erro: "Campo Obrigatorio")
        }
        if (senhaValida == false) && (novaSenhaValida == false) && (codigoValido == false){
            if (textFieldConfirmacaoSenha.text == textFieldNovaSenha.text){
                self.indicator = self.activityProgressLoopi.startActivity(controller: self)
                let alterarSenhaVo = AlterarSenhaVo()
                alterarSenhaVo.chave = textFieldCodigo.text
                alterarSenhaVo.senha = textFieldNovaSenha.text
                alterarSenhaUsuarioRest(alterarSenhaVo: alterarSenhaVo)
            }else{
                self.showToast(message: "A confirmacao da senha nao confere")
            }
        }
    }
    
    func alterarSenhaUsuarioRest(alterarSenhaVo : AlterarSenhaVo) {
        usuarioRest.alterarSenha(alterarSenhaVo: alterarSenhaVo){  usuario,erro, error in
            if erro.isNotEmptyAndContainsNoWhitespace(){
                self.activityProgressLoopi.stopActivity(controller: self,indicator: self.indicator)
                self.showToast(message: erro)
            }else if error == nil {
                self.usuario = usuario!
                self.activityProgressLoopi.stopActivity(controller: self,indicator: self.indicator)
                UserDefaults.standard.setIsLoggedIn(value: false)
                UserDefaults.standard.setToken(token: "")
                UserDefaults.standard.setLogin(login: "")
                self.backAction()
                //let loginController = LoginController()
                //self.present(loginController, animated: true, completion: nil)
                
            }else{
                self.activityProgressLoopi.stopActivity(controller: self,indicator: self.indicator)
                self.showToast(message: (error?.localizedDescription)!)
            }
        }
    }
    
    
}
