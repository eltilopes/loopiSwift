//
//  LoopiTextField.swift
//  Loopi
//
//  Created by Loopi on 11/04/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit
import Foundation

public enum ValidationLoopiTextFieldType {
    case OBRIGATORIO
    case NUMERO
    case EMAIL
    case NOME_COMPLETO
    case CODIGO_CONVITE
    case CODIGO_ALTERAR_SENHA
    case CPF_CNPJ
    case SENHA
}

@IBDesignable
class LoopiTextField: UITextField,UITextFieldDelegate {
    
    @IBInspectable var labelString: String = ""
    @IBInspectable var maskString: String = ""
    @IBInspectable var horizontalInset: CGFloat = 0
    @IBInspectable var verticalInset: CGFloat = 0
    @IBInspectable var tamanhoCampo: Int = 100
    var alignment: NSTextAlignment = .left
    var backgroundColorLoopiTextField = GMColor.backgroundAppColor()
    var borderColorLoopiTextField = GMColor.whiteColor().cgColor
    var fontLoopiTextField = UIFont.boldSystemFont(ofSize: ConstraintsView.fontMedium())
    var textColorLoopiTextField: UIColor = GMColor.textColorPrimary()
    var keyboardTipo : UIKeyboardType = .default
    var textFieldDidEndEditing = false
    var instanceController = false
    var secureTextEntry = false
    var editavel = false
    var existeErro = false
    var erro = ""
    var label = UILabel()
    var error = UILabel()
    var validations : [ValidationLoopiTextFieldType] = []
    func createBorder(){
        self.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.layer.borderColor = borderColorLoopiTextField
        self.layer.borderWidth = CGFloat(ConstraintsView.widthBorderLoopiTextField())
        self.backgroundColor = backgroundColorLoopiTextField
    }
    
