//
//  ProfissionalViewController.swift
//  Loopi
//
//  Created by Loopi on 12/04/18.
//  Copyright © 2018 Loopi. All rights reserved.
//
import UIKit

class ProfissionalViewController: UIViewController{
    
   
    @IBOutlet var buttonNovaSolicitacao: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "novoProfissionalSegue" {
            //  let mapViewController  = segue.destination as! MapViewController
        }
    }
    
    
}



