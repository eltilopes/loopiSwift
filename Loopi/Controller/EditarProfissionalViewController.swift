//
//  EditarProfissionalViewController.swift
//  Loopi
//
//  Created by Loopi on 13/06/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Firebase
import FirebaseStorage

class EditarProfissionalViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var selectedRow = -1
    var servicoCard = ServicoCard()
    var servicoCards: [ServicoCard] = []
    var storageRefCard: StorageReference!
    var indexSet = IndexSet(integer: 0)
    let servicoCardRest = ServicoCardRest()
    var servicoCardsCount = 0
    var filtro : Filtro = Filtro()
    
    @IBOutlet var collectionViewServicoCard: UICollectionView!
    @IBOutlet var buttonResgatar: UIButton!
    @IBOutlet var buttonExtrato: UIButton!
    @IBOutlet var labelEditarProfissional : UILabel!
    @IBOutlet var labelEditarAnuncios : UILabel!
    
    let collectionViewServicosCardIdentifier = "CardServicoAnuncioViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storageRefCard = Storage.storage().reference()
        carregarCardsServicos(filtro: filtro)
        addButtons()
        self.view.backgroundColor = GMColor.backgroundAppColor()
        self.labelEditarProfissional.backgroundColor = GMColor.backgroundAppColor()
        self.labelEditarProfissional.textColor = GMColor.textColorPrimary()
        self.labelEditarProfissional.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        self.labelEditarAnuncios.backgroundColor = GMColor.colorPrimary()
        self.labelEditarAnuncios.textColor = GMColor.whiteColor()
        self.labelEditarAnuncios.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        self.labelEditarAnuncios.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.labelEditarAnuncios.layer.masksToBounds = true
        
    }
    
    func addButtons() {
        
        buttonResgatar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonResgatar.layer.masksToBounds = true
        buttonResgatar.tintColor = GMColor.whiteColor()
        buttonResgatar.titleLabel!.textAlignment = .center
        buttonResgatar.titleLabel?.lineBreakMode = .byWordWrapping
        buttonResgatar.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonResgatar.backgroundColor = GMColor.buttonBlueColor()
        
        buttonExtrato.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonExtrato.layer.masksToBounds = true
        buttonExtrato.tintColor = GMColor.whiteColor()
        buttonExtrato.titleLabel!.textAlignment = .center
        buttonExtrato.titleLabel?.lineBreakMode = .byWordWrapping
        buttonExtrato.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonExtrato.backgroundColor = GMColor.buttonBlueColor()
        
    }
    
    func carregarCardsServicos(filtro: Filtro) {
        
        servicoCardRest.carregarCardsServicos(filtro: filtro){ servicos, error in
            let activityProgressLoopi = ActivityProgressLoopi()
            let indicator = activityProgressLoopi.startActivity(controller: self)
            if error == nil {
                self.servicoCards = servicos!
                self.collectionViewServicoCard.backgroundColor = GMColor.backgroundAppColor()
                self.servicoCardsCount = self.servicoCards.count
                self.collectionViewServicoCard.delegate = self
                self.collectionViewServicoCard.dataSource = self
                self.collectionViewServicoCard.reloadData()
            }else{
                self.showToast(message: (error?.localizedDescription)!)
            }
            ActivityProgressLoopi().stopActivity(controller: self,indicator: indicator)
        }
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return servicoCardsCount
    }
    
   
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let firebaseStorageRest = FirebaseStorageRest(storage: Storage.storage())
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewServicosCardIdentifier, for: indexPath as IndexPath) as! CardServicoAnuncioViewCell
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



