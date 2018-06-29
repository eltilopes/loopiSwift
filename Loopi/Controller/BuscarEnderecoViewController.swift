//
//  BuscarEnderecoViewController.swift
//  Loopi
//
//  Created by Loopi on 25/06/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import DropDown
import SwiftyJSON

class BuscarEnderecoViewController: UIViewController{
    
    let enderecoRest = EnderecoRest()
    var location = LocationFooter()
    var enderecoCEP = EnderecoCEP()
    
    @IBOutlet weak var textFieldCidade: LoopiTextField!
    @IBOutlet weak var textFieldEstado: LoopiTextField!
    @IBOutlet weak var labelBuscarEndereco: UILabel!
    let estadoDropDown = DropDown()
    let cidadeDropDown = DropDown()
    
    @IBOutlet weak var textFieldEndereco: LoopiTextField!
    @IBOutlet weak var textFieldNumero: LoopiTextField!
    @IBOutlet weak var textFieldComplemento: LoopiTextField!
    @IBOutlet weak var textFieldPontoReferencia: LoopiTextField!
    @IBOutlet weak var textFieldCEP: LoopiTextField!
    @IBOutlet weak var buttonBuscarCEP: UIButton!
    @IBOutlet weak var buttonSalvar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonSalvar()
        setupCidadeDropDown()
        setupEstadoDropDown()
        setupLabels()
        self.view.backgroundColor = GMColor.backgroundAppColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupLabels() {
        self.labelBuscarEndereco.backgroundColor = GMColor.backgroundAppColor()
        self.labelBuscarEndereco.textColor = GMColor.textColorPrimary()
        self.labelBuscarEndereco.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        
        let gestureRecognizerEstado = UITapGestureRecognizer(target: self, action: #selector(self.textFieldEstadoTap(_:)))
        textFieldEstado.isUserInteractionEnabled = true
        textFieldEstado.addGestureRecognizer(gestureRecognizerEstado)
        
        let gestureRecognizerCidade = UITapGestureRecognizer(target: self, action: #selector(self.textFieldCidadeTap(_:)))
        textFieldCidade.isUserInteractionEnabled = true
        textFieldCidade.addGestureRecognizer(gestureRecognizerCidade)
    }
    
    @objc func textFieldEstadoTap(_ sender: UITapGestureRecognizer) {
        estadoDropDown.show()
    }
    @objc func textFieldCidadeTap(_ sender: UITapGestureRecognizer) {
        cidadeDropDown.show()
    }
    
    func addButtonSalvar() {
        buttonSalvar.backgroundColor = GMColor.colorPrimary()
        buttonSalvar.tintColor = GMColor.whiteColor()
        buttonSalvar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonSalvar.layer.masksToBounds = true
        
        buttonBuscarCEP.backgroundColor = GMColor.buttonBlueColor()
        buttonBuscarCEP.tintColor = GMColor.whiteColor()
        buttonBuscarCEP.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonBuscarCEP.layer.masksToBounds = true
        buttonBuscarCEP.addTarget(self, action: #selector(buscarPorCEP(_:)), for: UIControlEvents.touchUpInside)
        
    }
    
    @objc func buscarPorCEP(_ sender : UIButton) {
        let cep = self.textFieldCEP.text!
        enderecoRest.buscarEnderecoCEP(cep: cep){ endereco, error in
            let activityProgressLoopi = ActivityProgressLoopi()
            let indicator = activityProgressLoopi.startActivity(obj: self)
            if error == nil {
                self.enderecoCEP = endereco!
                self.textFieldEndereco.text = self.enderecoCEP.logradouro
                self.textFieldPontoReferencia.text = self.enderecoCEP.bairro
                self.textFieldCidade.text = self.enderecoCEP.cidade
                self.textFieldEstado.text = self.enderecoCEP.estado
            }else{
                self.showToast(message: (error?.localizedDescription)!)
            }
            ActivityProgressLoopi().stopActivity(obj: self,indicator: indicator)
           
        }
    }
    
    func setupCidadeDropDown() {
        
        cidadeDropDown.bottomOffset = CGPoint(x: 0, y: cidadeDropDown.bounds.height)
        cidadeDropDown.anchorView = textFieldCidade
        cidadeDropDown.dataSource = ["Fortaleza", "Caucaia"]
        cidadeDropDown.selectionAction = { [weak self] (index, item) in
            self?.textFieldCidade.text = item
           
        }
        
    }
    func setupEstadoDropDown() {
        
        estadoDropDown.bottomOffset = CGPoint(x: 0, y: estadoDropDown.bounds.height)
        estadoDropDown.anchorView = textFieldEstado
        estadoDropDown.dataSource = ["Ceara"]
        estadoDropDown.selectionAction = { [weak self] (index, item) in
            self?.textFieldEstado.text = item
        }
        
    }
}


