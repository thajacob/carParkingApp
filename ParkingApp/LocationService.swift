//
//  LocationService.swift
//  ParkingApp
//
//  Created by jakub skrzypczynski on 14/03/2017.
//  Copyright © 2017 test project. All rights reserved.
//

import Foundation
import CoreLocation


class LocationService: NSObject,CLLocationManagerDelegate {
    static let instance = LocationService()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        self.currentLocation = locationManager.location?.coordinate
    }
    
    
    
}


