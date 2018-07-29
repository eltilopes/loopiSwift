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
    let switchDemo = UISwitch()
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
        arrayMenuOptions.append(["title":"Extrato/Saque", "icon":"ic_extrato"])
        arrayMenuOptions.append(["title":"Meus Pedidos", "icon":"ic_meus_pedidos"])
        arrayMenuOptions.append(["title":"Profissional", "icon":"ic_profissional"])
        arrayMenuOptions.append(["title":"Convites", "icon":"ic_convite"])
        arrayMenuOptions.append(["title":"Termos", "icon":"ic_termos"])
        arrayMenuOptions.append(["title":"Sair", "icon":"ic_sair"])
        tblMenuOptions.separatorStyle = .none
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
        let heightTableView = tableView.frame.size.height / 4
        let heightImageView = tableView.frame.size.height / 6 - 10
        vw.backgroundColor = GMColor.colorPrimary()
        let headerImage = UIImage(named: "perfil")
        let headerImageView = UIImageView(image: headerImage)
        headerImageView.frame = CGRect(x:10, y:10, width:heightImageView, height:heightImageView)
        headerImageView.contentMode = .scaleAspectFit
        headerImageView.layer.borderWidth = 1
        headerImageView.layer.masksToBounds = false
        headerImageView.layer.borderColor = GMColor.colorPrimaryDark().cgColor
        headerImageView.layer.cornerRadius = headerImageView.frame.height/2
        headerImageView.clipsToBounds = true
        vw.addSubview(headerImageView)
        
        var attrString = NSMutableAttributedString()
        let stringValor = "R$ 50,00"
        let stringCashBack = "Cash Back"
        
        attrString += (NSMutableAttributedString(string : stringValor, font: UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig()), maxWidth: 100)! + "\n" )
        attrString += (NSMutableAttributedString(string : stringCashBack , font: UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium()), maxWidth: 100)!  + "\n" )
        attrString.addAttribute(NSAttributedStringKey.foregroundColor, value: GMColor.whiteColor(), range: NSMakeRange(0, (stringValor.count )))
        
        let headerCashBack = UILabel(frame: CGRect(x: 2 * tableView.frame.size.width / 3 , y:10, width:tableView.frame.size.width / 3, height:heightImageView ))
        headerCashBack.textColor = GMColor.blackColor()
        headerCashBack.attributedText = attrString
        headerCashBack.lineBreakMode = .byWordWrapping
        headerCashBack.layer.masksToBounds = true
        headerCashBack.numberOfLines = 2
        vw.addSubview(headerCashBack)
        
        let headerLabel = UILabel(frame: CGRect(x:10, y:heightTableView - ConstraintsView.fontBig() , width:heightImageView + 10, height:ConstraintsView.fontBig()))
        headerLabel.textColor = UIColor.white
        headerLabel.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        headerLabel.text = "Usuario";
        vw.addSubview(headerLabel)
        
        let editarUsuarioImage = UIImage(named: "ic_editar")
        let editarUsuarioImageView = UIImageView(image: editarUsuarioImage)
        editarUsuarioImageView.frame = CGRect(x:tableView.frame.size.width - 2 * ConstraintsView.fontBig() , y:heightTableView - ConstraintsView.fontBig() , width: ConstraintsView.fontBig() , height:ConstraintsView.fontBig())
        editarUsuarioImageView.contentMode = .scaleAspectFill
        vw.addSubview(editarUsuarioImageView)
        return vw
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = GMColor.colorPrimary()
        let headerLabel = UILabel(frame: CGRect(x:10, y:0, width:tableView.frame.size.width, height:ConstraintsView.fontBig() ))
        headerLabel.textColor = UIColor.white
        headerLabel.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        headerLabel.text = "Ativar Profissional";
        vw.addSubview(headerLabel)
        
        
        switchDemo.frame = CGRect(x: 300, y: 30, width: 200, height: 40)
        switchDemo.isOn = true
        switchDemo.setOn(true, animated: false)
        switchDemo.tintColor = GMColor.colorAccent()
        switchDemo.onTintColor = GMColor.colorPrimaryDark()
        switchDemo.thumbTintColor = GMColor.backgroundAppColor()
        switchDemo.addTarget(self, action: Selector(("switchValueDidChange:")), for: .valueChanged)
        vw.addSubview(switchDemo)
        
        return vw
    }
    
    func switchValueDidChange(sender:UISwitch!)
    {
        if (sender.isOn == true){
            print("on")
            switchDemo.setOn(true, animated: true)
        }
        else{
            print("off")
            switchDemo.setOn(false, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        heightHeader = tableView.frame.size.height / 4
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
        lblTitle.textColor = GMColor.textColorPrimary()
        lblTitle.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        imgIcon.contentMode = .scaleAspectFit
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

