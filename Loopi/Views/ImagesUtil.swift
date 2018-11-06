//
//  ImagesUtil.swift
//  Loopi
//
//  Created by Loopi on 31/10/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class ImagesUtil {
    class func defaultCheckBoxButtonImage(full: Bool,sizeImage: Int , sizeUIImage: Int  ) -> UIImage {
        var defaultRadioButtonEmptyImage = UIImage()
        UIGraphicsBeginImageContextWithOptions(CGSize(width: sizeUIImage, height: sizeUIImage), false, 0.0)
        GMColor.colorAccent().setFill()
        //GMColor.colorRadioAndCheckButtonFill().setFill()
        UIBezierPath(rect: CGRect(x: 5, y: 5, width: sizeImage, height: sizeImage)).fill()
        if full {
            GMColor.whiteColor().setFill()
            UIBezierPath(rect: CGRect(x: 10, y: 10, width: 10, height: 10)).fill()
            GMColor.colorPrimary().setFill()
            UIBezierPath(rect: CGRect(x: 11.5, y: 11.5, width: 7, height: 7)).fill()
        }
        
        defaultRadioButtonEmptyImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return defaultRadioButtonEmptyImage;
    
    }

 
}
