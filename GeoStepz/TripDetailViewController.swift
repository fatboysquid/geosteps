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
    var locationManager: CLLocationManager!
    var currentTrip:Trip?
    let regionRadius: CLLocationDistance = 1000

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.mapView.delegate = self
        locationManager.distanceFilter = 15
        locationManager.requestAlwaysAuthorization()
        view.backgroundColor = UIColor.grayColor()

        if currentTrip != nil {
            print("here is the current trip")
            /*
            let locations = currentTrip!.getLocations()
            let firstCLLocation = locations[0].getCLLocation()
            print("consists of \(locations.count) locations")
            */
            MapsHelper.createPolyline(mapView, currentTrip: currentTrip!)
            MapsHelper.adjustZoomToFitAllLocations(mapView)
            //MapsHelper.focusOnUpdatedLocation(mapView, cllocation: firstCLLocation)
        }
    }

    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer()
        }

        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.lineWidth = 2.0
        renderer.alpha = 0.5
        renderer.strokeColor = UIColor.blueColor()

        return renderer
    }
}
