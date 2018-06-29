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


class CardsServiceController: BaseViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
   
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
        view.backgroundColor = GMColor.backgroundAppColor()
        storageRef = Storage.storage().reference()
        addHeaderButtons()
        addFooterLocation()
        showFooterLocation()
        carregarCategorias()
        carregarCardsServicos(filtro: filtro)
        collectionViewServicosCard.backgroundColor = GMColor.backgroundAppColor()
        collectionViewCategorias.backgroundColor = GMColor.backgroundAppColor()
        collectionViewServicosCard.showsVerticalScrollIndicator = true
        collectionViewServicosCard.showsHorizontalScrollIndicator = false
        collectionViewCategorias.showsVerticalScrollIndicator = false
        collectionViewCategorias.showsHorizontalScrollIndicator = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        carregarCategorias()
        carregarCardsServicos(filtro: filtro)
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
    
    @objc func onPesquisarButtonPressed(_ sender : UIButton){
        let alert = FiltroController()
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.collectionViewCategorias {
            return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        }
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionViewCategorias {
            return CGSize(width: self.view.frame.size.width / 2.5, height: self.view.frame.size.height * 0.5)
        }
        return CGSize(width: self.view.frame.size.width  , height: self.view.frame.size.height / 4.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
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
                    cell.imageView.contentMode = .scaleAspectFill;
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
            cell.backgroundColor = UIColor.white
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
            //colocar regra para abrir a lista de especialidades
            filtro.categoria = self.categorias[indexPath.item]
            carregarCardsServicos(filtro: filtro)
        }else {
            self.servicoCard = self.servicoCards[indexPath.item]
            //openViewControllerBasedOnIdentifier("CardViewController")
            self.performSegue(withIdentifier: "cardServicoSegue", sender: self.servicoCard)
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
        }else if segue.identifier == "cardServicoSegue" {
            let cardViewController = segue.destination as! CardViewController
            cardViewController.servicoCard = self.servicoCard
        }
    }

}
