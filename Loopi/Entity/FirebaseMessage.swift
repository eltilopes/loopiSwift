//
//  FirebaseMessage.swift
//  Loopi
//
//  Created by Loopi on 04/07/18.
//  Copyright © 2018 Loopi. All rights reserved.
//


import UIKit
import HandyJSON

class FirebaseMessage : HandyJSON {
    required init() {}
    
    var from : String?
    var click_action : String?
    var titulo : String?
    var descricao : String?
    var collapse_key : String?
    var firebaseMessageNotification : FirebaseMessageNotification = FirebaseMessageNotification()
    
}



