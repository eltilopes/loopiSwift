//
//  LoginController.swift
//  Loopi
//
//  Created by Loopi on 07/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit


protocol LoginControllerDelegate: class {
    func finishedLogIn()
    func pedirConvite()
    func criarConta()
}

class LoginController: UIViewController, LoginControllerDelegate {
    var token = "token"
    let cellId = "cellId"
    let loginCellId = "loginCellId"
    
    // constraint variables used for animation
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonBottomAnchor: NSLayoutConstraint?
    var nextButtonBottomAnchor: NSLayoutConstraint?
    
    let pages: [Page] = {
        let firstPage = Page(title: "Loopi, seu novo Hub de Servicos", message: "Procure e ache aqui o servico que necessitar.", imageName: "loopi")
        let secondPage = Page(title: "Convide seus amigos e ganhe CashBack", message: "CashBack eh a sua moeda virtual criada para favorecer voce.", imageName: "cash_back")
        let thirdPage = Page(title: "Loopiiiiiii", message: "Ai sim.", imageName: "loopi_branco")
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = GMColor.grey50Color()
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.numberOfPages = self.pages.count + 1
        pc.currentPageIndicatorTintColor = UIColor.rgb(41, 128, 185)
        return pc
    }()
    
    lazy var skipButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Pular", for: .normal)
        btn.setTitleColor(UIColor.rgb(41, 128, 185), for: .normal)
        btn.addTarget(self, action: #selector(skipPages), for: .touchUpInside)
        return btn
    }()
    
    lazy var nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Proximo", for: .normal)
        btn.setTitleColor(UIColor.rgb(41, 128, 185), for: .normal)
        btn.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeKeyboardNotifications()
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        skipButtonBottomAnchor = skipButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 16, rightConstant: 0, widthConstant: 60, heightConstant: 50)[2]
        
        nextButtonBottomAnchor = nextButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 10, widthConstant: 60, heightConstant: 50)[2]
        
        collectionView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        registerCells()
        
        pageControlBottomAnchor = pageControl.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
    }
    
    
    @objc func skipPages() {
        let indexPath = IndexPath(item: pages.count, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = pages.count
        animatePage()
    }
    
    
    @objc func nextPage() {
        if pageControl.currentPage == pages.count { return }
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
        
        // take care of the last page animation
        animatePage()
    }
    
    
    func animatePage() {
        if pageControl.currentPage == pages.count {
            moveConstraintsOffScreen()
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    
    fileprivate func moveConstraintsOffScreen() {
        pageControlBottomAnchor?.constant = 50
        skipButtonBottomAnchor?.constant = 0
        nextButtonBottomAnchor?.constant = 0
    }
    
    
    fileprivate func moveConstraintsOnScreen() {
        pageControlBottomAnchor?.constant = 0
        skipButtonBottomAnchor?.constant = 50
        nextButtonBottomAnchor?.constant = 50
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
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        // if we are on the last page of the Onboarding
        if pageNumber == pages.count {
            moveConstraintsOffScreen()
        } else {
            moveConstraintsOnScreen()
        }
        
        // animate layout if needed
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    fileprivate func registerCells() {
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
    }
    
    func pedirConvite() {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        mainNavigationController.viewControllers = [CardsServiceController()]
    }
    
    func criarConta() {
        perform(#selector(presentCriarContaViewController), with: nil, afterDelay: 0.01)
    }
    
    @objc func presentCriarContaViewController() {
        let criarContaViewController = CriarContaViewController()
        present(criarContaViewController, animated: true, completion: nil)
    }
    
    func finishedLogIn() {
        
        let accessToken = AccessToken()
        var retorno = ""
            
        accessToken.getAccessToken(){ tok, error in
            
            if error == nil {
                retorno = tok!
                if !retorno.isEmpty {
                    let rootViewController = UIApplication.shared.keyWindow?.rootViewController
                    guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
                    
                    //mainNavigationController.viewControllers = [CardsServiceController()]
                    /*
                    UserDefaults.standard.setIsLoggedIn(value: true)
                    UserDefaults.standard.setToken(token: retorno)
                    UserDefaults.standard.setToken(token: "b10680c7-9439-471c-a1e3-e051960f1000")
                    */
                    self.dismiss(animated: true, completion: nil)
                }else{
                    self.showToast(message: "Usuario invalido")
                }
            }else{
                self.showToast(message: (error?.localizedDescription)!)
            }
            
        }
        
        
        
    }
}


extension LoginController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // set-up the Login Cell
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
            loginCell.contentView.backgroundColor = GMColor.backgroundAppColor()
            loginCell.delegate = self
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        
        cell.page = pages[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collectionView.reloadData()
        }
        
    }
}


extension UIView {
    
    func anchorToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
        
        anchorWithConstantsToTop(top: top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    
    func anchorWithConstantsToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
        }
    }
    
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
}


extension UIColor {
    
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}
extension UIViewController {
    
    func showToast(message : String) {
        
        let alert = LoopiAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
        
        // duration in seconds
        let duration: Double = 5
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true)
        }
    }
    
}
