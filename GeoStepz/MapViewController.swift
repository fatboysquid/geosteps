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
    //var locationsVisited = [[CLLocation]]()
    //var trips = [[[CLLocation]]]()
    //var tripsManager = TripsManager.tripsManager
    var trips = TripsManager.getTrips()
    var currentTrip: Trip? = nil
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
            if (currentTrip == nil) {
                print("currentTrip was nil")
                currentTrip = Trip()
                print("created a new trip: ")
                print(currentTrip)
            }
        } else {
            locationManager.stopUpdatingLocation()
            //trips.append(locationsVisited)
            //currentTrip?.addCLLocation(<#T##cllocation: [CLLocation]##[CLLocation]#>)
            print("locations visited count: ")
            TripsManager.addTrip(currentTrip!)
            //print(locationsVisited.count)
            //locationsVisited = []
            //print(trips.count)
            //print(trips)
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

            //let dbStubDataJSON = "[{\"id\":\"2982938\",\"title\":\"Las Vegas\",\"description\":\"Spring break 2016!\",\"locations\":[[\"serializedCLLocationData1\",\"serializedCLLocationData2\"]],\"datetime\":\"April 20, 2016\",\"comments\":[{\"id\":\"12345\",\"datetime\":\"April 20, 2016\",\"avatar\":\"http://geosnapscdn.com/somepath\",\"body\":\"Nice trip!\"}],\"photos\":[\"http://geosnapscdn.com/somepath\",\"http://geosnapscdn.com/somepath\"]},{\"id\":\"2922938\",\"title\":\"New York\",\"description\":\"Bachelor party!\",\"locations\":[[\"serializedCLLocationData1\",\"serializedCLLocationData2\"]],\"datetime\":\"April 25, 2016\",\"comments\":[{\"id\":\"67890\",\"datetime\":\"April 25, 2016\",\"avatar\":\"http://geosnapscdn.com/somepath\",\"body\":\"Nice trip!\"}],\"photos\":[\"http://geosnapscdn.com/somepath\",\"http://geosnapscdn.com/somepath\"]}]"
        //print(TripsManager.tripsManager.convertJSONToDictionary(dbStubDataJSON))
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

    func locationManager(manager: CLLocationManager, didUpdateLocations cllocation: [CLLocation]) {
        print("didUpdateLocations")
        let location = Location(cllocation: cllocation)
        currentTrip?.addLocation(location)
        //locationsVisited.append(locations)
        focusOnUpdatedLocation(cllocation)
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
        var locationCoordinates = [CLLocationCoordinate2D]()
        let locations = currentTrip?.getLocations()

        for i in locations! {
            let locationCoordinate = i.getCLLocation()[0].coordinate
            locationCoordinates.append(locationCoordinate)
            print(locationCoordinate.dynamicType)
        }

        weak var polylinePathOverlay: MKGeodesicPolyline? = MKGeodesicPolyline(coordinates: &locationCoordinates, count: locationCoordinates.count)
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
