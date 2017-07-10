//
//  LocationManager.swift
//  rtcGame
//
//  Created by HsinChih Yang on 27/06/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    
    // MARK: - Variable
    var locationManager         : CLLocationManager!
    var nowLocation             : CLLocation!
    var nowPlaceMark            : CLPlacemark?
    var isFirstLocationReceived : Bool!
    
    // MARK: - Singleton
    class var sharedInstance : LocationManager{
        struct Singleton {
            static let instance = LocationManager()
        }
        return Singleton.instance
    }
    
    // MARK: - Init
    override init() {
        //
        locationManager = CLLocationManager()
        isFirstLocationReceived = true
    }
    
    // MARK: - Ask Permission
    func requestWhenInUse() {
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.activityType = .other
        locationManager.delegate     = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestAlwaysInUse() {
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.activityType = .other
        locationManager.delegate     = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    // MARK: - Function
    func start() {
        locationManager.startUpdatingLocation()
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
    }
    
    func getLocation() -> String {
        
        if isFirstLocationReceived == true {
            return "UNKNOW"
        }
        let lati = nowLocation.coordinate.latitude
        let long = nowLocation.coordinate.longitude
        //        let alti = nowLocation.altitude
        
        return String().appendingFormat("(%3f,%3f)", lati, long)
    }
    
    func getCountry() -> String {
        
        if isFirstLocationReceived == true || nowPlaceMark == nil {
            return "UNKNOW"
        }
        
        let country = (nowPlaceMark?.country)!
        
        return country
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Receive Data
        nowLocation = locations.last
        isFirstLocationReceived = false
        
        // Get Place Mark
        CLGeocoder().reverseGeocodeLocation(nowLocation) { (placeMarks, error) in
            //
            self.nowPlaceMark = placeMarks?.first
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        //
        if newHeading.headingAccuracy < 0 {
            print("QQ")
        }
        print(">>way is \(newHeading.magneticHeading) ")
    }
}
