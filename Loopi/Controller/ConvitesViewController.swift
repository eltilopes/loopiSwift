//
//  ConvitesViewController.swift
//  Loopi
//
//  Created by Loopi on 27/06/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit

class ConvitesViewController: UIViewController{
    
    @IBOutlet weak var labelCashBackFriend : UILabel!
    @IBOutlet weak var labelInfoCashBackFriend : UILabel!
    @IBOutlet weak var labelInfoCodigoConvite : UILabel!
    @IBOutlet weak var imageCashBackFriend : UIImageView!
    //@IBOutlet weak var buttonWhatsApp: UIButton!
    @IBOutlet weak var buttonShared: UIButton!
    
    @IBAction func shareTextButton(_ sender: UIButton) {
        
        // text to share
        let text = "This is some text that I want to share."
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonWhatsApp()
        setupLabels()
        self.view.backgroundColor = GMColor.backgroundAppColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addButtonWhatsApp() {
 
        
        let imageShared = UIImage(named: "ic_shared")
        buttonShared.setImage(imageShared, for: .normal)
        //buttonShared.backgroundColor = GMColor.buttonBlueColor()
        buttonShared.layer.cornerRadius = buttonShared.bounds.size.width / 2.0
        buttonShared.layer.borderColor = GMColor.whiteColor().cgColor
        buttonShared.layer.borderWidth = 2
        buttonShared.layer.masksToBounds = true
        
        imageCashBackFriend.contentMode = .scaleAspectFit
        imageCashBackFriend.layer.borderWidth = 2
        imageCashBackFriend.layer.masksToBounds = false
        imageCashBackFriend.layer.borderColor = GMColor.whiteColor().cgColor
        imageCashBackFriend.backgroundColor = GMColor.colorPrimary()
        imageCashBackFriend.image = UIImage(named: "ic_cash_back_friend")
        imageCashBackFriend.layer.cornerRadius = imageCashBackFriend.bounds.size.width / 2.0
        imageCashBackFriend.layer.masksToBounds = true
    }
    
    func setupLabels() {
        
        self.labelCashBackFriend.backgroundColor = GMColor.backgroundAppColor()
        self.labelCashBackFriend.textColor = GMColor.textColorPrimary()
        self.labelCashBackFriend.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        
        self.labelInfoCashBackFriend.backgroundColor = GMColor.backgroundAppColor()
        self.labelInfoCashBackFriend.textColor = GMColor.textColorPrimary()
        self.labelInfoCashBackFriend.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        
        self.labelInfoCodigoConvite.backgroundColor = GMColor.backgroundAppColor()
        self.labelInfoCodigoConvite.textColor = GMColor.textColorPrimary()
        self.labelInfoCodigoConvite.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        
    }
    
   
}


