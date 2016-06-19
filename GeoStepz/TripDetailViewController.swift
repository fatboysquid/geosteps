//
//  TripDetailViewController.swift
//  GeoStepz
//
//  Created by Lee, Sang on 1/5/16.
//  Copyright © 2016 Sang Lee. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class TripDetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var currentTrip:Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let unWrappedTrip = currentTrip {
            print("here is the current trip")
            print(unWrappedTrip)
        }
    }
}
