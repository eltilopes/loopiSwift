//
//  ConfirmarSaqueViewController.swift
//  Loopi
//
//  Created by Loopi on 25/04/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class ConfirmarSaqueViewController: UIViewController{
   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelBanco : UILabel!
    @IBOutlet weak var labelAgencia : UILabel!
    @IBOutlet weak var labelConta : UILabel!
    @IBOutlet weak var labelValor : UILabel!
    @IBOutlet weak var labelInfoAgencia : UILabel!
    @IBOutlet weak var labelInfoConta : UILabel!
    @IBOutlet weak var labelInfoBanco : UILabel!
    @IBOutlet weak var buttonConfirmar: UIButton!
    @IBOutlet weak var textFieldSenha: LoopiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonConfirmar()
        setupLabelValor()
        setupLabels()
        self.scrollView.backgroundColor = GMColor.backgroundAppColor()
        textFieldSenha.validations = [.OBRIGATORIO,.NUMERO]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addButtonConfirmar() {
        buttonConfirmar.backgroundColor = GMColor.colorPrimary()
        buttonConfirmar.tintColor = GMColor.whiteColor()
        buttonConfirmar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonConfirmar.layer.masksToBounds = true
    }
    
    func setupLabels() {
        labelInfoBanco.tintColor = GMColor.colorPrimary()
        labelBanco.tintColor = GMColor.textColorPrimary()
        labelInfoAgencia.tintColor = GMColor.colorPrimary()
        labelAgencia.tintColor = GMColor.textColorPrimary()
        labelInfoConta.tintColor = GMColor.colorPrimary()
        labelConta.tintColor = GMColor.textColorPrimary()
    }
    
    func setupLabelValor() {
        
        labelValor.lineBreakMode=NSLineBreakMode.byWordWrapping
        var attrString = NSMutableAttributedString()
        let stringValor = "Valor"
        let stringValorReal = "R$ 112,50"
        
        attrString += (NSMutableAttributedString(string : stringValor, font: UIFont.systemFont(ofSize: 13), maxWidth: 100)! + "\n" )
        attrString += (NSMutableAttributedString(string : stringValorReal , font: UIFont.systemFont(ofSize: 20), maxWidth: 100)!  + "\n" )
        attrString.addAttribute(NSAttributedStringKey.foregroundColor, value: GMColor.whiteColor(), range: NSMakeRange(0, (stringValorReal.count + stringValor.count)))
        labelValor.attributedText = attrString
        labelValor.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        labelValor.layer.masksToBounds = true
        labelValor.tintColor = GMColor.whiteColor()
        labelValor.numberOfLines = 2
        labelValor.textAlignment = .center
        labelValor.translatesAutoresizingMaskIntoConstraints = false
        labelValor.lineBreakMode = .byWordWrapping
        labelValor.backgroundColor = GMColor.buttonBlueColor()
        
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saqueSolicitadoSegue" {
            //  let mapViewController  = segue.destination as! MapViewController
        }
    }
    
    
}
