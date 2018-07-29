//
//  ProfissionalDocumentosViewController.swift
//  Loopi
//
//  Created by Loopi on 11/07/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class ProfissionalDocumentosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let heightHeader : CGFloat = 60.0
    let margin: CGFloat = 5
    @IBOutlet var tblProfissionalDocumentos : UITableView!
    @IBOutlet var labelProfissionalDocumentos : UILabel!
    @IBOutlet var buttonConfirmar: UIButton!
    var documentos: [Documento] = []
    var imagePicker: UIImagePickerController!
    var imageSelecionada = UIImage(named: "ic_file")
    var selectedRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDocumentos()
        addButtonConfirmar()
        self.labelProfissionalDocumentos.backgroundColor = GMColor.backgroundAppColor()
        self.labelProfissionalDocumentos.textColor = GMColor.textColorPrimary()
        self.labelProfissionalDocumentos.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        self.view.backgroundColor = GMColor.backgroundAppColor()
        self.tblProfissionalDocumentos.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.tblProfissionalDocumentos.layer.masksToBounds = true
        self.tblProfissionalDocumentos.separatorStyle = .none
        self.tblProfissionalDocumentos.backgroundColor = GMColor.backgroundAppColor()
        self.tblProfissionalDocumentos.delegate = self
        self.tblProfissionalDocumentos.dataSource = self
        //visualizarImagem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addButtonConfirmar() {
        
        buttonConfirmar.titleLabel?.text = "Confirmar"
        buttonConfirmar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonConfirmar.layer.masksToBounds = true
        buttonConfirmar.tintColor = GMColor.whiteColor()
        buttonConfirmar.titleLabel!.textAlignment = .center
        buttonConfirmar.titleLabel?.lineBreakMode = .byWordWrapping
        buttonConfirmar.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonConfirmar.translatesAutoresizingMaskIntoConstraints = false
        buttonConfirmar.backgroundColor = GMColor.colorPrimary()
        
    }
    
    
    func updateDocumentos(){
        documentos.append(Documento( nome :  "RG"))
        documentos.append(Documento( nome :  "CPF"))
        documentos.append(Documento( nome :  "CNH"))
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentosViewCell", for: indexPath as IndexPath) as! DocumentosViewCell

        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        let documento = self.documentos[indexPath.item]
        cell.nome.text = documento.nome
        cell.nome.textColor = GMColor.whiteColor()
        let photoImage = UIImage(named: "ic_photo")
        cell.fileImage.image = photoImage
        if  selectedRow == indexPath.item {} else{
            let tapFileImage = UITapGestureRecognizer(target: self, action: #selector(tappedFileImage))
            cell.fileImage.addGestureRecognizer(tapFileImage)
            cell.fileImage.isUserInteractionEnabled = true
        }
        
        let cameraImage = UIImage(named: "ic_camera")
        cell.photoImage.image = cameraImage
        if  selectedRow == indexPath.item {} else{
            let tapPhotoImage = UITapGestureRecognizer(target: self, action: #selector(tappedPhotoImage))
            cell.photoImage.addGestureRecognizer(tapPhotoImage)
            cell.photoImage.isUserInteractionEnabled = true
        }
        
        if selectedRow == indexPath.item {
            cell.backgroundColor = GMColor.colorPrimary()
        }else {
            cell.backgroundColor = GMColor.backgroundHeaderColor()
        }
        
        cell.frame.size.height = ConstraintsView.heightHeaderApp()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.item
    }
    
    @objc func tappedPhotoImage(){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func tappedFileImage(){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
        print("canceled")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let url = info[UIImagePickerControllerReferenceURL] as? URL,
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                imageSelecionada = image
                print(url)
        }
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageSelecionada = chosenImage
        }
        dismiss(animated: true)
        visualizarImagem()
    }
    
    func visualizarImagem(){
        /*
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.modalPresentationStyle = .popover

        let imgViewTitle = UIImageView(frame: CGRect(x: 10, y: 10, width: 100  , height: 100))
        imgViewTitle.image = imageSelecionada
        alert.view.addSubview(imgViewTitle)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        
        self.present(alert, animated: true, completion: nil)
         
         
         let alert = ImagemAlertController(imagem: imageSelecionada!)
         alert.show(animated: true)
        */
        
        let alert = AlertController(title: "Imagem Selecionada", message: "Confirma a imagem", preferredStyle: .alert)
        alert.setTitleImage(imageSelecionada)
        // Add actions
        let action = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: nil))
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        self.tblProfissionalDocumentos.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentos.count
    }
   
    
}
