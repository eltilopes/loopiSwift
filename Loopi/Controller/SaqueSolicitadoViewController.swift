//
//  SaqueSolicitadoViewController.swift
//  Loopi
//
//  Created by Loopi on 01/05/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class SaqueSolicitadoViewController: UIViewController{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelSaqueSolicitado : UILabel!
    @IBOutlet weak var labelDisponibilidade : UILabel!
    @IBOutlet weak var labelValor : UILabel!
    @IBOutlet weak var buttonContinuar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonContinuar()
        setupLabelValor()
        setupLabels()
        self.scrollView.backgroundColor = GMColor.backgroundAppColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addButtonContinuar() {
        buttonContinuar.backgroundColor = GMColor.colorPrimary()
        buttonContinuar.tintColor = GMColor.whiteColor()
        buttonContinuar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonContinuar.layer.masksToBounds = true
    }
    
    func setupLabels() {
        labelSaqueSolicitado.tintColor = GMColor.textColorPrimary()
        labelDisponibilidade.tintColor = GMColor.textColorPrimary()
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
}

