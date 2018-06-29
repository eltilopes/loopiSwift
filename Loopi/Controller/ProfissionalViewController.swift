//
//  ProfissionalViewController.swift
//  Loopi
//
//  Created by Loopi on 12/04/18.
//  Copyright © 2018 Loopi. All rights reserved.
//
import UIKit

class ProfissionalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   
    @IBOutlet var buttonNovoServico: UIButton!
    @IBOutlet var buttonEditarAnuncio: UIButton!
    
    let heightHeader : CGFloat = 60.0
    let margin: CGFloat = 5
    @IBOutlet var tblSolicitacoes : UITableView!
    @IBOutlet var labelProfissional : UILabel!
    @IBOutlet var labelUltimasSolicitacoes : UILabel!
    
    var solicitacoes: [Solicitacao] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSolicitacoes()
        addButtons()
        self.view.backgroundColor = GMColor.backgroundAppColor()
        self.labelProfissional.backgroundColor = GMColor.backgroundAppColor()
        self.labelProfissional.textColor = GMColor.textColorPrimary()
        self.labelProfissional.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        self.labelUltimasSolicitacoes.backgroundColor = GMColor.colorPrimary()
        self.labelUltimasSolicitacoes.textColor = GMColor.whiteColor()
        self.labelUltimasSolicitacoes.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        self.labelUltimasSolicitacoes.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.labelUltimasSolicitacoes.layer.masksToBounds = true
        self.tblSolicitacoes.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.tblSolicitacoes.layer.masksToBounds = true
        self.tblSolicitacoes.delegate = self
        self.tblSolicitacoes.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addButtons() {
        
        buttonNovoServico.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonNovoServico.layer.masksToBounds = true
        buttonNovoServico.tintColor = GMColor.whiteColor()
        buttonNovoServico.titleLabel!.textAlignment = .center
        buttonNovoServico.titleLabel?.lineBreakMode = .byWordWrapping
        buttonNovoServico.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonNovoServico.backgroundColor = GMColor.buttonBlueColor()
        
        buttonEditarAnuncio.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonEditarAnuncio.layer.masksToBounds = true
        buttonEditarAnuncio.tintColor = GMColor.whiteColor()
        buttonEditarAnuncio.titleLabel!.textAlignment = .center
        buttonEditarAnuncio.titleLabel?.lineBreakMode = .byWordWrapping
        buttonEditarAnuncio.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonEditarAnuncio.backgroundColor = GMColor.buttonBlueColor()
        
    }
    
    
    func updateSolicitacoes(){
        let currentDateTime = Date()
        solicitacoes.append(Solicitacao(numero: "2457", cliente: "Rodger", data: currentDateTime, status: SolicitacaoStatusType.EM_ABERTO))
        solicitacoes.append(Solicitacao(numero: "3236", cliente: "Renan", data: currentDateTime, status: SolicitacaoStatusType.CONCLUIDO))
        solicitacoes.append(Solicitacao(numero: "2123", cliente: "Elton", data: currentDateTime, status: SolicitacaoStatusType.CANCELADO))
        solicitacoes.append(Solicitacao(numero: "6698", cliente: "Andreas", data: currentDateTime, status: SolicitacaoStatusType.CONCLUIDO))
        solicitacoes.append(Solicitacao(numero: "8547", cliente: "Maria", data: currentDateTime, status: SolicitacaoStatusType.CONCLUIDO))
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "solicitacaoTableViewCell") as! SolicitacaoTableViewCell
        cell.data.text = "Dia"
        cell.data.textColor = GMColor.colorPrimary()
        cell.data.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.cliente.text = "Cliente"
        cell.cliente.textColor = GMColor.colorPrimary()
        cell.cliente.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.numero.text = "Num."
        cell.numero.textColor = GMColor.colorPrimary()
        cell.numero.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.status.text = "Status"
        cell.status.textColor = GMColor.colorPrimary()
        cell.status.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.layer.backgroundColor = GMColor.whiteColor().cgColor
        cell.layoutMargins = UIEdgeInsets(top: margin, left: margin,
                                          bottom: margin, right: margin)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightHeader;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "solicitacaoTableViewCell", for: indexPath as IndexPath) as! SolicitacaoTableViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        let solicitacao = self.solicitacoes[indexPath.item]
        cell.data.text = solicitacao.dataFormatada()
        cell.data.textColor = GMColor.textColorPrimary()
        cell.numero.text = solicitacao.numero
        cell.numero.textColor = GMColor.textColorPrimary()
        cell.cliente.text = solicitacao.cliente
        cell.cliente.textColor = GMColor.textColorPrimary()
        cell.status.text = solicitacao.status.descricao
        cell.status.textColor = solicitacao.status.cor
        cell.layoutMargins = UIEdgeInsets(top: margin, left: margin,
                                          bottom: margin, right: margin)
        cell.frame = CGRect(x:5 , y:0, width: tableView.frame.size.width , height:heightHeader)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return solicitacoes.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "novoProfissionalSegue" {
            //  let mapViewController  = segue.destination as! MapViewController
        }
    }
    
    
}



