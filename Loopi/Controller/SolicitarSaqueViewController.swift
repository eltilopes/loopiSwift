//
//  SolicitarSaqueViewController.swift
//  Loopi
//
//  Created by Loopi on 17/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class SolicitarSaqueViewController: UIViewController  {
    

    @IBOutlet weak var bancoPicker: UIPickerView!
    let bancoPickerDelegate = BancoPickerDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bancoPicker.delegate = bancoPickerDelegate
        bancoPicker.dataSource = bancoPickerDelegate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}


class BancoPickerDelegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let manufacturers = ["Banco Brasil", "CEF"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return manufacturers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return manufacturers[row]
    }
    
}

