//
//  Navigatable.swift
//  Loopi
//
//  Created by Loopi on 30/10/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

protocol Navigatable {
    /// Storyboard name where this view controller exists.
    static var storyboardName: String { get }
    
    
    /// Storyboard Id of this view controller.
    static var storyboardId: String { get }
    
    /// Returns a new instance created from Storyboard identifiers.
    static func instantiateFromStoryboard() -> Self
}
