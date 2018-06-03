//
//  FirebaseStorageRest.swift
//  Loopi
//
//  Created by Loopi on 06/04/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import SVGKit

public enum ImageType {
    case PNG
    case SVG
}
class FirebaseStorageRest : RestConfig{
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    var imagemIcon = UIImage()
    var storage: Storage!
    var existeImagem = true
    
    @discardableResult
    func getImageFirebaseStorage(tipoImage : ImageType, urlImage : String, completionHandler: @escaping (UIImage?,NSError?) -> Void ) -> Bool {
        
        let storageRef = storage.reference(forURL: urlImage)
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously(completion: { (user: User?, error: Error?) in
                if let error = error {
                    self.existeImagem = false
                    completionHandler(nil, error as NSError?)
                }
            })
        }
        storageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) -> Void in
            if error == nil {
                switch tipoImage {
                case .PNG:
                    let image = UIImage(data: data! as Data)
                    self.imagemIcon = image!
                    self.existeImagem = true
                    completionHandler(self.imagemIcon, nil)
                    break
                case .SVG:
                    let svgImage: SVGKImage = SVGKImage(data: data)
                    self.imagemIcon = svgImage.uiImage
                    self.existeImagem = true
                    completionHandler(self.imagemIcon, nil)
                    break
                }
                
            }else{
                self.existeImagem = false
                completionHandler(nil, error as NSError?)
            }
            
        }
        return self.existeImagem
    }
        
    
}
