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

class CardViewController: BaseViewController, UICollectionViewDataSource,UICollectionViewDelegate {
 
    var selectedRow = -1
    var servicoCard = ServicoCard()
    var servicoCards: [ServicoCard] = []
    var servicos: [ServicoProfissional] = []
    var lastPositionScroll: CGFloat = 0
    var storageRef: StorageReference!
    var valorServicos = 0.0
    var indexSet = IndexSet(integer: 0)
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var collectionViewServicosCard: UICollectionView!
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
    @IBOutlet var buttonConfirmar: UIButton!
    
    let collectionViewServicosCardIdentifier = "CardCell"
    let collectionViewServicosIdentifier = "ServicoViewCell"
    
    fileprivate func setupViewLocalizacao() {
        self.viewLocalizacao.backgroundColor = GMColor.whiteColor()
        self.viewLocalizacao.translatesAutoresizingMaskIntoConstraints = false
        self.labelLocalizacao.textColor = GMColor.colorPrimary()
        self.labelLocalizacao.text = "Você está aqui:"
        self.labelLocalizacao.font = UIFont.systemFont(ofSize: ConstraintsView.fontSmall())
        self.labelValorLocalizacao.textColor = GMColor.textColorPrimary()
        self.labelValorLocalizacao.text = "Rua Jornalista César Magalhães, 401. Patriolino Ribeiro. 60810-140. Fortaleza - CE - Brasil."
        self.labelValorLocalizacao.font = UIFont.systemFont(ofSize: ConstraintsView.fontSmall())
    }
    
    fileprivate func setupViewCashBack() {
        self.viewCashBack.backgroundColor = GMColor.whiteColor()
        self.labelCashBack.textColor = GMColor.textColorPrimary()
        self.labelCashBack.text = "Seu Saldo CashBack"
        self.labelCashBack.font = UIFont.systemFont(ofSize: ConstraintsView.fontSmall())
        self.labelValorCashBack.textColor = GMColor.colorPrimary()
        self.labelValorCashBack.text = "R$ 121,55"
        self.labelValorCashBack.font = UIFont.systemFont(ofSize: ConstraintsView.fontBig())
        textFieldValorCashBack.validations = [.NUMERO]
        textFieldValorCashBack.setAlignmentTitle(alignment: .center)
        textFieldValorCashBack.setBorderColorLoopiTextField(borderColorLoopiTextField: GMColor.backgroundAppColor().cgColor)
        textFieldValorCashBack.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        textFieldValorCashBack.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontSmall()))
        textFieldValorCashBack.setTitle()
    }
    
    fileprivate func setupViewCartaoCredito() {
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
        textFieldValorCartaoCredito.setAlignmentTitle(alignment: .center)
        textFieldValorCartaoCredito.setBorderColorLoopiTextField(borderColorLoopiTextField: GMColor.backgroundAppColor().cgColor)
        textFieldValorCartaoCredito.setBackgroundColorLoopiTextField(backgroundColorLoopiTextField: GMColor.whiteColor())
        textFieldValorCartaoCredito.setFontLoopiTextField(fontLoopiTextField: UIFont.systemFont(ofSize: ConstraintsView.fontSmall()))
        textFieldValorCartaoCredito.setTitle()
        buttonConfirmar.backgroundColor = GMColor.colorPrimary()
        buttonConfirmar.tintColor = GMColor.whiteColor()
        buttonConfirmar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonConfirmar.layer.masksToBounds = true
    }
    
    fileprivate func setupScrollView() {
        view.addSubview(scrollView)
        self.scrollView.delegate = self
        self.scrollView.backgroundColor = GMColor.backgroundAppColor()
    }
    
    fileprivate func setupCollections() {
        storageRef = Storage.storage().reference()
        self.servicoCards.append(servicoCard)
        self.servicos = servicoCard.servicos!
        self.collectionViewServicosCard.delegate = self
        self.collectionViewServicosCard.dataSource = self
        self.collectionViewServicosCard.reloadData()
        self.collectionViewServicosCard.backgroundColor = GMColor.backgroundAppColor()
        self.collectionViewServicos.delegate = self
        self.collectionViewServicos.dataSource = self
        self.collectionViewServicos.reloadData()
        self.collectionViewServicos.backgroundColor = GMColor.backgroundAppColor()
        self.collectionViewServicos.contentInset = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 21)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupCollections()
        setupViewLocalizacao()
        setupViewCashBack()
        setupViewCartaoCredito()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.isScrollEnabled = true
        self.scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 1500)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewServicosCard {
            return 1
        }else{
            return servicos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
        print(title)
        return [0, 0]
    }
    
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
    }
    
  
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let firebaseStorageRest = FirebaseStorageRest(storage: Storage.storage())
       if collectionView == self.collectionViewServicosCard {
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
       }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewServicosIdentifier, for: indexPath as IndexPath) as! ServicoViewCell
            let servico = self.servicos[indexPath.item]
            cell.clipsToBounds = true
            cell.backgroundColor = GMColor.whiteColor()
            cell.servicoNome.text = servico.nome
            cell.servicoNome.tintColor = GMColor.textColorPrimary()
            cell.servicoDescricao.text = servico.descricao
            cell.servicoDescricao.tintColor = GMColor.textColorPrimary()
            cell.servicoValor.text = String(format: "R$ %.2f", (servico.valor?.magnitude ?? 0))
            cell.servicoValor.tintColor = GMColor.colorPrimary()
            if servico.selecionado {
                firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_check_box_black_24px.svg?alt=media&token=195a8577-6bf8-46fc-b451-2d23c4cef098") { (imageIcon, error) in
                    if error == nil {
                        cell.checkButton.image = imageIcon
                        cell.checkButton.image = cell.checkButton.image!.withRenderingMode(.alwaysTemplate)
                        cell.checkButton.tintColor = GMColor.colorPrimary()
                        cell.checkButton.contentMode = .center;
                    }else{
                        self.showToast(message: (error?.localizedDescription)!)
                    }
                }
            }else{
                firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_check_box_outline_blank_black_24px.svg?alt=media&token=c5d92753-f0e8-4adf-9f95-7784477921d6") { (imageIcon, error) in
                    if error == nil {
                        cell.checkButton.image = imageIcon
                        cell.checkButton.image = cell.checkButton.image!.withRenderingMode(.alwaysTemplate)
                        cell.checkButton.tintColor = GMColor.textColorPrimary()
                        cell.checkButton.contentMode = .center;
                    }else{
                        self.showToast(message: (error?.localizedDescription)!)
                    }
                }
        }
        
            return cell
        }
        
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


