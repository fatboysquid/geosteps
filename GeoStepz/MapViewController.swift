//
//  MapViewController.swift
//  GeoStepz
//
//  Created by Lee, Sang on 1/5/16.
//  Copyright © 2016 Sang Lee. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var locationManager: CLLocationManager!
    var locationsVisited = [[CLLocation]]()
    var trips = [[[CLLocation]]]()
    var recording = false
    let regionRadius: CLLocationDistance = 1000
    
    //@IBOutlet weak var distanceReading: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var startRecordingButton: UIButton!
    
    @IBAction func startRecording(sender: AnyObject) {
        recording = !recording;
        startRecordingButton.setTitle(recording ? "STOP RECORDING" : "START RECORDING", forState: .Normal)
        if (recording) {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
            trips.append(locationsVisited)
            print("locations visited count: ")
            print(locationsVisited.count)
            locationsVisited = []
            
            print(trips.count)
            print(trips)
        }
        print(recording)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.map.delegate = self
        locationManager.distanceFilter = 15
        locationManager.requestAlwaysAuthorization()
        print("viewDidLoad")
        view.backgroundColor = UIColor.grayColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    //do stuff
                    print("didChangeAuthorizationStatus")
                    startScanning()
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if beacons.count > 0 {
            print("didRangeBeacons 1")
            let beacon = beacons[0]
            updateDistance(beacon.proximity)
        } else {
            print("didRangeBeacons 2")
            updateDistance(.Unknown)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        //locationManager.stopUpdatingLocation()
        print("didFailWithError")
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        locationsVisited.append(locations)
        focusOnUpdatedLocation(locations)
        createPolyline(map)
    }
    
    func focusOnUpdatedLocation(location: [CLLocation]) {
        let coordinate = location[0].coordinate;
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
        self.map.setRegion(region, animated: true)
    }
    
    func startScanning() {
        print("startScanning")
        let uuid = NSUUID(UUIDString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    func updateDistance(distance: CLProximity) {
        print("updateDistance")
        print(distance)
        UIView.animateWithDuration(0.8) { [unowned self] in
            switch distance {
            case .Unknown:
                self.view.backgroundColor = UIColor.grayColor()
                //self.distanceReading.text = "UNKNOWN"
                
            case .Far:
                self.view.backgroundColor = UIColor.blueColor()
                //self.distanceReading.text = "FAR"
                
            case .Near:
                self.view.backgroundColor = UIColor.orangeColor()
                //self.distanceReading.text = "NEAR"
                
            case .Immediate:
                self.view.backgroundColor = UIColor.redColor()
                //self.distanceReading.text = "RIGHT HERE"
            }
        }
    }
    
    func createPolyline(mapView: MKMapView) {
        print("createPolyline")
        var locationsVisitedCoordinates = [CLLocationCoordinate2D]()

        for i in locationsVisited {
            locationsVisitedCoordinates.append(i[0].coordinate)
            print(i[0].coordinate.dynamicType)
        }

        weak var polylinePathOverlay: MKGeodesicPolyline? = MKGeodesicPolyline(coordinates: &locationsVisitedCoordinates, count: locationsVisitedCoordinates.count)
        map.removeOverlays(map.overlays)

        if (polylinePathOverlay != nil) {
            print("should have removed")
            map.addOverlay(polylinePathOverlay!)
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
