//
//  ViewController.swift
//  ParkingApp
//
//  Created by jakub skrzypczynski on 14/03/2017.
//  Copyright © 2017 test project. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController {
    @IBOutlet weak var ParkBtn: RoundButton!

    @IBOutlet weak var mapView: MKMapView!
    
    var parkedCarAnnotation: ParkingSpot?
    var regionsRadius: CLLocationDistance = 500
    
    override func viewDidLoad() {

        super.viewDidLoad()
        mapView.delegate = self
        checkLocationAuthorizationStatus()
        
        
        }
    
    @IBAction func parkBtnWasPressed(_ sender: Any) {
        if mapView.annotations.count == 1 {
            mapView.addAnnotation(parkedCarAnnotation!)
            ParkBtn.setImage(UIImage(named:"foundCar.png"), for: .normal)
        }else{
            mapView.removeAnnotations(mapView.annotations)
            ParkBtn.setImage(UIImage(named:"parkCar.png"), for: .normal)
            
        }
        centerMapOnLocation(location: LocationService.instance.locationManager.location!)
    }
    
        
        
        
    
    
    
    

    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            LocationService.instance.locationManager.delegate = self
            
            LocationService.instance.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            LocationService.instance.locationManager.startUpdatingLocation()
        } else {
           LocationService.instance.locationManager.requestWhenInUseAuthorization()
            
        }
        
        }
    func centerMapOnLocation(location: CLLocation) {
        let cooridnateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionsRadius * 2.0, regionsRadius * 2.0)
        mapView.setRegion(cooridnateRegion, animated: true)
        
        
    }
    
    
    }

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation:MKAnnotation) ->
        MKAnnotationView? {
            if let annotation = annotation as? ParkingSpot {
                let identifier = "pin"
                var view: MKPinAnnotationView
                
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.animatesDrop = true
                view.pinTintColor = UIColor.orange
                
                view.calloutOffset = CGPoint(x: -8, y: -3)
                view.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure) as UIView
                return view
            } else {
                return nil
            }
      }

     @objc(mapView:annotationView:calloutAccessoryControlTapped:) func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped calloutAccessoryControlTappedcontrol: UIControl) {
        
        
        
       // let location = view.annotation as! ParkingSpot
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        let url = URL(string: "comgooglemaps://?center=40.765819,-73.975866&zoom=14&views=traffic")! 
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Can't use comgooglemaps://");
        }
        
        
       // location.mapItem(location: (parkedCarAnnotation?.coordinate)!).openInMaps(launchOptions:launchOptions)
        
        
        
        
        
        
    }

    
    
}
    extension ViewController: CLLocationManagerDelegate{
        
        func mapView(_ mapView: MKMapView, didUpdate UserLocation: MKUserLocation) {
            
            centerMapOnLocation(location: CLLocation(latitude:
                UserLocation.coordinate.latitude, longitude: UserLocation.coordinate.longitude))
            let locationServiceCoordinate = LocationService.instance.locationManager.location!.coordinate
            
            parkedCarAnnotation = ParkingSpot(title: "My Parking Spot", locationName: "Tap the 'i' for GPS", coordinate: CLLocationCoordinate2D(latitude: locationServiceCoordinate.latitude, longitude: locationServiceCoordinate.longitude))
            
        }
        
        
        
    }
    
    










