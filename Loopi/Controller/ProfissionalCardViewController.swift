//
//  ProfissionalCardViewController.swift
//  Loopi
//
//  Created by Loopi on 19/07/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit
import SwiftyJSON
import Firebase
import FirebaseStorage

class ProfissionalCardViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var selectedRow = -1
    var servicoCard = ServicoCard()
    var servicoCards: [ServicoCard] = []
    var servicoProfissional = ServicoProfissional()
    var servicos: [ServicoProfissional] = []
    let servicoCardRest = ServicoCardRest()
    var lastPositionScroll: CGFloat = 0
    var storageRefCard: StorageReference!
    var valorServicos = 0.0
    var indexSet = IndexSet(integer: 0)
    var heightCellServico : CGFloat = 400
    
    
    var x : CGFloat = 0
    var y : CGFloat = 0
    var width : CGFloat = 0
    var height : CGFloat = 0
    
    @IBOutlet var collectionViewServicoCard: UICollectionView!
    @IBOutlet var collectionViewServicos: UICollectionView!
    @IBOutlet var labelCrieAnuncio: UILabel!
    @IBOutlet var buttonConfirmarCard: UIButton!
    @IBOutlet var buttonAdicionarServico: UIButton!
    @IBOutlet var stackView: UIView!
    
    var textFieldNome = UITextField()
    var textFieldDescricao = UITextField()
    var textFieldValor = UITextField()
    
    let collectionViewServicosCardIdentifier = "ProfissionalCardViewCell"
    let collectionViewServicosIdentifier = "ProfissionalCardServicoViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        montarServicoCard()
        self.view.backgroundColor = GMColor.backgroundAppColor()
        storageRefCard = Storage.storage().reference()
        self.servicoCards.append(servicoCard)
        self.servicos.append(servicoProfissional)
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
       
        self.buttonConfirmarCard.backgroundColor = GMColor.colorPrimary()
        self.buttonConfirmarCard.tintColor = GMColor.whiteColor()
        self.buttonConfirmarCard.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.buttonConfirmarCard.addTarget(self, action: #selector(confirmarCadastro), for: .touchUpInside)
        
        self.buttonAdicionarServico.backgroundColor = GMColor.buttonBlueColor()
        self.buttonAdicionarServico.tintColor = GMColor.whiteColor()
        self.buttonAdicionarServico.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.buttonAdicionarServico.addTarget(self, action: #selector(tappedAddServico), for: .touchUpInside)

        self.stackView.backgroundColor = GMColor.blue50Color()
        self.stackView.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.stackView.frame = CGRect(x: self.collectionViewServicos.frame.origin.x, y: self.collectionViewServicos.frame.origin.y, width: self.collectionViewServicos.frame.size.width , height: self.collectionViewServicos.frame.size.height )
        self.collectionViewServicos.frame = CGRect(x: self.collectionViewServicos.frame.origin.x, y: self.collectionViewServicos.frame.origin.y, width: self.collectionViewServicos.frame.size.width , height: self.collectionViewServicos.frame.size.height )
        self.stackView.addSubview(self.collectionViewServicos)
    }
    
    @objc func confirmarCadastro() {
        servicoCardRest.solicitarServico(servico: servicoCard ){ solicitado, error in
            let activityProgressLoopi = ActivityProgressLoopi()
            let indicator = activityProgressLoopi.startActivity(obj: self)
            if error == nil {
                self.showToast(message: "Servico solicitado" )
            }else{
                self.showToast(message: (error?.localizedDescription)!)
            }
            ActivityProgressLoopi().stopActivity(obj: self,indicator: indicator)
        }
    }
    
    func montarServicoCard() {
        
        var usuario : Usuario
        var profissional : Profissional
        let categoria = Categoria()
        categoria.descricao = "Categoria"
        let especialidade = Especialidade()
        especialidade.descricao = "Especialidade"
        let prof = Profissional()
        prof.categoria = categoria
        prof.especialidade = especialidade
        UserDefaults.standard.setProfissional(profissional: prof)
        usuario = UserDefaults.standard.getUsuario()
        profissional = UserDefaults.standard.getProfissional()
        servicoCard.categoria = profissional.categoria
        servicoCard.especialidade = profissional.especialidade
        servicoCard.title = usuario.nome?.uppercased()
        servicoProfissional.nome = "Nome do Servico"
        servicoProfissional.descricao = "Descricao do Servico"
        servicoProfissional.valor = 55.2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if collectionView == self.collectionViewServicoCard {
            let cellSelecionado = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewServicosCardIdentifier, for: indexPath as IndexPath) as! ProfissionalCardViewCell
            
            let cardServico = self.servicoCards[indexPath.item]
            cellSelecionado.myLabel.text = cardServico.title
            cellSelecionado.cardCategoria.text = cardServico.categoria.descricao
            cellSelecionado.cardCategoria.textColor = GMColor.colorPrimary()
            cellSelecionado.cardEspecialidade.text = cardServico.especialidade.descricao
            cellSelecionado.backgroundColor = UIColor.white // make cell more visible in our example project
            cellSelecionado.imageView.image = UIImage(named: "ic_profissional")
            cellSelecionado.imageView.contentMode = .scaleAspectFill
            return cellSelecionado
        }else{
            let cellServico = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewServicosIdentifier, for: indexPath as IndexPath) as! ProfissionalCardServicoViewCell
            let servico = self.servicos[indexPath.item]
            cellServico.backgroundColor = GMColor.whiteColor()
            cellServico.servicoNome.text = servico.nome
            cellServico.servicoNome.tintColor = GMColor.textColorPrimary()
            cellServico.servicoDescricao.text = servico.descricao
            cellServico.servicoDescricao.tintColor = GMColor.textColorPrimary()
            cellServico.servicoValor.text = String(format: "R$ %.2f", (servico.valor?.magnitude ?? 0))
            cellServico.servicoValor.tintColor = GMColor.colorPrimary()
           
            return cellServico
        }
        
    }
    
    
    @objc func didTappedOnButtonSalvar(){
        
        self.view.bringSubview(toFront: collectionViewServicos)
        self.view.sendSubview(toBack: stackView)
        self.collectionViewServicos.isHidden = false
        self.buttonAdicionarServico.isHidden = false
        self.stackView.frame = CGRect(x: x, y: y, width: width , height: height)
        self.stackView.addSubview(collectionViewServicos)
        self.servicoProfissional.descricao = textFieldDescricao.text
        self.servicoProfissional.nome = textFieldNome.text
        self.servicoProfissional.valor = 58
        self.servicos.append(servicoProfissional)
        self.collectionViewServicos.reloadData()
    }
    
    fileprivate func montarTextFieldDescricao(_ heightSalvarServico: CGFloat) -> UITextField {
        textFieldDescricao = UITextField()
        textFieldDescricao.placeholder = "DESCRICAO:"
        textFieldDescricao.textAlignment = .left
        textFieldDescricao.backgroundColor = GMColor.whiteColor()
        textFieldDescricao.textColor = GMColor.textColorPrimary()
        textFieldDescricao.tintColor = GMColor.textColorPrimary()
        textFieldDescricao.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        textFieldDescricao.frame = CGRect(x: x, y: y +  heightSalvarServico, width: width , height:  heightSalvarServico)
        textFieldDescricao.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        textFieldDescricao.layer.borderColor = GMColor.backgroundHeaderColor().cgColor
        textFieldDescricao.layer.borderWidth = CGFloat(ConstraintsView.widthBorderLoopiTextField())
        return textFieldDescricao
    }
    
    fileprivate func montarTextFieldNome(_ heightSalvarServico: CGFloat) -> UITextField {
        textFieldNome = UITextField()
        textFieldNome.text = "NOME:"
        //textFieldNome.frame = CGRect(x: x, y: y, width: width , height: 50)
        textFieldNome.textAlignment = .left
        textFieldNome.backgroundColor = GMColor.whiteColor()
        textFieldNome.textColor = GMColor.textColorPrimary()
        textFieldNome.tintColor = GMColor.textColorPrimary()
        textFieldNome.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        textFieldNome.frame = CGRect(x: x, y: y, width: width , height: heightSalvarServico)
        textFieldNome.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        textFieldNome.layer.borderColor = GMColor.backgroundHeaderColor().cgColor
        textFieldNome.layer.borderWidth = CGFloat(ConstraintsView.widthBorderLoopiTextField())
        return textFieldNome
    }
    
    fileprivate func montarTextFieldValor(_ heightSalvarServico: CGFloat) -> UITextField {
        textFieldValor = UITextField()
        textFieldValor.text = "VALOR:"
        textFieldValor.textAlignment = .left
        textFieldValor.backgroundColor = GMColor.whiteColor()
        textFieldValor.textColor = GMColor.textColorPrimary()
        textFieldValor.tintColor = GMColor.textColorPrimary()
        textFieldValor.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        textFieldValor.frame = CGRect(x: x, y: y + (2*heightSalvarServico), width: width , height:  heightSalvarServico)
        textFieldValor.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        textFieldValor.layer.borderColor = GMColor.backgroundHeaderColor().cgColor
        textFieldValor.layer.borderWidth = CGFloat(ConstraintsView.widthBorderLoopiTextField())
        return textFieldValor
    }
    @objc func tappedAddServico(){
        
        self.x = self.collectionViewServicos.frame.origin.x
        self.y = self.collectionViewServicos.frame.origin.y
        self.width = self.collectionViewServicos.frame.size.width
        self.height = self.collectionViewServicos.frame.size.height
        self.view.bringSubview(toFront: stackView)
        self.view.sendSubview(toBack: collectionViewServicos)
        self.buttonAdicionarServico.isHidden = true
        self.collectionViewServicos.isHidden = true
        let viewBorder = UIView(frame: CGRect(x: x, y: y, width: width , height: height))
        viewBorder.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        viewBorder.layer.masksToBounds = true
        
        let heightSalvarServico = height/4
        
        
        
        viewBorder.addSubview(montarTextFieldNome(heightSalvarServico))
        viewBorder.addSubview(montarTextFieldDescricao(heightSalvarServico))
        viewBorder.addSubview(montarTextFieldValor(heightSalvarServico))
        
        let buttonSalvar = UIButton()
        buttonSalvar.backgroundColor = GMColor.colorPrimary()
        buttonSalvar.addTarget(self, action: #selector(didTappedOnButtonSalvar), for: .touchUpInside)
        buttonSalvar.setTitle("SALVAR", for: UIControlState.normal)
        buttonSalvar.setTitle("SALVAR", for: UIControlState.selected)
        buttonSalvar.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonSalvar.setTitleColor(GMColor.whiteColor(), for: .selected)
        buttonSalvar.titleLabel?.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        buttonSalvar.frame = CGRect(x: x, y: y +  (3*heightSalvarServico), width: width , height:  heightSalvarServico)
        buttonSalvar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonSalvar.layer.masksToBounds = true
        viewBorder.addSubview(buttonSalvar)
        /*
        let titleNome = UILabel()
        titleNome.tintColor = GMColor.textColorPrimary()
        titleNome.backgroundColor = GMColor.whiteColor()
        //titleNome.widthAnchor.constraint(equalToConstant: CGFloat(dialogViewWidth - marginTitle)).isActive = true
        //titleNome.heightAnchor.constraint(equalToConstant: CGFloat(ConstraintsView.heightHeaderTitleLabel())).isActive = true
        titleNome.text = "NOME"
        titleNome.frame = CGRect(x: x, y: y, width: width , height: 50)
        titleNome.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        titleNome.textAlignment = .left
         */
        
        self.stackView.frame = CGRect(x: x, y: y, width: width , height: height)
        self.stackView.addSubview(viewBorder)

        
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
        print(title)
        return [0, 0]
    }
    
    
    
   
    
}



