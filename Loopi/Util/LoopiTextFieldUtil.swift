//
//  LoopiTextFieldUtil.swift
//  Loopi
//
//  Created by Loopi on 20/11/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class LoopiTextFieldUtil {
    class func maskCpf() -> String { return  "000.000.000-00" }
    class func maskCnpj() -> String { return  "00.000.000/0000-00" }
    
    class func isValidCNPJ(valor: String) -> Bool {
        let numbers = valor.characters.flatMap({Int(String($0))})
        print("isValidCNPJ : \(numbers) \n")
        guard numbers.count == 14 && Set(numbers).count != 1 else { return false }
        let soma1 = 11 - ( numbers[11] * 2 +
            numbers[10] * 3 +
            numbers[9] * 4 +
            numbers[8] * 5 +
            numbers[7] * 6 +
            numbers[6] * 7 +
            numbers[5] * 8 +
            numbers[4] * 9 +
            numbers[3] * 2 +
            numbers[2] * 3 +
            numbers[1] * 4 +
            numbers[0] * 5 ) % 11
        let dv1 = soma1 > 9 ? 0 : soma1
        let soma2 = 11 - ( numbers[12] * 2 +
            numbers[11] * 3 +
            numbers[10] * 4 +
            numbers[9] * 5 +
            numbers[8] * 6 +
            numbers[7] * 7 +
            numbers[6] * 8 +
            numbers[5] * 9 +
            numbers[4] * 2 +
            numbers[3] * 3 +
            numbers[2] * 4 +
            numbers[1] * 5 +
            numbers[0] * 6 ) % 11
        let dv2 = soma2 > 9 ? 0 : soma2
        return dv1 == numbers[12] && dv2 == numbers[13]
    }
    
    class func  isValidCPF(valor: String) -> Bool {
        let numbers = valor.characters.flatMap({Int(String($0))})
        print("isValidCPF : \(numbers) \n")
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        let soma1 = 11 - ( numbers[0] * 10 +
            numbers[1] * 9 +
            numbers[2] * 8 +
            numbers[3] * 7 +
            numbers[4] * 6 +
            numbers[5] * 5 +
            numbers[6] * 4 +
            numbers[7] * 3 +
            numbers[8] * 2 ) % 11
        let dv1 = soma1 > 9 ? 0 : soma1
        let soma2 = 11 - ( numbers[0] * 11 +
            numbers[1] * 10 +
            numbers[2] * 9 +
            numbers[3] * 8 +
            numbers[4] * 7 +
            numbers[5] * 6 +
            numbers[6] * 5 +
            numbers[7] * 4 +
            numbers[8] * 3 +
            numbers[9] * 2 ) % 11
        let dv2 = soma2 > 9 ? 0 : soma2
        return dv1 == numbers[9] && dv2 == numbers[10]
    }
    
    class func  mask(valorMask: String) -> String {
        var mask = ""
        let valor = unmask(string: valorMask)
        if (valor.count > 11){
            mask = maskCnpj()
        }else {
            mask = maskCpf()
        }
        let letterMaskCharacter: Character = "A"
        let numberMaskCharacter: Character = "0"
        
        if valor.count > mask.count {
            return valor
        }
        
        var formattedString = ""
        
        var currentMaskIndex = 0
        for i in 0..<valor.count {
            if currentMaskIndex >= mask.count {
                return valor
            }
            
            let currentCharacter = valor[valor.index(valor.startIndex, offsetBy: i)]
            var maskCharacter = mask[mask.index(valor.startIndex, offsetBy: currentMaskIndex)]
            
            if currentCharacter == maskCharacter {
                formattedString.append(currentCharacter)
            } else {
                while (maskCharacter != letterMaskCharacter && maskCharacter != numberMaskCharacter) {
                    formattedString.append(maskCharacter)
                    
                    currentMaskIndex += 1
                    maskCharacter = mask[mask.index(valor.startIndex, offsetBy: currentMaskIndex)]
                }
                
                let isValidLetter = maskCharacter == letterMaskCharacter && isValidLetterCharacter(character: currentCharacter)
                let isValidNumber = maskCharacter == numberMaskCharacter && isValidNumberCharacter(character: currentCharacter)
                
                if !isValidLetter && !isValidNumber {
                    return valor
                }
                
                formattedString.append(currentCharacter)
            }
            
            currentMaskIndex += 1
        }
        
        return formattedString
    }
    
    class func  unmask(string: String) -> String {
        
        var unmaskedValue = ""
        
        for character in string {
            if isValidLetterCharacter(character: character) || isValidNumberCharacter(character: character) {
                unmaskedValue.append(character)
            }
        }
        
        return unmaskedValue
    }
    
    class func  isValidLetterCharacter(character: Character) -> Bool {
        
        let string = String(character)
        if string.unicodeScalars.count > 1 {
            return false
        }
        
        let lettersSet = NSCharacterSet.letters
        let unicodeScalars = string.unicodeScalars
        return lettersSet.contains(unicodeScalars[unicodeScalars.startIndex])
    }
    
    class func isValidNumberCharacter(character: Character) -> Bool {
        
        let string = String(character)
        if string.unicodeScalars.count > 1 {
            return false
        }
        
        let lettersSet = NSCharacterSet.decimalDigits
        let unicodeScalars = string.unicodeScalars
        return lettersSet.contains(unicodeScalars[unicodeScalars.startIndex])
    }
}
