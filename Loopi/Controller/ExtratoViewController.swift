//
//  ExtratoViewController.swift
//  Loopi
//
//  Created by Loopi on 16/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//
import UIKit

class ExtratoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let heightHeader : CGFloat = 60.0
    let margin: CGFloat = 5
    @IBOutlet var tblExtrato : UITableView!
    @IBOutlet var labelExtratoCashBack : UILabel!
    @IBOutlet var buttonSaque: UIButton!
    var movimentacoes: [Movimentacao] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMovimentacoes()
        addButtonSaque()
        self.labelExtratoCashBack.backgroundColor = GMColor.backgroundAppColor()
        self.labelExtratoCashBack.textColor = GMColor.textColorPrimary()
        self.labelExtratoCashBack.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.view.backgroundColor = GMColor.backgroundAppColor()
        self.tblExtrato.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.tblExtrato.layer.masksToBounds = true
        self.tblExtrato.delegate = self
        self.tblExtrato.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addButtonSaque() {
        
        buttonSaque.titleLabel?.lineBreakMode=NSLineBreakMode.byWordWrapping
        var attrString = NSMutableAttributedString()
        let stringSaldo = "Saldo"
        let stringValor = "R$ 112,50"
        let stringSaque = "Saque"
        
        attrString += (NSMutableAttributedString(string : stringSaldo, font: UIFont.systemFont(ofSize: 15), maxWidth: 100)! + "\n" )
        attrString += (NSMutableAttributedString(string : stringValor , font: UIFont.systemFont(ofSize: 20), maxWidth: 100)!  + "\n" )
        attrString += (NSMutableAttributedString(string : stringSaque, font: UIFont.systemFont(ofSize: 15), maxWidth: 100)! + "\n" )
        attrString.addAttribute(NSAttributedStringKey.foregroundColor, value: GMColor.whiteColor(), range: NSMakeRange(0, (stringSaldo.count + stringValor.count)))
        buttonSaque.setAttributedTitle(attrString, for: .normal)
        buttonSaque.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonSaque.layer.masksToBounds = true
        buttonSaque.tintColor = GMColor.colorPrimary()
        buttonSaque.titleLabel?.numberOfLines = 3
        buttonSaque.titleLabel!.textAlignment = .center
        buttonSaque.titleLabel?.lineBreakMode = .byWordWrapping
        buttonSaque.setTitleColor(GMColor.colorPrimary(), for: .normal)
        buttonSaque.translatesAutoresizingMaskIntoConstraints = false
        buttonSaque.backgroundColor = GMColor.buttonBlueColor()
        
    }
    
    
    func updateMovimentacoes(){
        let currentDateTime = Date()
        movimentacoes.append(Movimentacao( data : currentDateTime ,historico : "Medico",valor : -100))
        movimentacoes.append(Movimentacao( data : currentDateTime ,historico : "Manicure",valor : -50))
        movimentacoes.append(Movimentacao( data : currentDateTime ,historico : "Cash Back Friend",valor : 10))
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "extratoTableViewCell") as! ExtratoTableViewCell
        cell.data.text = "Dia"
        cell.data.textColor = GMColor.colorPrimary()
        cell.data.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.historico.text = "Servico"
        cell.historico.textColor = GMColor.colorPrimary()
        cell.historico.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.valor.text = "Valor em R$"
        cell.valor.textColor = GMColor.colorPrimary()
        cell.valor.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.layer.backgroundColor = GMColor.whiteColor().cgColor
        cell.layoutMargins = UIEdgeInsets(top: margin, left: margin,
                                          bottom: margin, right: margin)
       
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightHeader;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "extratoTableViewCell", for: indexPath as IndexPath) as! ExtratoTableViewCell

        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        let movimentacao = self.movimentacoes[indexPath.item]
        cell.data.text = movimentacao.dataFormatada()
        cell.data.textColor = GMColor.textColorPrimary()
        cell.historico.text = movimentacao.historico
        cell.historico.textColor = GMColor.textColorPrimary()
        cell.valor.text = "\(movimentacao.valor.magnitude ?? 0)"
        if movimentacao.valor < 0 {
            cell.valor.textColor = GMColor.textColorRed()
        }else {
            cell.valor.textColor = GMColor.textColorBlue()
        }
        cell.layoutMargins = UIEdgeInsets(top: margin, left: margin,
                                          bottom: margin, right: margin)
        return cell
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movimentacoes.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "solicitarSaqueSegue" {
            //  let mapViewController  = segue.destination as! MapViewController
        }
    }
    
    
}

extension NSMutableAttributedString {
    /**Makes an attributes string with the specified (plain) string and font but resizes the font smaller
     to fit the width if required. Can return nil, if there is no way to make it fit*/
    convenience init?(string : String, font : UIFont, maxWidth : CGFloat){
        self.init()
        
        
        for var size in stride(from: font.pointSize, to: 1, by: -1){
            let attrs = [NSAttributedStringKey.font : font.withSize(size)]
            let attrString = NSAttributedString(string: string, attributes: attrs)
            if attrString.size().width <= maxWidth {
                self.setAttributedString(attrString)
                return
            }
        }
        return nil
    }
}

//************************

public func += ( left: inout NSMutableAttributedString, right: NSAttributedString) {
    left.append(right)
}

public func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    var result  = NSMutableAttributedString(attributedString: right)
    result.append(right)
    return result
}

public func + (left: NSAttributedString, right: String) -> NSAttributedString {
    var result  = NSMutableAttributedString(attributedString: left)
    result.append(NSAttributedString(string: right))
    return result
}

