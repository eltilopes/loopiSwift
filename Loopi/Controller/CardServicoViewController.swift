//
//  CardServicoViewController.swift
//  Loopi
//
//  Created by Loopi on 22/02/19.
//  Copyright © 2019 Loopi. All rights reserved.
//

import UIKit

class CardServicoViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    let cardServicoProfissionalViewCellId = "cardServicoProfissionalViewCellId"
    let cardServicosViewCellId = "cardServicosViewCellId"
    var servicoCard = ServicoCard()
    var servicos = [ServicoProfissional]()
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var dialogViewHeight: CGFloat!
    let activityProgressLoopi = ActivityProgressLoopi()
    var indicator:UIActivityIndicatorView!
    var scrollView = UIScrollView()
    
    lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = GMColor.colorPrimary()
        let btnVoltar = UIButton(type: UIButtonType.system)
        btnVoltar.backgroundColor = GMColor.colorPrimary()
        let voltarImage = UIImage(named: "ic_back")
        btnVoltar.setImage(voltarImage, for: UIControlState())
        btnVoltar.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        btnVoltar.addTarget(self, action: #selector(self.presentCardsServiceController(_:)), for: UIControlEvents.touchUpInside)
        let label = UILabel()
        label.backgroundColor = GMColor.colorPrimary()
        label.textColor = GMColor.whiteColor()
        label.tintColor = GMColor.whiteColor()
        label.font =  UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        label.textAlignment = .left
        label.text = "VOLTAR"
        label.frame = CGRect(x: 10, y: 10, width: 100, height: 30)
        headerView.insertSubview(btnVoltar, at: 0)
        headerView.insertSubview(label, at: 1)
        return headerView
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        //layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        //layout.itemSize = CGSize(width: screenWidth , height: screenHeight )
        
        let cv = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.backgroundColor = GMColor.backgroundAppColor()
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(CardServicoProfissionalViewCell.self, forCellWithReuseIdentifier: self.cardServicoProfissionalViewCellId)
        cv.reloadData()
        return cv
    }()
    
    lazy var collectionViewServicos: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        //layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        //layout.itemSize = CGSize(width: screenWidth , height: screenHeight )
        
        let cvs = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        cvs.delegate = self
        cvs.dataSource = self
        cvs.isPagingEnabled = true
        cvs.backgroundColor = GMColor.backgroundAppColor()
        cvs.showsVerticalScrollIndicator = false
        cvs.showsHorizontalScrollIndicator = false
        cvs.register(CardServicosViewCell.self, forCellWithReuseIdentifier: self.cardServicosViewCellId)
        cvs.reloadData()
        return cvs
    }()
    
    lazy var viewPagamento: UIStackView = {
        let viewPagamento = UIStackView()
        viewPagamento.clipsToBounds = true
        viewPagamento.axis  = UILayoutConstraintAxis.vertical
        viewPagamento.distribution  = UIStackViewDistribution.equalSpacing
        viewPagamento.alignment = UIStackViewAlignment.center
        //dialogView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        viewPagamento.translatesAutoresizingMaskIntoConstraints = false
        viewPagamento.addArrangedSubview(testeLabel)
        viewPagamento.backgroundColor = GMColor.backgroundAlertInfoColor()
        viewPagamento.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        viewPagamento.layer.masksToBounds = true
        
        //dialogView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //dialogView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        return viewPagamento
    }()
    
    lazy var viewCashBack: UIView = {
        let viewCashBack = UIView()
        viewCashBack.backgroundColor = GMColor.backgroundAlertInfoColor()
        viewCashBack.widthAnchor.constraint(equalToConstant: screenWidth ).isActive = true
        viewCashBack.heightAnchor.constraint(equalToConstant: screenHeight ).isActive = true
        return viewCashBack
    }()
    
    lazy var testeLabel: UILabel = {
        let label = UILabel()
        label.textColor = GMColor.colorPrimary()
        label.backgroundColor = GMColor.backgroundAlertColor()
        label.font =  UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
        label.textAlignment = .center
        label.text = "Teste"
        label.widthAnchor.constraint(equalToConstant: screenWidth ).isActive = true
        label.heightAnchor.constraint(equalToConstant: screenHeight ).isActive = true
        label.clipsToBounds = true
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = self.view.frame.size.width
        screenHeight = self.view.frame.size.height / 3.5
        loadViewCardServico()
    }
    
  
    @objc func presentCardsServiceController(_ sender : UIButton){
        //let cardsServiceController = CardsServiceController()
        let cardsServiceController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardsServiceController") as! CardsServiceController
        present(cardsServiceController, animated: true, completion: nil)
    }
    
    func loadViewCardServico() {
        /*
         print("Usuario tem convite: \(UserDefaults.standard.temConvite()) \n")
         print("Usuario logado: \(UserDefaults.standard.isLoggedIn()) \n")
         UserDefaults.standard.setTemConvite(value: false)
         */
        observeKeyboardNotifications()
        servicoCard = UserDefaults.standard.getServicoCard()
        servicos = servicoCard.servicos!
        dialogViewHeight = ConstraintsView.heightTitleLabel() * 3
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 70, width: screenWidth, height: screenHeight))
        self.scrollView.isScrollEnabled = true
        //self.scrollView.alwaysBounceVertical = true
        //self.scrollView.alwaysBounceHorizontal = false
        self.scrollView.delegate = self
        //self.scrollView.scrollsToTop = false
        //self.scrollView.bounces = true
        self.scrollView.backgroundColor = GMColor.backgroundAppColor()
        //self.scrollView.canCancelContentTouches = true
        //self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: screenWidth, height: self.view.frame.size.height * 2)
        //self.scrollView.backgroundColor = GMColor.backgroundAppColor()
        //self.scrollView.isScrollEnabled = true
        //self.scrollView.alwaysBounceVertical = true
        //self.scrollView.alwaysBounceHorizontal = false
        
        view.backgroundColor = GMColor.whiteColor()
        view.addSubview(headerView)
        view.addSubview(scrollView)
        aplicarScrollView()
       _ = headerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: screenWidth , heightConstant: 50 )
        _ = scrollView.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: screenWidth , heightConstant: self.view.frame.size.height * 2 )
        
        
        print("servicos.count")
        print(servicos.count)
        //collectionView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        collectionView.reloadData()
        collectionViewServicos.reloadData()
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.isScrollEnabled = true
    }
    
    func aplicarScrollView() {
        var heightCollectionServicos: CGFloat = 0.0
        for _ in servicos {
            heightCollectionServicos = heightCollectionServicos + dialogViewHeight
        }
        heightCollectionServicos = heightCollectionServicos + dialogViewHeight
        self.scrollView.addSubview(collectionView)
        self.scrollView.addSubview(collectionViewServicos)
        self.scrollView.addSubview(viewCashBack)
        self.scrollView.addSubview(testeLabel)
        
        _ = collectionView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: screenWidth , heightConstant: screenHeight )
        _ = collectionViewServicos.anchor(top: collectionView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: screenWidth , heightConstant: heightCollectionServicos )
        _ = testeLabel.anchor(top: collectionViewServicos.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: screenWidth , heightConstant: screenHeight )
        _ = viewCashBack.anchor(top: testeLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: screenWidth , heightConstant: screenHeight )
        self.scrollView.isScrollEnabled = true
    }
    
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardDidHide, object: nil)
    }
    
    
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -110 : -70
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.scrollView.isScrollEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView{
            return  1
        } else {
            return servicos.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // set-up the Login Cell
        if collectionView == self.collectionView{
            
            let cardServicoProfissionalViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cardServicoProfissionalViewCellId, for: indexPath) as! CardServicoProfissionalViewCell
            cardServicoProfissionalViewCell.backgroundColor = GMColor.backgroundAppColor()
            cardServicoProfissionalViewCell.servicoCard = self.servicoCard
            cardServicoProfissionalViewCell.cardSelecionadoLabel.text = self.servicoCard.title
            cardServicoProfissionalViewCell.cardSelecionadoCategoria.text = self.servicoCard.categoria.descricao
            cardServicoProfissionalViewCell.cardSelecionadoEspecialidade.text = self.servicoCard.especialidade.descricao
            //cardServicoProfissionalViewCell.layer.borderColor = GMColor.whiteColor().cgColor
            //cardServicoProfissionalViewCell.layer.borderWidth = ConstraintsView.borderCornerIndicatorView()
            //cardServicoProfissionalViewCell.frame.size.width = screenWidth
            //cardServicoProfissionalViewCell.frame.size.height = screenHeight
            let imageURL = URL(string: self.servicoCard.thumbnail!)
            var image: UIImage?
            self.indicator = self.activityProgressLoopi.startActivity(controller: self)
            if let url = imageURL {
                //All network operations has to run on different thread(not on main thread).
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData = NSData(contentsOf: url)
                    //All UI operations has to run on main thread.
                    DispatchQueue.main.async {
                        if imageData != nil {
                            image = UIImage(data: imageData! as Data)
                            self.activityProgressLoopi.stopActivity(controller: self,indicator: self.indicator)
                        } else {
                            image = UIImage(named: "perfil")
                            self.activityProgressLoopi.stopActivity(controller: self,indicator: self.indicator)
                        }
                        cardServicoProfissionalViewCell.cardSelecionadoImageView.image = image
                        cardServicoProfissionalViewCell.cardSelecionadoImageView.contentMode = .scaleAspectFit
                        cardServicoProfissionalViewCell.cardSelecionadoImageView.autoresizesSubviews = false
                        cardServicoProfissionalViewCell.cardSelecionadoImageView.clipsToBounds = true
                    }
                }
            }
            return cardServicoProfissionalViewCell
        } else  {
            
            let cardServicosViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cardServicosViewCellId, for: indexPath) as! CardServicosViewCell
            cardServicosViewCell.backgroundColor = GMColor.whiteColor()
            let servico = self.servicos[indexPath.item]
            cardServicosViewCell.descricaoServicoLabel.text = servico.descricao
            cardServicosViewCell.nomeServicoLabel.text = servico.nome
            cardServicosViewCell.valorServicoLabel.text = String(format: "R$ %.2f", (servico.valor?.magnitude ?? 0))
            //cardServicoProfissionalViewCell.layer.borderColor = GMColor.whiteColor().cgColor
            //cardServicoProfissionalViewCell.layer.borderWidth = ConstraintsView.borderCornerIndicatorView()
            //cardServicosViewCell.frame.size.width = screenWidth
            //cardServicosViewCell.frame.size.height = screenHeight
          
            return cardServicosViewCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView{
            //return CGSize(width: self.view.frame.size.width  , height: self.view.frame.size.height )
            return CGSize(width: screenWidth  , height: screenHeight )
        } else  {
           // let heightCollectionServicos = CGFloat(ConstraintsView.heightHeaderTitleLabel() * 3 * servicos.count)
            return CGSize(width: screenWidth   , height:  dialogViewHeight )
        }
    }
    

}



