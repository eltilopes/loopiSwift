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
    @IBOutlet var buttonSaque: UIButton!
    var movimentacoes: [Movimentacao] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMovimentacoes()
        self.tblExtrato.delegate = self
        self.tblExtrato.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func updateMovimentacoes(){
        let currentDateTime = Date()
        movimentacoes.append(Movimentacao( data : currentDateTime ,historico : "Medico",valor : -100))
        movimentacoes.append(Movimentacao( data : currentDateTime ,historico : "Manicure",valor : -50))
        movimentacoes.append(Movimentacao( data : currentDateTime ,historico : "Cash Back Friend",valor : 10))
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "extratoTableViewCell") as! ExtratoTableViewCell
        cell.data.text = "Data"
        cell.data.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.historico.text = "Historico"
        cell.historico.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.valor.text = "Valor"
        cell.valor.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.layer.backgroundColor = GMColor.blue50Color().cgColor
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
        cell.historico.text = movimentacao.historico
        cell.valor.text = "\(movimentacao.valor ?? 0)"
        if movimentacao.valor < 0 {
            cell.valor.textColor = GMColor.red200Color()
        }else {
            cell.valor.textColor = GMColor.green200Color()
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


