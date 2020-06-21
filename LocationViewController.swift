//
//  LocationViewController.swift
//  ForeignExchange
//
//  Created by Andrey Rusinovich on 21.06.2020.
//  Copyright © 2020 Andrey Rusinovich. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var mapView: MKMapView!
    var region: MKCoordinateRegion!
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.startMonitoringSignificantLocationChanges()
        
        locationManager.requestLocation()
        
        mapView = MKMapView()
        view = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
}
