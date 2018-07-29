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
    
    var label = UILabel()
    var error = UILabel()
    var validations : [ValidationLoopiTextFieldType] = []
    
    func createBorder(){
        self.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.layer.borderColor = borderColorLoopiTextField
        self.layer.borderWidth = CGFloat(ConstraintsView.widthBorderLoopiTextField())
        self.backgroundColor = backgroundColorLoopiTextField
    }
    
    func setTitle() {
        let widthTextField = frame.size.width
        let heightTextField = frame.size.height - CGFloat((2 * ConstraintsView.widthBorderLoopiTextField()))
        label.frame = CGRect(x:0, y: -(heightTextField), width: widthTextField , height:heightTextField)
        label.textAlignment = alignment
        label.text = labelString
        label.font = fontLoopiTextField
        label.tintColor = GMColor.textColorPrimary()
        self.leftViewMode = UITextFieldViewMode.always
        self.leftView = label
    }
    
    func setTitle(frameLoopiTextField : CGRect) {
        label.frame = frameLoopiTextField
        label.textAlignment = alignment
        label.text = labelString
        label.font = fontLoopiTextField
        label.tintColor = GMColor.textColorPrimary()
        self.leftViewMode = UITextFieldViewMode.always
        self.leftView = label
        textRect(forBounds: frameLoopiTextField)
    }
    
    func setFontLoopiTextField(fontLoopiTextField : UIFont) {
        self.fontLoopiTextField = fontLoopiTextField
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
    
    func setError(erro : String) {
        let widthTextField = frame.size.width
        let heightTextField = frame.size.height
        error.frame = CGRect(x:0, y: heightTextField, width: widthTextField , height:heightTextField)
        error.textAlignment = NSTextAlignment.right
        error.text = erro
        error.font = UIFont.italicSystemFont(ofSize: 16.0)
        error.textColor = GMColor.textColorError()
        self.rightViewMode = UITextFieldViewMode.always
        self.rightView = error
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        self.delegate = self
        createBorder()
        self.font = UIFont.systemFont(ofSize: ConstraintsView.fontSmall())
        setTitle()
        return bounds.insetBy(dx: horizontalInset , dy: verticalInset)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        setError(erro: "")
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset , dy: verticalInset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let value : String = self.text!
        var erro = ""
        
        if validations.contains(.EMAIL){
            let nameReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let nameTest = NSPredicate(format: "SELF MATCHES %@", nameReg)
            if value.isNotEmptyAndContainsNoWhitespace() && nameTest.evaluate(with: value) == false{
                erro = "Informe E-mail valido"
            }
        }
        if validations.contains(.NUMERO){
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
    
        if validations.contains(.OBRIGATORIO){
            if value.isEmptyAndContainsNoWhitespace() {
                erro = "Campo Obrigatorio"
            }
        }
        if value.isNotEmptyAndContainsNoWhitespace() && value.count > tamanhoCampo{
            self.text?.removeLast()
        }
        setError(erro: erro)
        return bounds.insetBy(dx: horizontalInset , dy: verticalInset)
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
}
