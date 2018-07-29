//
//  AceitarServicoViewController.swift
//  Loopi
//
//  Created by Loopi on 05/07/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit

class AceitarServicoViewController: UIViewController {
    
    @IBOutlet weak var cronometroView: CronometroView!
    @IBOutlet weak var labelAceitarServico: UILabel!
    @IBOutlet weak var buttonSim: UIButton!
    @IBOutlet weak var buttonNao: UIButton!
    
    let minutos = 180
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GMColor.backgroundAppColor()
        setupLabels()
        setupCronometro()
        addButtons()
    }
    
    func addButtons() {
        buttonSim.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonSim.layer.masksToBounds = true
        buttonSim.tintColor = GMColor.whiteColor()
        buttonSim.titleLabel!.textAlignment = .center
        buttonSim.titleLabel?.lineBreakMode = .byWordWrapping
        buttonSim.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonSim.backgroundColor = GMColor.colorPrimary()
        
        buttonNao.backgroundColor = GMColor.buttonRedColor()
        buttonNao.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonNao.layer.masksToBounds = true
        buttonNao.tintColor = GMColor.whiteColor()
        buttonNao.titleLabel!.textAlignment = .center
        buttonNao.titleLabel?.lineBreakMode = .byWordWrapping
        buttonNao.setTitleColor(GMColor.whiteColor(), for: .normal)
    }
    
    func setupCronometro() {
        // uncomment this line if would like to see a minute and second representation of the remaining time
        // (rather than just a second representation
        cronometroView.useMinutesAndSecondsRepresentation = true
        cronometroView.backgroundColor = GMColor.backgroundAppColor()
        cronometroView.labelFont = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        cronometroView.labelTextColor = GMColor.colorPrimary()
        cronometroView.timerFinishingText = "Finalizado"
        cronometroView.lineWidth = 10
        cronometroView.lineColor = GMColor.colorPrimary()
        
        let viewWidth = self.view.frame.width-60
        cronometroView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        cronometroView.heightAnchor.constraint(equalToConstant: viewWidth).isActive = true
        cronometroView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cronometroView.frameCounterLabel = cronometroView.frame
        cronometroView.start(beginingValue: minutos , interval: 1)

    }
    
    func setupLabels() {
        self.labelAceitarServico.backgroundColor = GMColor.backgroundAppColor()
        self.labelAceitarServico.textColor = GMColor.textColorPrimary()
        self.labelAceitarServico.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
    }
}
