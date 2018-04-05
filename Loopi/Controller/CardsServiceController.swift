//
//  CardsServiceController.swift
//  Loopi
//
//  Created by Loopi on 07/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import SwiftyJSON


class CardsServiceController: BaseViewController, UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    var selectedRow = -1
    var servicoCard = ServicoCard()
    var servicoCards: [ServicoCard] = []
    var servicoCardsCount = 0
    let servicoCardRest = ServicoCardRest()
    
    var categorias: [Categoria] = []
    var categoriasCount = 0
    let categoriaRest = CategoriaRest()
    
    var filtro : Filtro = Filtro()
    
    @IBOutlet var collectionViewServicosCard: UICollectionView!
    @IBOutlet var collectionViewCategorias: UICollectionView!
    let collectionViewServicosCardIdentifier = "CardCell"
    let collectionViewCategoriasIdentifier = "CategoriaCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHeaderButtons()
        addFooterLocation()
        showFooterLocation()
        carregarCategorias()
        carregarCardsServicos(filtro: filtro)
    }
    
    func carregarCategorias() {
        let c1 = Categoria()
        c1.descricao = "Saude"
        c1.id = 1
        let c2 = Categoria()
        c2.descricao = "Alimentacao"
        c2.id = 2
        let c3 = Categoria()
        c3.descricao = "Pet"
        c3.id = 3
        self.categorias.append(c1)
        self.categorias.append(c2)
        self.categorias.append(c3)
        self.categoriasCount = self.categorias.count
        self.collectionViewCategorias.delegate = self
        self.collectionViewCategorias.dataSource = self
        self.collectionViewCategorias.reloadData()
    }
    
    func carregarCardsServicos(filtro: Filtro) {
        
        servicoCardRest.carregarCardsServicos(filtro: filtro){ servicos, error in
            let activityProgressLoopi = ActivityProgressLoopi()
            let indicator = activityProgressLoopi.startActivity(obj: self)
            if error == nil {
                self.servicoCards = servicos!
                self.servicoCardsCount = self.servicoCards.count
                self.collectionViewServicosCard.delegate = self
                self.collectionViewServicosCard.dataSource = self
                self.collectionViewServicosCard.reloadData()
            }else{
                self.showToast(message: (error?.localizedDescription)!)
            }
            ActivityProgressLoopi().stopActivity(obj: self,indicator: indicator)
        }
    }
    
    @objc func onFiltroButtonPressed(_ sender : UIButton){
        let alert = FiltroAlertController(filtro: self.filtro )
        alert.show(animated: true)
        
    }
        
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewCategorias {
            return categoriasCount
        }else {
            return servicoCardsCount
        }
        
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewCategorias {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCategoriasIdentifier, for: indexPath as IndexPath) as! CategoriaViewCell
            // let margin: CGFloat = 15
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            let categoria = self.categorias[indexPath.item]
            cell.descricao.text = categoria.descricao
            cell.backgroundColor = UIColor.white // make cell more visible in our example project
            cell.imageView.backgroundColor = GMColor.backgroundAppColor()
            let imageURL = URL(string: "encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3O_DjKwfXWtgCIQjJxzHzMhw5T1haqpjjnzkwDZJL582E-OUO")
            var image: UIImage?
            if let url = imageURL {
                //All network operations has to run on different thread(not on main thread).
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData = NSData(contentsOf: url)
                    //All UI operations has to run on main thread.
                    DispatchQueue.main.async {
                        if imageData != nil {
                            image = UIImage(data: imageData! as Data)
                            cell.imageView.image = image
                            cell.imageView.contentMode = .scaleAspectFill;
                        } else {
                            image = nil
                        }
                    }
                }
            }
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewServicosCardIdentifier, for: indexPath as IndexPath) as! CardServicoViewCell
            // let margin: CGFloat = 15
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            let cardServico = self.servicoCards[indexPath.item]
            cell.myLabel.text = cardServico.title
            cell.cardCategoria.text = cardServico.categoria.descricao
            cell.cardSubCategoria.text = cardServico.subCategoria.descricao
            cell.cardEspecialidade.text = cardServico.especialidade.descricao
            cell.cardTempo.text = cardServico.duracao
            cell.cardDistancia.text = cardServico.latitude
            cell.backgroundColor = UIColor.white // make cell more visible in our example project
            let imageURL = URL(string: cardServico.thumbnail!)
            var image: UIImage?
            if let url = imageURL {
                //All network operations has to run on different thread(not on main thread).
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData = NSData(contentsOf: url)
                    //All UI operations has to run on main thread.
                    DispatchQueue.main.async {
                        if imageData != nil {
                            image = UIImage(data: imageData! as Data)
                            cell.imageView.image = image
                            cell.imageView.contentMode = .scaleAspectFill;
                        } else {
                            image = nil
                        }
                    }
                }
            }
            return cell
        }
        
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showFooterLocation()
        if collectionView == self.collectionViewCategorias {
        }else {
            servicoCard = self.servicoCards[indexPath.item]
            performSegue(withIdentifier: "cardServicoSegue", sender: servicoCard)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        showFooterLocation()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // get a reference to the second view controller
        if segue.identifier == "openMapsSegue" {
           //  let mapViewController  = segue.destination as! MapViewController
        }else{
            let cardServicoVC  = segue.destination as! CardViewController
            
            // set a variable in the second view controller with the data to pass
             cardServicoVC.servicoCard = servicoCard
        }
    }
    
    
    
    
}

