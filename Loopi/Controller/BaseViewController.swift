//
//  BaseViewController.swift
//  Loopi
//
//  Created by Loopi on 08/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import CoreLocation

class BaseViewController: UIViewController, SlideMenuDelegate,CLLocationManagerDelegate  {
    
    let footer = UIButton(type: .system)
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = 1000
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
   
    func showFooterLocation() {
        if footer.isHidden {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.footer.isHidden = false
            }, completion:nil)
            Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(hiddenFooterLocation), userInfo: nil, repeats: false)
        }
    }
    
    @objc func hiddenFooterLocation() {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.footer.isHidden = true
        }, completion:nil)
    }
    
    @objc func openLocationViewController(_ sender : UIButton) {
        self.openViewControllerBasedOnIdentifier("LocationViewController")
    }
    
    
    func addFooterLocation() {
        let enderecoString = "Voce esta em\nAv. Rogaciano Leite,54"
        let endereco = NSMutableAttributedString(string: enderecoString )
        endereco.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, 12))
        endereco.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 17), range: NSMakeRange(13, 19))
        endereco.addAttribute(NSAttributedStringKey.foregroundColor, value: GMColor.whiteColor(), range: NSMakeRange(0, endereco.length))

        footer.setAttributedTitle(endereco, for: .normal)
        footer.titleLabel!.textAlignment = .center
        footer.titleLabel?.lineBreakMode = .byWordWrapping
        footer.setTitleColor(GMColor.whiteColor(), for: .normal)
        footer.backgroundColor = GMColor.colorPrimary()
        footer.translatesAutoresizingMaskIntoConstraints = false
        hiddenFooterLocation()
        footer.addTarget(self, action: #selector(openLocationViewController), for: .touchUpInside)
        view.addSubview(footer)
        
        
        NSLayoutConstraint(item: footer, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true
        NSLayoutConstraint(item: footer, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: footer, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: footer, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func slideMenuItemSelectedAtIndex(_ index: Int32) {
        // let topViewController : UIViewController = self.navigationController!.topViewController!
        // print("View Controller is : \(topViewController) \n", terminator: "")
        switch(index){
        case 0:
            self.openViewControllerBasedOnIdentifier("ExtratoSaque")
            break
        case 1:
            self.openViewControllerBasedOnIdentifier("MeusPedidos")
            break
        case 2:
            self.openViewControllerBasedOnIdentifier("Profissional")
            break
        case 3:
            self.openViewControllerBasedOnIdentifier("Convites")
            break
        case 4:
            self.openViewControllerBasedOnIdentifier("Termos")
            break
        default:
            break
        }
    }
    
    func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
        
        let topViewController : UIViewController = self.navigationController!.topViewController!
        
        if (topViewController.restorationIdentifier! == destViewController.restorationIdentifier!){
            print("CardsServiceController")
        } else {
            self.navigationController!.pushViewController(destViewController, animated: true)
        }
    }
    
    func addHeaderButtons(){
        addFiltroButton()
        addSlideMenuButton()
    }
    
    func addSlideMenuButton(){
        let btnShowMenu = UIButton(type: UIButtonType.system)
        btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState())
        btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnShowMenu.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        self.navigationItem.leftBarButtonItem = customBarItem;
    }
    
    func addFiltroButton(){
        let btnShowFiltro = UIButton(type: UIButtonType.system)
        let filtroImage = UIImage(named: "ic_filtro")
        btnShowFiltro.setImage(filtroImage, for: UIControlState())
        btnShowFiltro.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnShowFiltro.addTarget(self, action: #selector(CardsServiceController.onFiltroButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        let customBarItemFiltro = UIBarButtonItem(customView: btnShowFiltro)
        
        let btnShowPesquisar = UIButton(type: UIButtonType.system)
        let pesquisarImage = UIImage(named: "ic_pesquisar")
        btnShowPesquisar.setImage(pesquisarImage, for: UIControlState())
        btnShowPesquisar.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnShowPesquisar.addTarget(self, action: #selector(CardsServiceController.onPesquisarButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        let customBarItemPesquisar = UIBarButtonItem(customView: btnShowPesquisar)
        
        self.navigationItem.rightBarButtonItems = [ customBarItemFiltro, customBarItemPesquisar];
    }
 
    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
        
        UIColor.black.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
        
        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
        
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return defaultMenuImage;
    }
    
    func defaultFiltroImage() -> UIImage {

        var defaultFiltroImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
 
        
        UIColor.white.setFill()
        
        
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 10, y: 18))
        shape.addLine(to: CGPoint(x: 14, y: 18))
        shape.addLine(to: CGPoint(x: 14, y: 16))
        shape.addLine(to: CGPoint(x: 10, y: 16))
        shape.addLine(to: CGPoint(x: 10, y: 18))
        shape.move(to: CGPoint(x: 3, y: 6))
        shape.addLine(to: CGPoint(x: 3, y: 8))
        shape.addLine(to: CGPoint(x: 21, y: 8))
        shape.addLine(to: CGPoint(x: 21, y: 6))
        shape.addLine(to: CGPoint(x: 3, y: 6))
        shape.move(to: CGPoint(x: 6, y: 13))
        shape.addLine(to: CGPoint(x: 18, y: 13))
        shape.addLine(to: CGPoint(x: 18, y: 11))
        shape.addLine(to: CGPoint(x: 6, y: 11))
        shape.addLine(to: CGPoint(x: 6, y: 13))
        shape.lineWidth = 1
        shape.fill()
        
        defaultFiltroImage = UIGraphicsGetImageFromCurrentImageContext()!
   
        UIGraphicsEndImageContext()
        
        return defaultFiltroImage;
    }
    
    @objc func onSlideMenuButtonPressed(_ sender : UIButton){
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let menuVC : MenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuVC.btnMenu = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        menuVC.view.layoutIfNeeded()
        
        
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
    }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            //let locationData = ["lat": location.coordinate.latitude, "long": location.coordinate.longitude]
            let locationData = ["lat": -3.741433, "long": -38.499196]
            UserDefaults.standard.set(locationData, forKey: "localizacao")
            UserDefaults.standard.synchronize()
            locationManager.stopUpdatingLocation()
        }	
        
    }
}

