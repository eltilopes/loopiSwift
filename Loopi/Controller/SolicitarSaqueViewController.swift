//
//  SolicitarSaqueViewController.swift
//  Loopi
//
//  Created by Loopi on 17/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import DropDown

class SolicitarSaqueViewController: UIViewController  {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bancoDropDownButton: PickerButton!
    let bancoDropDown = DropDown()
    
    @IBAction func showBancoDropDown(_ sender: AnyObject) {
        bancoDropDown.show()
    }
    
    @IBOutlet weak var finalidadeDropDownButton: PickerButton!
    let finalidadeDropDown = DropDown()
    
    @IBAction func showFinalidadeDropDown(_ sender: AnyObject) {
        finalidadeDropDown.show()
    }
    @IBOutlet weak var textFieldNome: LoopiTextField!
    @IBOutlet weak var textFieldAgencia: LoopiTextField!
    @IBOutlet weak var textFieldDVAgencia: LoopiTextField!
    @IBOutlet weak var textFieldConta: LoopiTextField!
    @IBOutlet weak var textFieldDVConta: LoopiTextField!
    @IBOutlet weak var textFieldValor: LoopiTextField!
    @IBOutlet weak var buttonContinuar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.backgroundColor = GMColor.backgroundAppColor()
        setupBancoDropDown()
        setupFinalidadeDropDown()
        setupButtonContinuar()
        textFieldNome.validations = [.OBRIGATORIO,.NOME_COMPLETO]
        textFieldAgencia.validations = [.OBRIGATORIO,.NUMERO]
        textFieldDVAgencia.validations = [.OBRIGATORIO,.NUMERO]
        textFieldConta.validations = [.OBRIGATORIO,.NUMERO]
        textFieldDVConta.validations = [.OBRIGATORIO,.NUMERO]
        textFieldValor.validations = [.OBRIGATORIO,.NUMERO]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    func setupButtonContinuar() {
        buttonContinuar.backgroundColor = GMColor.colorPrimary()
        buttonContinuar.tintColor = GMColor.whiteColor()
        buttonContinuar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonContinuar.layer.masksToBounds = true
    }
    func setupBancoDropDown() {
        
        bancoDropDown.bottomOffset = CGPoint(x: 0, y: bancoDropDown.bounds.height)
        bancoDropDown.anchorView = bancoDropDownButton
        bancoDropDown.dataSource = ["Banco Brasil", "CEF", "BNB"]
        bancoDropDown.selectionAction = { [weak self] (index, item) in
            let alert = LoopiAlertController(title: nil, message: item, preferredStyle: .alert)
            self?.present(alert, animated: true)
            let duration: Double = 2
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                alert.dismiss(animated: true)
            }
        }
        
    }
    
    func setupFinalidadeDropDown() {
        
        finalidadeDropDown.bottomOffset = CGPoint(x: 0, y: finalidadeDropDown.bounds.height)
        finalidadeDropDown.anchorView = finalidadeDropDownButton
        finalidadeDropDown.dataSource = ["CC", "DOC", "TED"]
        finalidadeDropDown.selectionAction = { [weak self] (index, item) in
            let alert = LoopiAlertController(title: nil, message: item, preferredStyle: .alert)
            self?.present(alert, animated: true)
            let duration: Double = 2
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                alert.dismiss(animated: true)
            }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "confirmarSaqueSegue" {
            //  let mapViewController  = segue.destination as! MapViewController
        }
    }
    
}

extension DropDown {
    public override func draw(_ rect: CGRect) {
        self.dismissMode = .onTap
        self.direction = .bottom
        self.backgroundColor = GMColor.backgroundAppColor()
        self.textColor = GMColor.textColorPrimary()
        self.tintColor = GMColor.textColorPrimary()
        self.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.layer.borderColor = GMColor.whiteColor().cgColor
        self.layer.borderWidth = CGFloat(ConstraintsView.widthBorderLoopiTextField())
        super.draw(rect)
    }
}


