//
//  BackgroundLocationManager.swift
//  Loopi
//
//  Created by Loopi on 17/04/18.
//  Copyright © 2018 Loopi. All rights reserved.
//
import Foundation
import CoreLocation
import UIKit

class BackgroundLocationManager :NSObject, CLLocationManagerDelegate {
    
    static let instance = BackgroundLocationManager()
    /*
    static let BACKGROUND_TIMER = 15.0 // restart location manager every 150 seconds
    static let UPDATE_SERVER_INTERVAL = 60 * 5 // 5 minutes server send
    */
    static let BACKGROUND_TIMER = 1.0 // restart location manager every 150 seconds
    static let UPDATE_SERVER_INTERVAL = 2 // 5 minutes server send
    
    let locationManager = CLLocationManager()
    var timer:Timer?
    var currentBgTaskId : UIBackgroundTaskIdentifier?
    var lastLocationDate : NSDate = NSDate()
    
    private override init(){
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.activityType = .other;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        if #available(iOS 9, *){
            locationManager.allowsBackgroundLocationUpdates = true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    @objc func applicationEnterBackground(){
        //   FileLogger.log("applicationEnterBackground")
        start()
    }
    
    func start(){
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            if #available(iOS 9, *){
                locationManager.requestLocation()
            } else {
                locationManager.startUpdatingLocation()
            }
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    @objc func restart (){
        timer?.invalidate()
        timer = nil
        start()
    }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.restricted: break
        //log("Restricted Access to location")
        case CLAuthorizationStatus.denied: break
        //log("User denied access to location")
        case CLAuthorizationStatus.notDetermined: break
        //log("Status not determined")
        default:
            //log("startUpdatintLocation")
            if #available(iOS 9, *){
                locationManager.requestLocation()
            } else {
                locationManager.startUpdatingLocation()
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if(timer==nil){
            // The locations array is sorted in chronologically ascending order, so the
            // last element is the most recent
            guard locations.last != nil else {return}
            
            beginNewBackgroundTask()
            locationManager.stopUpdatingLocation()
            let now = NSDate()
            if(isItTime(now: now)){
                //TODO: Every n minutes do whatever you want with the new location. Like for example sendLocationToServer(location, now:now)
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        
        beginNewBackgroundTask()
        locationManager.stopUpdatingLocation()
    }
    
    func isItTime(now:NSDate) -> Bool {
        let timePast = now.timeIntervalSince(lastLocationDate as Date)
        let intervalExceeded = Int(timePast) > BackgroundLocationManager.UPDATE_SERVER_INTERVAL
        return intervalExceeded;
    }
    
    func sendLocationToServer(location:CLLocation, now:NSDate){
        //TODO
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
    }
    
    func beginNewBackgroundTask(){
        var previousTaskId = currentBgTaskId;
        currentBgTaskId = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            // FileLogger.log("task expired: ")
        })
        if let taskId = previousTaskId{
            UIApplication.shared.endBackgroundTask(taskId)
            previousTaskId = UIBackgroundTaskInvalid
        }
        
        timer = Timer.scheduledTimer(timeInterval: BackgroundLocationManager.BACKGROUND_TIMER, target: self, selector: #selector(self.restart),userInfo: nil, repeats: false)
    }
}
