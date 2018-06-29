//
//  LocationViewController.swift
//  Loopi
//
//  Created by Loopi on 06/04/18.
//  Copyright © 2018 Loopi. All rights reserved.
//
import UIKit
import Firebase
import FirebaseStorage

class LocationViewController: UICollectionViewController {
    
    var storageRef: StorageReference!
    let margin: CGFloat = 5
    @IBOutlet var collectionLocation : UICollectionView!
    var locations: [LocationFooter] = []
    var location = LocationFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storageRef = Storage.storage().reference()
        updateMovimentacoes()
        collectionLocation.backgroundColor = GMColor.colorPrimary()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func updateMovimentacoes(){
        locations.append(LocationFooter( nome : "Buscar Endereco" , acao : "BuscarEndereco" ,descricao : "" ,imageIconName : "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_search_white_24px.svg?alt=media&token=fd135a54-1bcf-4565-96fb-8d1c2955ee89"))
        locations.append(LocationFooter( nome : "Usar Minha Localizacao", acao : "MinhaLocalizacao" ,descricao : "proximo ..." ,imageIconName : "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_location_searching_white_24px.svg?alt=media&token=e0de4e4e-db4d-4a01-8573-0c149fa00212"))
        locations.append(LocationFooter( nome : "Casa", acao : "Casa" ,descricao : "Rua Tallarin. Casa 34. Fortaleza" ,imageIconName : "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_home_white_24px.svg?alt=media&token=2946f150-fa7e-4fa6-8a5c-ea9285f9d0f4"))
        locations.append(LocationFooter( nome : "Trabalho", acao : "Trabalho",descricao : "la la land e mais alguma coisa" ,imageIconName : "https://firebasestorage.googleapis.com/v0/b/allinone-bd141.appspot.com/o/ic_work_white_24px.svg?alt=media&token=055db488-884c-4e1b-9202-9e3ae5d80053"))
    }
 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationCell", for: indexPath as IndexPath) as! LocationViewCell
        cell.backgroundColor = GMColor.colorPrimary()
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        let location = self.locations[indexPath.item]
        cell.nome.text = location.nome
        cell.nome.font = UIFont.boldSystemFont(ofSize: 20.0)
        cell.nome.backgroundColor = GMColor.colorPrimary()
        cell.nome.textColor = GMColor.whiteColor()
        if location.descricao == "" {
            cell.descricao.isHidden = true
        }else{
            cell.descricao.text = location.descricao
            cell.descricao.backgroundColor = GMColor.colorPrimary()
            cell.descricao.textColor = GMColor.whiteColor()
            cell.descricao.isHidden = false
        }
        
        
       
        let firebaseStorageRest = FirebaseStorageRest(storage: Storage.storage())
        firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: location.imageIconName) { (imageIcon, error) in
            if error == nil {
                cell.imageViewIcon.image = imageIcon
                cell.imageViewIcon.contentMode = .center;
            }else{
                self.showToast(message: (error?.localizedDescription)!)
            }
        }
        firebaseStorageRest.getImageFirebaseStorage(tipoImage : ImageType.SVG,urlImage: location.imageActionName) { (imageIcon, error) in
            if error == nil {
                cell.imageViewAction.image = imageIcon
                cell.imageViewAction.contentMode = .center;
            }else{
                self.showToast(message: (error?.localizedDescription)!)
            }
        }

        cell.layoutMargins = UIEdgeInsets(top: margin, left: margin,
                                          bottom: margin, right: margin)
        return cell
    }
  
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
  
   
    // MARK: - UICollectionViewDelegate protocol
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.location = self.locations[indexPath.item]
        if(location.acao == "BuscarEndereco"){
            self.performSegue(withIdentifier: location.acao, sender: self.location)
        }else{
            let localizacao = location
            UserDefaults.standard.setLocalizacao(localizacao: localizacao.toJSONString(prettyPrint: true)!)
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // get a reference to the second view controller
        if segue.identifier == "BuscarEndereco" {
            let viewController = segue.destination as! BuscarEnderecoViewController
            viewController.location = self.location
        }
    }
    
}



