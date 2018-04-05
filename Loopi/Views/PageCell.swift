//
//  PageCell.swift
//  Loopi
//
//  Created by Loopi on 07/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            
            guard let page = page else {
                return
            }
            
            imageView.image = UIImage(named: page.imageName)
            
            let fontColor = UIColor.rgb(28, 42, 57)
            let attributedText = NSMutableAttributedString(string: page.title,
                                                           attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium),
                                                                        NSAttributedStringKey.foregroundColor: fontColor])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor: fontColor]))
            
            // Center Text in TextView
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let stringLength = attributedText.string.count
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: stringLength))
            
            textView.attributedText = attributedText
            
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .white
        iv.image = UIImage(named: "loopi")
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "Walkthrough"
        tv.isEditable = false
        
        // Give it some space from the top
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        
        return tv
    }()
    
    let lineSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(imageView)
        addSubview(lineSeperatorView)
        addSubview(textView)
        
        imageView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        
        lineSeperatorView.anchorToTop(top: nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        lineSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        textView.anchorWithConstantsToTop(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    }
    
}

