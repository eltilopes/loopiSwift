//
//  MenuViewController.swift
//  Loopi
//
//  Created by Loopi on 08/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var heightHeader = ConstraintsView.heightHeaderApp() 
    /**
     *  Array to display menu options
     */
    @IBOutlet var tblMenuOptions : UITableView!
    
    /**
     *  Transparent button to hide menu
     */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    /**
     *  Array containing menu options
     */
    var arrayMenuOptions = [Dictionary<String,String>]()
    
    /**
     *  Menu button which was tapped to display the menu
     */
    var btnMenu : UIButton!
    
    /**
     *  Delegate of the MenuVC
     */
    var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuOptions.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
    }
    
    func updateArrayMenuOptions(){
        arrayMenuOptions.append(["title":"Extrato/Saque", "icon":"ic_money"])
        arrayMenuOptions.append(["title":"Meus Pedidos", "icon":"ic_assignment"])
        arrayMenuOptions.append(["title":"Profissional", "icon":"ic_profissional"])
        arrayMenuOptions.append(["title":"Configuracoes", "icon":"ic_configuracoes"])
        
        arrayMenuOptions.append(["title":"Relate um Problema", "icon":"ic_relate"])
        
        arrayMenuOptions.append(["title":"Indique e Ganhe CashBack", "icon":"ic_indique"])
        
        tblMenuOptions.reloadData()
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        })
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        let heightImageView = heightHeader - 10
        vw.backgroundColor = GMColor.blue200Color()
        let headerImage = UIImage(named: "perfil")
        let headerImageView = UIImageView(image: headerImage)
        headerImageView.tintColor = UIColor.white
        headerImageView.frame = CGRect(x:5, y:0, width:heightImageView, height:heightImageView)
        headerImageView.contentMode = .scaleAspectFit
        vw.addSubview(headerImageView)
        
        let headerLabel = UILabel(frame: CGRect(x:20, y:heightImageView - 10, width:heightImageView + 10, height:18))
        headerLabel.textColor = UIColor.white
        headerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        headerLabel.text = "Usuario";
        vw.addSubview(headerLabel)
        return vw
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = GMColor.blue200Color()
        let headerLabel = UILabel(frame: CGRect(x:5, y:5, width:300, height:18))
        headerLabel.textColor = UIColor.white
        headerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        headerLabel.text = "Ativar Profissional";
        vw.addSubview(headerLabel)
        
        let switchDemo = UISwitch()
        switchDemo.frame = CGRect(x: 300, y: 30, width: 200, height: 40)
        switchDemo.isOn = true
        switchDemo.setOn(true, animated: false)
        switchDemo.addTarget(self, action: Selector(("switchValueDidChange:")), for: .valueChanged)
        vw.addSubview(switchDemo)
        
        return vw
    }
    
    func switchValueDidChange(sender:UISwitch!)
    {
        if (sender.isOn == true){
            print("on")
        }
        else{
            print("off")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightHeader;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
        let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
        
        imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}

