//
//  CardsServiceController.swift
//  Loopi
//
//  Created by Loopi on 07/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Firebase
import FirebaseStorage


class CardsServiceController: BaseViewController, UICollectionViewDataSource,UICollectionViewDelegate{
    
   
    var selectedRow = -1
    var servicoCard = ServicoCard()
    var servicoCards: [ServicoCard] = []
    var servicoCardsCount = 0
    let servicoCardRest = ServicoCardRest()
    let categoriaRest = CategoriaRest()
    var lastPositionScroll: CGFloat = 0
    var categorias: [Categoria] = []
    var categoriasCount = 0
    var storageRef: StorageReference!
    
    var filtro : Filtro = Filtro()
    
    @IBOutlet var collectionViewServicosCard: UICollectionView!
    @IBOutlet var collectionViewCategorias: UICollectionView!
    let collectionViewServicosCardIdentifier = "CardCell"
    let collectionViewCategoriasIdentifier = "CategoriaCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storageRef = Storage.storage().reference()
        addHeaderButtons()
        addFooterLocation()
        showFooterLocation()
        carregarCategorias()
        carregarCardsServicos(filtro: filtro)
        collectionViewCategorias.backgroundColor = GMColor.backgroundAppColor()
        collectionViewServicosCard.backgroundColor = GMColor.backgroundAppColor()
        collectionViewCategorias.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        collectionViewCategorias.layer.borderColor = GMColor.backgroundAppColor().cgColor
        collectionViewCategorias.layer.borderWidth = CGFloat(ConstraintsView.widthBorderLoopiTextField())
    }
    
    func carregarCategorias() {
        
        categoriaRest.carregarCategorias(){ categorias, error in
            let activityProgressLoopi = ActivityProgressLoopi()
            let indicator = activityProgressLoopi.startActivity(obj: self)
            if error == nil {
                self.categorias = categorias!
                self.categoriasCount = self.categorias.count
                self.collectionViewCategorias.delegate = self
                self.collectionViewCategorias.dataSource = self
                self.collectionViewCategorias.reloadData()
            }else{
                self.showToast(message: (error?.localizedDescription)!)
            }
            ActivityProgressLoopi().stopActivity(obj: self,indicator: indicator)
        }
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
        let firebaseStorageRest = FirebaseStorageRest(storage: Storage.storage())
        if collectionView == self.collectionViewCategorias {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCategoriasIdentifier, for: indexPath as IndexPath) as! CategoriaViewCell
            // let margin: CGFloat = 15
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            let categoria = self.categorias[indexPath.item]
            cell.descricao.text = categoria.descricao
            cell.descricao.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
            cell.descricao.textColor = GMColor.whiteColor()
            cell.descricao.tintColor = GMColor.whiteColor()
            cell.backgroundColor = GMColor.whiteColor()
            var image: UIImage?
            firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.PNG,urlImage: categoria.urlImagem!) { (imageIcon, error) in
                if error == nil {
                    image = imageIcon
                    cell.imageView.image = image
                    cell.imageView.contentMode = .scaleToFill;
                }else{
                    self.showToast(message: (error?.localizedDescription)!)
                }
            }
            return cell
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewServicosCardIdentifier, for: indexPath as IndexPath) as! CardServicoViewCell
            // let margin: CGFloat = 15
            
            firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_thumb_up_white_24px.svg?alt=media&token=388dc9ea-7fbf-4e9e-b3a0-ceeefb0fff8b") { (imageIcon, error) in
                if error == nil {
                    cell.cardLike.image = imageIcon
                    cell.cardLike.image = cell.cardLike.image!.withRenderingMode(.alwaysTemplate)
                    cell.cardLike.tintColor = GMColor.colorPrimary()
                    cell.cardLike.contentMode = .center;
                }else{
                    self.showToast(message: (error?.localizedDescription)!)
                }
            }
            firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_star_white_24px.svg?alt=media&token=3759e51e-f225-4b33-8eb6-7ba589dd2cd2") { (imageIcon, error) in
                if error == nil {
                    cell.cardStar1.image = imageIcon
                    cell.cardStar1.image = cell.cardStar1.image!.withRenderingMode(.alwaysTemplate)
                    cell.cardStar1.tintColor = GMColor.colorPrimary()
                    cell.cardStar1.contentMode = .center;
                }else{
                    self.showToast(message: (error?.localizedDescription)!)
                }
            }
            firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_star_white_24px.svg?alt=media&token=3759e51e-f225-4b33-8eb6-7ba589dd2cd2") { (imageIcon, error) in
                if error == nil {
                    cell.cardStar2.image = imageIcon
                    cell.cardStar2.image = cell.cardStar2.image!.withRenderingMode(.alwaysTemplate)
                    cell.cardStar2.tintColor = GMColor.colorPrimary()
                    cell.cardStar2.contentMode = .center;
                }else{
                    self.showToast(message: (error?.localizedDescription)!)
                }
            }
            firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_star_white_24px.svg?alt=media&token=3759e51e-f225-4b33-8eb6-7ba589dd2cd2") { (imageIcon, error) in
                if error == nil {
                    cell.cardStar3.image = imageIcon
                    cell.cardStar3.image = cell.cardStar3.image!.withRenderingMode(.alwaysTemplate)
                    cell.cardStar3.tintColor = GMColor.colorPrimary()
                    cell.cardStar3.contentMode = .center;
                }else{
                    self.showToast(message: (error?.localizedDescription)!)
                }
            }
            firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_star_half_white_24px.svg?alt=media&token=03d63f57-ce0c-491f-a279-89e5824c4f0a") { (imageIcon, error) in
                if error == nil {
                    cell.cardStar4.image = imageIcon
                    cell.cardStar4.image = cell.cardStar4.image!.withRenderingMode(.alwaysTemplate)
                    cell.cardStar4.tintColor = GMColor.colorPrimary()
                    cell.cardStar4.contentMode = .center;
                }else{
                    self.showToast(message: (error?.localizedDescription)!)
                }
            }
            firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_star_border_white_24px.svg?alt=media&token=6b8f4766-f37a-447a-acc5-3512f1380faf") { (imageIcon, error) in
                if error == nil {
                    cell.cardStar5.image = imageIcon
                    cell.cardStar5.image = cell.cardStar5.image!.withRenderingMode(.alwaysTemplate)
                    cell.cardStar5.tintColor = GMColor.colorPrimary()
                    cell.cardStar5.contentMode = .center;
                }else{
                    self.showToast(message: (error?.localizedDescription)!)
                }
            }
            cell.cardLikeQuantidade.text = "3"
            cell.cardLikeQuantidade.textColor = GMColor.colorPrimary()
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            let cardServico = self.servicoCards[indexPath.item]
            cell.myLabel.text = cardServico.title
            cell.cardCategoria.text = cardServico.categoria.descricao
            cell.cardCategoria.textColor = GMColor.colorPrimary()
            cell.cardEspecialidade.text = cardServico.especialidade.descricao
            cell.cardTempo.text = cardServico.duracao
            cell.cardDistancia.text = cardServico.distancia
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
        if (self.lastPositionScroll > scrollView.contentOffset.y) {
            hiddenFooterLocation()	
        }
        else if (self.lastPositionScroll < scrollView.contentOffset.y) {
            showFooterLocation()
        }
        self.lastPositionScroll = scrollView.contentOffset.y
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // get a reference to the second view controller
        if segue.identifier == "openMapsSegue" {
           //  let mapViewController  = segue.destination as! MapViewController
        }else if segue.identifier == "locationSegue" {
            _  = segue.destination as! LocationViewController
        }else{
            let cardServicoVC  = segue.destination as! CardViewController
            
            // set a variable in the second view controller with the data to pass
             cardServicoVC.servicoCard = servicoCard
        }
    }

}


