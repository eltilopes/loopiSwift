//
//  ServicoProfissionalViewController.swift
//  Loopi
//
//  Created by Loopi on 16/08/18.
//  Copyright © 2018 Loopi. All rights reserved.
//



import UIKit
import SwiftyJSON

class ServicoProfissionalViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var selectedRow = -1
    var servicoProfissional = ServicoProfissional()
    var itemServico = ItemServico()
    var indexSet = IndexSet(integer: 0)
    
    var x : CGFloat = 0
    var y : CGFloat = 0
    var width : CGFloat = 0
    var height : CGFloat = 0
    var heightServicos : CGFloat = 0
    
    @IBOutlet var collectionViewItens: UICollectionView!
    @IBOutlet var labelAdicionarItem: UILabel!
    @IBOutlet var labelNomeServico: UILabel!
    @IBOutlet var labelDescricaoServico: UILabel!
    @IBOutlet var buttonVoltar: UIButton!
    @IBOutlet var buttonAdicionarItem: UIButton!
    @IBOutlet var servicoView: UIView!
    
    var itemServicoAlertController : ItemServicoAlertController!
    
    let collectionViewItemIdentifier = "ItemServicoViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButtonImage = UIImage(named: "ic_arrow_left_white")?.withRenderingMode(.alwaysTemplate)
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .white
        backButton.setTitle("Voltar", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(sender:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.view.backgroundColor = GMColor.backgroundAppColor()
        self.collectionViewItens.delegate = self
        self.collectionViewItens.dataSource = self
        self.collectionViewItens.reloadData()
        self.collectionViewItens.backgroundColor = GMColor.backgroundAppColor()
        
        self.collectionViewItens.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        self.buttonVoltar.backgroundColor = GMColor.colorPrimary()
        self.buttonVoltar.tintColor = GMColor.whiteColor()
        self.buttonVoltar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.buttonVoltar.addTarget(self, action: #selector(voltarAoServico), for: .touchUpInside)
        
        self.buttonAdicionarItem.backgroundColor = GMColor.buttonBlueColor()
        self.buttonAdicionarItem.tintColor = GMColor.whiteColor()
        self.buttonAdicionarItem.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.buttonAdicionarItem.addTarget(self, action: #selector(tappedAddItem), for: .touchUpInside)
        
        self.servicoView.backgroundColor = GMColor.whiteColor()
        self.labelNomeServico.textColor = GMColor.textColorPrimary()
        self.labelNomeServico.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        self.labelNomeServico.text = servicoProfissional.nome
        
        self.labelDescricaoServico.textColor = GMColor.textColorPrimary()
        self.labelDescricaoServico.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        self.labelDescricaoServico.text = servicoProfissional.descricao
    }
    
    @objc func voltarAoServico() {
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        // custom actions here
        navigationController?.popViewController(animated: true)
    }
    
    @objc func voltar(sender: UIBarButtonItem) {
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfissionalCard")
        
        self.navigationController!.pushViewController(destViewController, animated: true)
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return servicoProfissional.itens.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionViewItens.frame.size.width  , height: self.collectionViewItens.frame.size.height  )
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cellItem = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewItemIdentifier, for: indexPath as IndexPath) as! ItemServicoViewCell
        let item = self.servicoProfissional.itens[indexPath.item]
            cellItem.backgroundColor = GMColor.whiteColor()
            cellItem.itemNome.text = item.nome
            cellItem.itemNome.tintColor = GMColor.textColorPrimary()
            cellItem.itemNome.textColor = GMColor.textColorPrimary()
            cellItem.itemDescricao.text = item.descricao
            cellItem.itemDescricao.textColor = GMColor.textColorPrimary()
            cellItem.itemDescricao.tintColor = GMColor.textColorPrimary()
            cellItem.itemValor.text = String(format: "R$ %.2f", (item.valor?.magnitude ?? 0))
            cellItem.itemValor.textColor = GMColor.colorPrimary()
            cellItem.itemValor.tintColor = GMColor.colorPrimary()
            
            return cellItem
        
        
    }
    
    
    @objc func onSalvarItemButtonPressed( ){
        didTappedOnButtonSalvar()
        
    }
    
    @objc func didTappedOnButtonSalvar(){
        self.servicoProfissional.itens.append(self.itemServico)
        self.collectionViewItens.reloadData()
    }
    
    @objc func tappedAddItem(){
        self.itemServico = ItemServico()
        itemServicoAlertController = ItemServicoAlertController(itemServico: self.itemServico, servicoProfissionalViewController: self )
        itemServicoAlertController.show(animated: true)
        
    }
 
}




