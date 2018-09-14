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
    var itemServico = ItemServico()
    var servicos: [ServicoProfissional] = []
    let servicoCardRest = ServicoCardRest()
    var lastPositionScroll: CGFloat = 0
    var storageRefCard: StorageReference!
    var indexSet = IndexSet(integer: 0)
    
    var x : CGFloat = 0
    var y : CGFloat = 0
    var width : CGFloat = 0
    var height : CGFloat = 0
    var heightServicos : CGFloat = 0
    
    @IBOutlet var collectionViewServicoCard: UICollectionView!
    @IBOutlet var collectionViewServicos: UICollectionView!
    @IBOutlet var labelCrieAnuncio: UILabel!
    @IBOutlet var buttonConfirmarCard: UIButton!
    @IBOutlet var buttonAdicionarServico: UIButton!
    @IBOutlet var stackView: UIView!
    
    var servicoProfissionalAlertController : ServicoProfissionalAlertController!
    
    let collectionViewServicosCardIdentifier = "ProfissionalCardViewCell"
    let collectionViewServicosIdentifier = "ProfissionalCardServicoViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        montarServicoCard()
        
        let backButtonImage = UIImage(named: "ic_arrow_left_white")?.withRenderingMode(.alwaysTemplate)
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .white
        backButton.setTitle("Voltar", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(sender:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
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
        self.stackView.frame = CGRect(x: self.collectionViewServicos.frame.origin.x, y: self.collectionViewServicos.frame.origin.y, width: self.collectionViewServicos.frame.size.width , height: self.collectionViewServicos.frame.size.height * 1.1)
        self.collectionViewServicos.frame = CGRect(x: self.collectionViewServicos.frame.origin.x, y: self.collectionViewServicos.frame.origin.y, width: self.collectionViewServicos.frame.size.width , height: self.collectionViewServicos.frame.size.height * 1.1)
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
    
    @objc func backAction(sender: UIBarButtonItem) {
        // custom actions here
        navigationController?.popViewController(animated: true)
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
        self.servicoCard.categoria = profissional.categoria
        self.servicoCard.especialidade = profissional.especialidade
        self.servicoCard.title = usuario.nome?.uppercased()
        self.servicoProfissional.nome = "Nome do Servico"
        self.servicoProfissional.descricao = "Descricao do Servico"
        self.servicoProfissional.valor = 55.2
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
            //return CGSize(width: self.collectionViewServicoCard.frame.size.width  , height: self.collectionViewServicoCard.frame.size.height / 4.5)
            return CGSize(width: self.collectionViewServicoCard.frame.size.width  , height: self.collectionViewServicoCard.frame.size.height )
        }
        return CGSize(width: self.collectionViewServicos.frame.size.width  , height: self.collectionViewServicos.frame.size.height  )
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
            cellSelecionado.imageView.contentMode = .center
            return cellSelecionado
        }else{
            if indexPath.item == 0 {
                self.heightServicos = 0
            }
            let cellServico = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewServicosIdentifier, for: indexPath as IndexPath) as! ProfissionalCardServicoViewCell
            let servico = self.servicos[indexPath.item]
            cellServico.backgroundColor = GMColor.whiteColor()
            cellServico.servicoNome.text = servico.nome
            cellServico.servicoNome.tintColor = GMColor.textColorPrimary()
            cellServico.servicoNome.textColor = GMColor.textColorPrimary()
            cellServico.servicoDescricao.text = servico.descricao
            cellServico.servicoDescricao.textColor = GMColor.textColorPrimary()
            cellServico.servicoDescricao.tintColor = GMColor.textColorPrimary()
            cellServico.servicoValor.text = String(format: "R$ %.2f", (servico.valor?.magnitude ?? 0))
            cellServico.servicoValor.textColor = GMColor.colorPrimary()
            cellServico.servicoValor.tintColor = GMColor.colorPrimary()
            cellServico.itens.textColor = GMColor.textColorRed()
            cellServico.itens.tintColor = GMColor.textColorRed()
            cellServico.itens.text =  "Servico sem Itens, deseja adicionar?"
            cellServico.itens.isHidden = servico.itens.isEmpty 
            
            return cellServico
        }
        
    }
    
    @objc func onSalvarServicoButtonPressed( ){
        didTappedOnButtonSalvar()
        
    }
    
    @objc func didTappedOnButtonSalvar(){
        self.servicos.append(self.servicoProfissional)
        self.collectionViewServicos.reloadData()
        self.view.bringSubview(toFront: collectionViewServicos)
        self.view.sendSubview(toBack: stackView)
        self.collectionViewServicos.isHidden = false
        self.buttonAdicionarServico.isHidden = false
        self.stackView.frame = CGRect(x: x, y: y, width: width , height: height)
        self.collectionViewServicos.frame = CGRect(x: x, y: y, width: width , height: height)
        self.stackView.addSubview(collectionViewServicos)
        self.stackView.layoutSubviews()
    }
    
    @objc func tappedAddServico(){
        self.servicoProfissional = ServicoProfissional()
        servicoProfissionalAlertController = ServicoProfissionalAlertController(servicoProfissional: self.servicoProfissional, profissionalCardViewController: self )
        servicoProfissionalAlertController.show(animated: true)
        

    }
    
 
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        self.servicoProfissional = self.servicos[indexPath.item]
        //openViewControllerBasedOnIdentifier("CardViewController")
        self.performSegue(withIdentifier: "servicoProfisionalSegue", sender: self.servicoProfissional)
        
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // get a reference to the second view controller

        if segue.identifier == "servicoProfisionalSegue" {
           let servicoProfissionalViewController = segue.destination as! ServicoProfissionalViewController
            servicoProfissionalViewController.servicoProfissional = self.servicoProfissional
        }
    }

   
    
}



