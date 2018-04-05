//
//  Usage.swift
//  Loopi
//
//  Created by Loopi on 07/02/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import Foundation

enum API {}

extension API {
    static func getCustomer() -> Endpoint<Customer> {
        return Endpoint(path: "oauth/token")
    }
    
    static func patchCustomer(name: String) -> Endpoint<Customer> {
        return Endpoint(
            method: .patch,
            path: "oauth/token",
            parameters: ["name" : name]
        )
    }
}

final class Customer: Decodable {
    let name: String
}


// MARK: Using Endpoints

func test() {
    let client = Client(accessToken: "<access_token>")
    _ = client.request(API.getCustomer())
    _ = client.request(API.patchCustomer(name: "Alex"))
}