    fileprivate func setTitleLabel() {
        if editavel {
            
            if validations.contains(.CPF_CNPJ){
                self.isEnabled = false
                self.isUserInteractionEnabled = false
                //self.textColorLoopiTextField = GMColor.colorPrimaryDark()
                self.alpha = 0.6
                //self.textColor = GMColor.textColorLoopiTextFieldDisable()
                //self.tintColor = GMColor.textColorLoopiTextFieldDisable()
                label.text = labelString
            }else{
                var image = UIImage(named:StringValues.iconeEditar)!
                image.withRenderingMode(.alwaysTemplate)
                image = image.tint(with: GMColor.colorPrimaryDark())
                let attachment = NSTextAttachment()
                attachment.image = image
                let attachmentString = NSAttributedString(attachment: attachment)
                let myString = NSMutableAttributedString(string: labelString)
                myString.append(attachmentString)
                label.attributedText = myString
            }
        }else if validations.contains(.SENHA) {
            let nomeIcone = secureTextEntry ? StringValues.iconeMostrar :  StringValues.iconeOcultar
            var image = UIImage(named:nomeIcone)!
            image.withRenderingMode(.alwaysTemplate)
            let tintIcone = secureTextEntry ? GMColor.colorPrimary() : GMColor.textColorLoopiTextFieldDisable()
            image = image.tint(with: tintIcone)
            let attachment = NSTextAttachment()
            attachment.image = image
            let attachmentString = NSAttributedString(attachment: attachment)
            let myString = NSMutableAttributedString(string: labelString)
            myString.append(attachmentString)
            self.isSecureTextEntry = self.secureTextEntry
            label.attributedText = myString
            
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction))
            label.addGestureRecognizer(gestureRecognizer)
        }else{
            label.text = labelString
        }
    }
    
   
    @objc func tapAction()  {
        setSecureTextEntry(secureTextEntry: !self.secureTextEntry)
        setTitleLabel()
    }
    
    func setTitle() {
        self.delegate = self
        let widthTextField = frame.size.width
        let heightTextField = frame.size.height - CGFloat((2 * ConstraintsView.widthBorderLoopiTextField()))
        label.frame = CGRect(x:0, y: -(heightTextField), width: widthTextField , height:heightTextField)
        label.textAlignment = alignment
        setTitleLabel()
        label.font = fontLoopiTextField
        label.tintColor = textColorLoopiTextField
        label.textColor = textColorLoopiTextField
        self.keyboardType = keyboardTipo
        self.leftViewMode = UITextFieldViewMode.always
        self.leftView = label
    
    }
    
    func setTitle(frameLoopiTextField : CGRect) {
        self.delegate = self
        label.frame = frameLoopiTextField
        label.textAlignment = alignment
        setTitleLabel()
        label.font = fontLoopiTextField
        label.tintColor = textColorLoopiTextField
        label.textColor = textColorLoopiTextField
        self.keyboardType = keyboardTipo
        self.leftViewMode = UITextFieldViewMode.always
        self.leftView = label
        textRect(forBounds: frameLoopiTextField)
    }
    
    func setFontLoopiTextField(fontLoopiTextField : UIFont) {
        self.fontLoopiTextField = fontLoopiTextField
    }
    
    func setKeyboardType(keyboardTipo : UIKeyboardType) {
        self.keyboardTipo = keyboardTipo
    }
    
    func setInstanceController(instanceController : Bool) {
        self.instanceController = instanceController
    }
    
    func setSecureTextEntry(secureTextEntry : Bool) {
        self.secureTextEntry = secureTextEntry
    }
    
    func setEditavel(editavel : Bool) {
        self.editavel = editavel
    }
    
    func setAlignmentTitle(alignment : NSTextAlignment) {
        self.alignment = alignment
    }
    
    func setBackgroundColorLoopiTextField(backgroundColorLoopiTextField : UIColor) {
        self.backgroundColorLoopiTextField = backgroundColorLoopiTextField
    }
    
    func setBorderColorLoopiTextField(borderColorLoopiTextField : CGColor) {
        self.borderColorLoopiTextField = borderColorLoopiTextField
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset , dy: verticalInset)
    }
    
    func setError(erro : String) {
        setError(erro : erro, widthTextField: frame.size.width , heightTextField:frame.size.height , y:frame.size.height)
    }
    
    func setError(erro : String, widthTextField: CGFloat , heightTextField:CGFloat, y:CGFloat) {
        self.erro = erro
        error.frame = CGRect(x:0, y: y, width: widthTextField , height:heightTextField)
        error.textAlignment = NSTextAlignment.right
        error.text = self.erro
        error.font = UIFont.italicSystemFont(ofSize: 16.0)
        error.textColor = GMColor.textColorError()
        self.rightViewMode = UITextFieldViewMode.always
        self.rightView = error
        
        
    }
    
  
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        self.delegate = self
        createBorder()
        self.font = UIFont.systemFont(ofSize: ConstraintsView.fontMedium())
        setTitle()
        return bounds.insetBy(dx: horizontalInset , dy: verticalInset)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if validations.contains(.CPF_CNPJ) {
            if  error.text?.isEmptyAndContainsNoWhitespace() ?? true {
                textField.text? = LoopiTextFieldUtil.mask(valorMask: textField.text!)
            }else{
                textField.text? = LoopiTextFieldUtil.unmask(string: textField.text!)
            }
        }
        textFieldDidEndEditing = true
        if instanceController {
           textDidEndEditing(erro: error.text!)
        }
    }
    
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let value : String = self.text!
        if validations.contains(.OBRIGATORIO){
            if value.isEmptyAndContainsNoWhitespace() {
                erro = "Campo Obrigatorio"
            }else{
                erro = ""
            }
        }
        if validations.contains(.EMAIL){
            let nameReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let nameTest = NSPredicate(format: "SELF MATCHES %@", nameReg)
            if value.isNotEmptyAndContainsNoWhitespace() && nameTest.evaluate(with: value) == false{
                erro = "Informe E-mail valido"
            }
        }
        if validations.contains(.NUMERO){
            print(value.matches("^[0-9]{8}$"))
            if  value.isNotEmptyAndContainsNoWhitespace() && ((value as NSString).rangeOfCharacter(from: NSCharacterSet.decimalDigits).location == NSNotFound){
                erro = "Campo Numerico"
                self.text?.removeLast()
            }
        }
        if validations.contains(.NOME_COMPLETO){
            if  value.isNotEmptyAndContainsNoWhitespace() {
                let nameArray: [String] = value.split { $0 == " " }.map { String($0) }
                if (nameArray.count <= 2) {
                    erro = "Nome Completo Invalido"
                }
            }
        }
        
        if validations.contains(.CODIGO_CONVITE){
            if  value.isNotEmptyAndContainsNoWhitespace() && !(value.count == 8) {
                erro = "Codigo do Convite Invalido"
            }
        }
        
        if validations.contains(.CODIGO_ALTERAR_SENHA){
            if  value.isNotEmptyAndContainsNoWhitespace() && !value.isAlphaNumeric(tamanhoCampo: 6) {
                erro = "Codigo de Alteracao Invalido"
            }
        }
        
        if validations.contains(.SENHA){
            if  value.isNotEmptyAndContainsNoWhitespace() && !value.isAlphaNumeric(tamanhoCampo: 8) {
                erro = "Senha Invalido"
            }
        }
        
        if validations.contains(.CPF_CNPJ){
            //let valor = value.unmask(string: value)
            if  !(cpfCnpjValido(valor: value)) {
                erro = "CPF ou CNPJ Invalido"
            }
        }
        
       
        if value.isNotEmptyAndContainsNoWhitespace() && value.count > tamanhoCampo{
            self.text?.removeLast()
        }
        if textFieldDidEndEditing {
            textDidEndEditing(erro: erro)
        }
        setError(erro: erro)
        return bounds.insetBy(dx: horizontalInset , dy: verticalInset)
    }
   
    func textDidEndEditing(erro : String) {
        self.existeErro = erro.isNotEmptyAndContainsNoWhitespace()
        textColorLoopiTextField = erro.isEmptyAndContainsNoWhitespace() ? GMColor.textColorPrimary() :  GMColor.textColorError()
        textFieldDidEndEditing = false
        setTitle()
        setError(erro: "")
    }
    
    
    func cpfCnpjValido(valor: String) -> Bool {
        let unmaskValor = LoopiTextFieldUtil.unmask(string: valor)
        if (unmaskValor.count == 11){
            return LoopiTextFieldUtil.isValidCPF(valor:unmaskValor)
        }else if (unmaskValor.count ==  14){
            return LoopiTextFieldUtil.isValidCNPJ(valor:unmaskValor)
        }
        return false
    }
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
}

extension String {
   
    func isEmptyAndContainsNoWhitespace() -> Bool {
        guard self.isEmpty, self.trimmingCharacters(in: .whitespaces).isEmpty, self.isBlank()
            else {
                return false
        }
        return true
    }
    
    func isNotEmptyAndContainsNoWhitespace() -> Bool {
        return !isEmptyAndContainsNoWhitespace()
    }
    
    func isBlank() -> Bool {
        return self.trimmingCharacters(in: .whitespaces) == ""
    }
    
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    func isAlphaNumeric(tamanhoCampo: Int) -> Bool {
        let regex = "^(?=.*[A-Z])(?=.*\\d)[A-Z\\d]{\(tamanhoCampo),}$"
        let rang = range(of: regex, options: .regularExpression)
        let retorno = rang == nil
        print(regex)
        print(rang)
        print(retorno)
        return retorno
    }
    
    func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(encodedOffset: index)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}
