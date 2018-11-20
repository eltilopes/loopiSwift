//
//  CardViewController.swift
//  Loopi
//
//  Created by Loopi on 23/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Firebase
import FirebaseStorage

class CardViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
 
    var selectedRow = -1
    var servicoCard = ServicoCard()
    var servicoCards: [ServicoCard] = []
    var servicos: [ServicoProfissional] = []
    let servicoCardRest = ServicoCardRest()
    var lastPositionScroll: CGFloat = 0
    var storageRefCard: StorageReference!
    var valorServicos = 0.0
    var indexSet = IndexSet(integer: 0)
    var heightCellServico : CGFloat = 400
    
    @IBOutlet var cardScrollView: UIScrollView!
    @IBOutlet var collectionViewServicoCard: UICollectionView!
    @IBOutlet var collectionViewServicos: UICollectionView!
    @IBOutlet var viewLocalizacao: UIView!
    @IBOutlet var labelLocalizacao: UILabel!
    @IBOutlet var labelValorLocalizacao: UILabel!
    @IBOutlet var viewCashBack: UIView!
    @IBOutlet var labelCashBack: UILabel!
    @IBOutlet var labelValorCashBack: UILabel!
    @IBOutlet var textFieldValorCashBack: LoopiTextField!
    @IBOutlet var viewCartaoCredito: UIView!
    @IBOutlet var labelTotalCartaoCredito: UILabel!
    @IBOutlet var labelValorTotalCartaoCredito: UILabel!
    @IBOutlet var labelCashBackGerado: UILabel!
    @IBOutlet var textFieldValorCartaoCredito: LoopiTextField!
    @IBOutlet var buttonConfirmarCard: UIButton!
 
    let collectionViewServicosCardIdentifier = "CardSelecionadoViewCell"
    let collectionViewServicosIdentifier = "ServicoViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GMColor.backgroundAppColor()
        self.cardScrollView.isScrollEnabled = true
        //self.cardScrollView.contentSize = CGSize(width: cardScrollView.contentSize.width, height: 1500)
        self.cardScrollView.backgroundColor = GMColor.backgroundAppColor()
        storageRefCard = Storage.storage().reference()
        self.servicoCards.append(servicoCard)
        self.servicos = servicoCard.servicos!
        self.collectionViewServicoCard.delegate = self
        self.collectionViewServicoCard.dataSource = self
        self.collectionViewServicoCard.reloadData()
        self.collectionViewServicoCard.backgroundColor = GMColor.backgroundAppColor()
        self.collectionViewServicos.delegate = self
        self.collectionViewServicos.dataSource = self
        self.collectionViewServicos.reloadData()
        self.collectionViewServicos.backgroundColor = GMColor.backgroundAppColor()
        
        self.collectionViewServicos.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.collectionViewServicoCard.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        /*
         self.collectionViewServicos.heightAnchor.constraint(equalToConstant: CGFloat(servicos.count) * self.collectionViewServicos.frame.size.height).isActive = true
        */
        self.viewLocalizacao.backgroundColor = GMColor.whiteColor()
        self.viewLocalizacao.translatesAutoresizingMaskIntoConstraints = false
        self.labelLocalizacao.textColor = GMColor.colorPrimary()
        self.labelLocalizacao.text = "Você está aqui:"
        self.labelLocalizacao.font = UIFont.systemFont(ofSize: ConstraintsView.fontSmall())
        self.labelValorLocalizacao.textColor = GMColor.textColorPrimary()
        self.labelValorLocalizacao.text = "Rua Jornalista César Magalhães, 401. Patriolino Ribeiro. 60810-140. Fortaleza - CE - Brasil."
        self.labelValorLocalizacao.font = UIFont.systemFont(ofSize: ConstraintsView.fontSmall())
        
        self.viewCashBack.backgroundColor = GMColor.whiteColor()
        self.labelCashBack.textColor = GMColor.textColorPrimary()
        self.labelCashBack.text = "Seu Saldo CashBack"
        self.labelCashBack.font = UIFont.systemFont(ofSize: ConstraintsView.fontSmall())
        self.labelValorCashBack.textColor = GMColor.colorPrimary()
        self.labelValorCashBack.text = "R$ 121,55"
        self.labelValorCashBack.font = UIFont.systemFont(ofSize: ConstraintsView.fontBig())
        self.textFieldValorCashBack.validations = [.NUMERO]
        self.textFieldValorCashBack.setAlignmentTitle(alignment: .center)
        self.textFieldValorCashBack.setBorderColorLoopiTextField(borderColorLoopiTextField: GMColor.backgroundAppColor().cgColor)
        self.textFieldValorCashBack.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        self.textFieldValorCashBack.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontSmall()))
        self.textFieldValorCashBack.setTitle()
        
        self.viewCartaoCredito.backgroundColor = GMColor.whiteColor()
        self.labelTotalCartaoCredito.textColor = GMColor.textColorPrimary()
        self.labelTotalCartaoCredito.text = "Total"
        self.labelValorTotalCartaoCredito.font = UIFont.systemFont(ofSize: ConstraintsView.fontSmall())
        self.labelValorTotalCartaoCredito.textColor = GMColor.colorPrimary()
        self.labelValorTotalCartaoCredito.text = String(format: "R$ %.2f", (valorServicos.magnitude ))
        self.labelValorTotalCartaoCredito.font = UIFont.systemFont(ofSize: ConstraintsView.fontBig())
        self.labelCashBackGerado.textColor = GMColor.textColorBlue()
        self.labelCashBackGerado.text = "CashBack Gerado - R$ 3,58"
        self.labelCashBackGerado.font = UIFont.systemFont(ofSize: ConstraintsView.fontSmall())
        self.textFieldValorCartaoCredito.validations = [.NUMERO]
        self.textFieldValorCartaoCredito.setAlignmentTitle(alignment: .center)
        self.textFieldValorCartaoCredito.setBorderColorLoopiTextField(borderColorLoopiTextField: GMColor.backgroundAppColor().cgColor)
        self.textFieldValorCartaoCredito.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        self.textFieldValorCartaoCredito.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontSmall()))
        self.textFieldValorCartaoCredito.setTitle()
        self.buttonConfirmarCard.backgroundColor = GMColor.colorPrimary()
        self.buttonConfirmarCard.tintColor = GMColor.whiteColor()
        self.buttonConfirmarCard.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.buttonConfirmarCard.addTarget(self, action: #selector(solicitarServico), for: .touchUpInside)
       
    }

    @objc func solicitarServico() {
        servicoCardRest.solicitarServico(servico: servicoCard ){ solicitado, error in
            let activityProgressLoopi = ActivityProgressLoopi()
            let indicator = activityProgressLoopi.startActivity(controller: self)
            if error == nil {
                self.showToast(message: "Servico solicitado" )
            }else{
                self.showToast(message: (error?.localizedDescription)!)
            }
            ActivityProgressLoopi().stopActivity(controller: self,indicator: indicator)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.cardScrollView.isScrollEnabled = true
        //self.cardScrollView.contentSize = CGSize(width: cardScrollView.contentSize.width, height: 1500)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewServicoCard {
            return 1
        }else{
            return servicos.count
        }
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
        
        
        if collectionView == self.collectionViewServicoCard {
            return CGSize(width: self.view.frame.size.width  , height: self.view.frame.size.height / 4.5)
        }
        return CGSize(width: self.view.frame.size.width  , height: self.view.frame.size.height / 6)
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let firebaseStorageRest = FirebaseStorageRest(storage: Storage.storage())
       if collectionView == self.collectionViewServicoCard {
            let cellSelecionado = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewServicosCardIdentifier, for: indexPath as IndexPath) as! CardServicoSelecionadoViewCell
            // let margin: CGFloat = 15
        
            firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_thumb_up_white_24px.svg?alt=media&token=388dc9ea-7fbf-4e9e-b3a0-ceeefb0fff8b") { (imageIcon, error) in
                if error == nil {
                    cellSelecionado.cardSelecionadoLike.image = imageIcon
                    cellSelecionado.cardSelecionadoLike.image = cellSelecionado.cardSelecionadoLike.image!.withRenderingMode(.alwaysTemplate)
                    cellSelecionado.cardSelecionadoLike.tintColor = GMColor.colorPrimary()
                    cellSelecionado.cardSelecionadoLike.contentMode = .center;
                }else{
                    self.showToast(message: (error?.localizedDescription)!)
                }
            }
            firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_star_white_24px.svg?alt=media&token=3759e51e-f225-4b33-8eb6-7ba589dd2cd2") { (imageIcon, error) in
                if error == nil {
                    cellSelecionado.cardSelecionadoStar1.image = imageIcon
                    cellSelecionado.cardSelecionadoStar1.image = cellSelecionado.cardSelecionadoStar1.image!.withRenderingMode(.alwaysTemplate)
                    cellSelecionado.cardSelecionadoStar1.tintColor = GMColor.colorPrimary()
                    cellSelecionado.cardSelecionadoStar1.contentMode = .center;
                }else{
                    self.showToast(message: (error?.localizedDescription)!)
                }
            }
            firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_star_white_24px.svg?alt=media&token=3759e51e-f225-4b33-8eb6-7ba589dd2cd2") { (imageIcon, error) in
                if error == nil {
                    cellSelecionado.cardSelecionadoStar2.image = imageIcon
                    cellSelecionado.cardSelecionadoStar2.image = cellSelecionado.cardSelecionadoStar2.image!.withRenderingMode(.alwaysTemplate)
                    cellSelecionado.cardSelecionadoStar2.tintColor = GMColor.colorPrimary()
                    cellSelecionado.cardSelecionadoStar2.contentMode = .center;
                }else{
                    self.showToast(message: (error?.localizedDescription)!)
                }
            }
            firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_star_white_24px.svg?alt=media&token=3759e51e-f225-4b33-8eb6-7ba589dd2cd2") { (imageIcon, error) in
                if error == nil {
                    cellSelecionado.cardSelecionadoStar3.image = imageIcon
                    cellSelecionado.cardSelecionadoStar3.image = cellSelecionado.cardSelecionadoStar3.image!.withRenderingMode(.alwaysTemplate)
                    cellSelecionado.cardSelecionadoStar3.tintColor = GMColor.colorPrimary()
                    cellSelecionado.cardSelecionadoStar3.contentMode = .center;
                }else{
                    self.showToast(message: (error?.localizedDescription)!)
                }
            }
            firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_star_half_white_24px.svg?alt=media&token=03d63f57-ce0c-491f-a279-89e5824c4f0a") { (imageIcon, error) in
                if error == nil {
                    cellSelecionado.cardSelecionadoStar4.image = imageIcon
                    cellSelecionado.cardSelecionadoStar4.image = cellSelecionado.cardSelecionadoStar4.image!.withRenderingMode(.alwaysTemplate)
                    cellSelecionado.cardSelecionadoStar4.tintColor = GMColor.colorPrimary()
                    cellSelecionado.cardSelecionadoStar4.contentMode = .center;
                }else{
                    self.showToast(message: (error?.localizedDescription)!)
                }
            }
            firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_star_border_white_24px.svg?alt=media&token=6b8f4766-f37a-447a-acc5-3512f1380faf") { (imageIcon, error) in
                if error == nil {
                    cellSelecionado.cardSelecionadoStar5.image = imageIcon
                    cellSelecionado.cardSelecionadoStar5.image = cellSelecionado.cardSelecionadoStar5.image!.withRenderingMode(.alwaysTemplate)
                    cellSelecionado.cardSelecionadoStar5.tintColor = GMColor.colorPrimary()
                    cellSelecionado.cardSelecionadoStar5.contentMode = .center;
                }else{
                    self.showToast(message: (error?.localizedDescription)!)
                }
            }
            cellSelecionado.cardSelecionadoLikeQuantidade.text = "3"
            cellSelecionado.cardSelecionadoLikeQuantidade.textColor = GMColor.colorPrimary()
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            let cardServico = self.servicoCards[indexPath.item]
            cellSelecionado.cardSelecionadoLabel.text = cardServico.title
            cellSelecionado.cardSelecionadoCategoria.text = cardServico.categoria.descricao
            cellSelecionado.cardSelecionadoCategoria.textColor = GMColor.colorPrimary()
            cellSelecionado.cardSelecionadoEspecialidade.text = cardServico.especialidade.descricao
            cellSelecionado.cardSelecionadoTempo.text = cardServico.duracao
            cellSelecionado.cardSelecionadoDistancia.text = cardServico.distancia
            cellSelecionado.backgroundColor = UIColor.white // make cell more visible in our example project
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
                            cellSelecionado.cardSelecionadoImageView.image = image
                            cellSelecionado.cardSelecionadoImageView.contentMode = .scaleAspectFill;
                        } else {
                            image = nil
                        }
                    }
                }
            }
            return cellSelecionado
       }else{
            let cellServico = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewServicosIdentifier, for: indexPath as IndexPath) as! ServicoViewCell
            let servico = self.servicos[indexPath.item]
            cellServico.backgroundColor = GMColor.whiteColor()
            cellServico.servicoNome.text = servico.nome
            cellServico.servicoNome.tintColor = GMColor.textColorPrimary()
            cellServico.servicoDescricao.text = servico.descricao
            cellServico.servicoDescricao.tintColor = GMColor.textColorPrimary()
            cellServico.servicoValor.text = String(format: "R$ %.2f", (servico.valor?.magnitude ?? 0))
            cellServico.servicoValor.tintColor = GMColor.colorPrimary()
            if servico.selecionado {
                firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_check_box_black_24px.svg?alt=media&token=195a8577-6bf8-46fc-b451-2d23c4cef098") { (imageIcon, error) in
                    if error == nil {
                        cellServico.checkButton.image = imageIcon
                        cellServico.checkButton.image = cellServico.checkButton.image!.withRenderingMode(.alwaysTemplate)
                        cellServico.checkButton.tintColor = GMColor.colorPrimary()
                        cellServico.checkButton.contentMode = .center;
                    }else{
                        self.showToast(message: (error?.localizedDescription)!)
                    }
                }
            }else{
                firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_check_box_outline_blank_black_24px.svg?alt=media&token=c5d92753-f0e8-4adf-9f95-7784477921d6") { (imageIcon, error) in
                    if error == nil {
                        cellServico.checkButton.image = imageIcon
                        cellServico.checkButton.image = cellServico.checkButton.image!.withRenderingMode(.alwaysTemplate)
                        cellServico.checkButton.tintColor = GMColor.textColorPrimary()
                        cellServico.checkButton.contentMode = .center;
                    }else{
                        self.showToast(message: (error?.localizedDescription)!)
                    }
                }
            }
            return cellServico
        }
        
    }
   
    /*
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            print(indexPath)
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderServicos", for: indexPath) as! HeaderCollectionViewServicos
            reusableview.backgroundColor = GMColor.whiteColor()
            reusableview.title.text = "Servicos"
            reusableview.title.tintColor = GMColor.colorPrimary()
            reusableview.title.textColor = GMColor.colorPrimary()
            reusableview.title.font = UIFont.boldSystemFont(ofSize: 22)
            return reusableview
            
            
        case UICollectionElementKindSectionFooter:
            print(indexPath)
            indexSet = IndexSet(integer: indexPath.section)
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "FooterServicos", for: indexPath) as! FooterCollectionViewServicos
            
            reusableview.backgroundColor = GMColor.whiteColor()
            reusableview.valor.text = "Valor Total: " + String(format: "R$ %.2f", (valorServicos.magnitude ))
            reusableview.valor.tintColor = GMColor.colorPrimary()
            reusableview.valor.textColor = GMColor.colorPrimary()
            reusableview.valor.font = UIFont.boldSystemFont(ofSize: 18)
            return reusableview
        default:
            assert(false, "Unexpected element kind")
        }
        return nil // NOPE, not allowed
    }
    */
    
    
    func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
        print(title)
        return [0, 0]
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if collectionView == self.collectionViewServicos {
            let servico = self.servicos[indexPath.item]
            servico.selecionado = !servico.selecionado
            self.collectionViewServicos.reloadItems(at: [indexPath])
            if servico.selecionado {
                valorServicos = valorServicos + servico.valor!
            }else {
                valorServicos = valorServicos - servico.valor!
            }
            self.collectionViewServicos.reloadSections(self.indexSet)
            self.labelValorTotalCartaoCredito.text = String(format: "R$ %.2f", (valorServicos.magnitude ))
        }
    }
    
}


