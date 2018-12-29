//
//  EditarUsuarioViewController.swift
//  Loopi
//
//  Created by Loopi on 29/11/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class EditarUsuarioViewController: UIViewController, UIScrollViewDelegate  {
    
    @IBOutlet var labelEditarUsuario : UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imagemUsuario: UIImageView!
    @IBOutlet weak var textFieldNome: LoopiTextField!
    @IBOutlet weak var textFieldEmail: LoopiTextField!
    @IBOutlet weak var textFieldTelefone: LoopiTextField!
    @IBOutlet weak var textFieldCpf: LoopiTextField!
    @IBOutlet var buttonAlterarSenha: UIButton!
    @IBOutlet var buttonSalvar: UIButton!
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
        
        self.imagemUsuario.layer.borderWidth = 1
        self.imagemUsuario.layer.masksToBounds = false
        self.imagemUsuario.layer.borderColor = GMColor.colorPrimaryDark().cgColor
        self.imagemUsuario.layer.cornerRadius = imagemUsuario.frame.height/2
        let imageURL = URL(string: usuario.urlImagem!)
        var image: UIImage?
        if let url = imageURL {
            //All network operations has to run on different thread(not on main thread).
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                //All UI operations has to run on main thread.
                DispatchQueue.main.async {
                    if imageData != nil {
                        image = UIImage(data: imageData! as Data)
                        
                    } else {
                        image = UIImage(named: "perfil")
                    }
                    self.imagemUsuario.image = image
                    self.imagemUsuario.contentMode = .scaleAspectFit
                    self.imagemUsuario.autoresizesSubviews = false
                    self.imagemUsuario.clipsToBounds = true
                }
            }
        }
        
        self.labelEditarUsuario.backgroundColor = GMColor.backgroundAppColor()
        self.labelEditarUsuario.textColor = GMColor.textColorPrimary()
        self.labelEditarUsuario.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        self.labelEditarUsuario.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth * 2/3)).isActive = true
        self.labelEditarUsuario.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel() * 2)).isActive = true
        
        self.textFieldNome.validations = [.OBRIGATORIO,.NOME_COMPLETO]
        self.textFieldNome.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        self.textFieldNome.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontMedium()))
        self.textFieldNome.text = usuario.nome
        self.textFieldNome.setEditavel(editavel: true)
        self.textFieldNome.setTitle()
        
        self.textFieldEmail.validations = [.OBRIGATORIO,.EMAIL]
        self.textFieldEmail.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        self.textFieldEmail.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontMedium()))
        self.textFieldEmail.text = usuario.login
        self.textFieldEmail.setEditavel(editavel: true)
        self.textFieldEmail.setTitle()
        
        self.textFieldTelefone.validations = [.OBRIGATORIO,.NUMERO]
        self.textFieldTelefone.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        self.textFieldTelefone.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontMedium()))
        self.textFieldTelefone.text = usuario.telefone
        self.textFieldTelefone.setEditavel(editavel: true)
        self.textFieldTelefone.setTitle()
        
        self.textFieldCpf.validations = [.OBRIGATORIO,.CPF_CNPJ]
        self.textFieldCpf.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        self.textFieldCpf.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontMedium()))
        self.textFieldCpf.isEnabled = false
        self.textFieldCpf.isOpaque = true
        self.textFieldCpf.text = usuario.cpf
        self.textFieldCpf.setEditavel(editavel: true)
        self.textFieldCpf.setTitle()
        
        self.buttonAlterarSenha.setTitle("ALTERAR SENHA", for: .normal)
        self.buttonAlterarSenha.setTitleColor(GMColor.whiteColor(), for: .normal)
        self.buttonAlterarSenha.backgroundColor = GMColor.buttonBlueColor()
        self.buttonAlterarSenha.addTarget(self, action: #selector(alterarSenhaAction), for: .touchUpInside)
        self.buttonAlterarSenha.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.buttonAlterarSenha.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightLeftPaddedTextField() )).isActive = true
        
        self.buttonSalvar.setTitle("SALVAR", for: .normal)
        self.buttonSalvar.setTitleColor(GMColor.whiteColor(), for: .normal)
        self.buttonSalvar.backgroundColor = GMColor.colorPrimary()
        self.buttonSalvar.addTarget(self, action: #selector(salvarAction), for: .touchUpInside)
        self.buttonSalvar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.buttonSalvar.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightLeftPaddedTextField() )).isActive = true
        
    }
    
    @objc func salvarAction() {
        let nomeValido = (textFieldNome.text?.isEmptyAndContainsNoWhitespace())! && !(textFieldNome.existeErro)
        let telefoneValido = (textFieldTelefone.text?.isEmptyAndContainsNoWhitespace())! && !(textFieldTelefone.existeErro)
        let emailValido = (textFieldEmail.text?.isEmptyAndContainsNoWhitespace())! && !(textFieldEmail.existeErro)
        if !nomeValido  {
            textFieldNome.setError(erro: "Campo Obrigatorio")
        }
        if !telefoneValido {
            textFieldTelefone.setError(erro: "Campo Obrigatorio")
        }
        if !emailValido {
            textFieldEmail.setError(erro: "Campo Obrigatorio")
        }
        if (nomeValido == false) && (telefoneValido == false) && (emailValido == false){
            //dismiss(animated: true)
            indicator = activityProgressLoopi.startActivity(controller: self)
            self.usuario.nome = textFieldNome.text
            self.usuario.telefone = textFieldTelefone.text
            self.usuario.login = textFieldEmail.text
            editarUsuarioRest()
        }
        
    }
    
    func editarUsuarioRest() {
        
        usuarioRest.editarUsuario(usuario: self.usuario ){  usuario, error in
            if error == nil {
                self.usuario = usuario!
                self.activityProgressLoopi.stopActivity(controller: self,indicator: self.indicator)
                self.showToast(message: "Atualizado", backgroundColorLoopiAlert: GMColor.backgroundAlertInfoColor())
            }else{
                self.activityProgressLoopi.stopActivity(controller: self,indicator: self.indicator)
                self.showToast(message: (error?.localizedDescription)!)
            }
        }
    }
    
    
    @objc func alterarSenhaAction() {
        self.performSegue(withIdentifier: "alterarSenhaSegue", sender: self.usuario)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "alterarSenhaSegue" {
            let alterarSenhaViewController = segue.destination as! AlterarSenhaViewController
            alterarSenhaViewController.usuario = self.usuario
        }
    }
    
    
}
