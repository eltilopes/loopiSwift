//
//  FiltroController.swift
//  Loopi
//
//  Created by Loopi on 19/06/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class FiltroController: UIView, Modal{
    var backgroundView = UIView()
    var dialogView = UIStackView()
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        initialize( )
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize(){
        
        dialogView.clipsToBounds = true
        dialogView.axis  = UILayoutConstraintAxis.vertical
        dialogView.distribution  = UIStackViewDistribution.equalSpacing
        dialogView.alignment = UIStackViewAlignment.center
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        let hLayout = HorizontalLayout(height: 200)
        hLayout.backgroundColor = GMColor.pink200Color()
        addSubview(hLayout)
        
        let view1 = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        view1.backgroundColor = GMColor.red200Color()
        hLayout.addSubview(view1)
        
        let view2 = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        view2.backgroundColor = GMColor.blue200Color()
        hLayout.addSubview(view2)
        
    }
    
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
}

