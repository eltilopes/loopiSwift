//
//  DirectionUtilsRest.swift
//  Loopi
//
//  Created by Loopi on 12/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class GoogleDirectionsRest{
    
    var googleDirectionsResponse : GoogleDirectionsResponse?
    
    @discardableResult
    func getGoogleDirectionsResponse(start :LatLng ,end : LatLng, completionHandler: @escaping (GoogleDirectionsResponse?, NSError?) -> Void ) -> URLSessionTask {
        
        let url1 : String = "https://maps.googleapis.com/maps/api/directions/json?"
        let url2 : String = "origin=\(start.lat ?? 0),\(start.lng ?? 0)"
        let url3 : String = "&destination=\(end.lat ?? 0),\(end.lng ?? 0)"
        let url4 : String = "&sensor=false&units=metric&mode=driving&key=AIzaSyCXuNEWDOjSXCoQbDyl8dd-Xobe-4vwaGM"
        let url : String = url1 + url2 + url3 + url4
        let myURL = NSURL(string: url)!
        
        let request = NSMutableURLRequest(url: myURL as URL)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in
            if error != nil {
                return
            }
            
            
            let jsonString = String(data: data!, encoding: .utf8)
            self.googleDirectionsResponse = GoogleDirectionsResponse.deserialize(from: jsonString!)!
            print(self.googleDirectionsResponse?.getDistance() as Any)
            print(self.googleDirectionsResponse?.getDuration() as Any)
            print(self.googleDirectionsResponse?.getDistanceMeters() ?? 0)
            
        }
        task.resume()
        return task
    }
}


