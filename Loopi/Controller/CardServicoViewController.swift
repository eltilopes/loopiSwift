//
//  CardServicoViewController.swift
//  Loopi
//
//  Created by Loopi on 22/02/19.
//  Copyright © 2019 Loopi. All rights reserved.
//

import UIKit

class CardServicoViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let cardServicoProfissionalViewCellId = "cardServicoProfissionalViewCellId"
    let cardServicosViewCellId = "cardServicosViewCellId"
    var servicoCard = ServicoCard()
    var servicos = [ServicoProfissional]()
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var dialogViewHeight: CGFloat!
    let activityProgressLoopi = ActivityProgressLoopi()
    var indicator:UIActivityIndicatorView!
    
    lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = GMColor.colorPrimary()
        let btnVoltar = UIButton(type: UIButtonType.system)
        btnVoltar.backgroundColor = GMColor.colorPrimary()
        btnVoltar.tintColor = GMColor.whiteColor()
        let voltarImage = UIImage(named: "ic_back")
        btnVoltar.setImage(voltarImage, for: UIControlState())
        btnVoltar.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        btnVoltar.addTarget(self, action: #selector(self.presentCardsServiceController(_:)), for: UIControlEvents.touchUpInside)
        headerView.insertSubview(btnVoltar, at: 0)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = self.view.frame.size.width
        screenHeight = self.view.frame.size.height / 3.5
        dialogViewHeight = CGFloat(ConstraintsView.heightHeaderTitleLabel() * 3)
        loadViewCardServico()
    }
    
    func addSlideVoltarButton(){
        let btnVoltar = UIButton(type: UIButtonType.system)
        let voltarImage = UIImage(named: "ic_back")
        btnVoltar.setImage(voltarImage, for: UIControlState())
        btnVoltar.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnVoltar.addTarget(self, action: #selector(self.presentCardsServiceController(_:)), for: UIControlEvents.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnVoltar)
  
        self.navigationItem.leftBarButtonItem = customBarItem;
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
        dialogViewHeight = CGFloat(ConstraintsView.heightHeaderTitleLabel() * 3)
        
        view.backgroundColor = GMColor.whiteColor()
        view.addSubview(headerView)
        view.addSubview(collectionView)
        view.addSubview(collectionViewServicos)
        var heightCollectionServicos: CGFloat = 0.0
        for _ in servicos {
            heightCollectionServicos = heightCollectionServicos + dialogViewHeight
        }
       _ = headerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: screenWidth , heightConstant: 50 )
        _ = collectionView.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: screenWidth , heightConstant: screenHeight )
        _ = collectionViewServicos.anchor(top: collectionView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: screenWidth , heightConstant: heightCollectionServicos )
        
        print("servicos.count")
        print(servicos.count)
        //collectionView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        collectionView.reloadData()
        collectionViewServicos.reloadData()
        

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
            cardServicoProfissionalViewCell.frame.size.width = screenWidth
            cardServicoProfissionalViewCell.frame.size.height = screenHeight
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
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView{
            //return CGSize(width: self.view.frame.size.width  , height: self.view.frame.size.height )
            return CGSize(width: screenWidth  , height: screenHeight )
        } else  {
           // let heightCollectionServicos = CGFloat(ConstraintsView.heightHeaderTitleLabel() * 3 * servicos.count)
            return CGSize(width: screenWidth * 4/5  , height:  dialogViewHeight )
        }
    }
    

}



