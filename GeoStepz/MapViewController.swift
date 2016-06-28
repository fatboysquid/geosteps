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
    var trips = TripsManager.getTrips()
    var currentTrip: Trip? = nil
    var recording = false
    let regionRadius: CLLocationDistance = 1000

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!

    @IBAction func stopButton(sender: UIButton) {
        print("stopButton button clicked")
        // a trip must consist of at least two locations
        if (currentTrip?.getLocations().count > 1) {
            print("trip consists of \(currentTrip?.getLocations().count) locations; adding...")

            let alert = UtilitiesHelper.getAlertInstance("Trip Ended", message: "Name your trip.", hasTextField: true, textFieldValue: "")

            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                let textField = alert.textFields![0] as UITextField
                print("OK clicked.")

                self.currentTrip!.setTitle(textField.text!)
                self.currentTrip!.setDateEnd(NSDate())
                TripsManager.addTrip(self.currentTrip!)
                self.mapReset();
            }))

            alert.addAction(UIAlertAction(title: "Later", style: .Default, handler: { (action) -> Void in
                print("Later clicked.")

                self.currentTrip!.setTitle("\(self.currentTrip!.getTitle()) \(TripsManager.getTrips().count + 1)")
                TripsManager.addTrip(self.currentTrip!)

                self.mapReset();
            }))

            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    //WIP: move to helper:
    func mapReset() {
        mapView.removeOverlays(mapView.overlays)
        currentTrip = nil
        recording = false
        locationManager.stopUpdatingLocation()
        stopRecordingButton.enabled = false
        startRecordingButton.setTitle("Start Trip", forState: .Normal)
    }

    @IBAction func startRecording(sender: AnyObject) {
        print("startRecording button clicked")
        stopRecordingButton.enabled = true

        // record button pressed
        if (!recording) {
            print("recording = true")
            recording = true
            locationManager.startUpdatingLocation()
            startRecordingButton.setTitle("Pause", forState: .Normal)

            if (currentTrip == nil) {
                print("currentTrip was nil, so creating one...")
                currentTrip = Trip()
            }
        // pause button pressed
        } else {
            print("recording = false")
            recording = false
            locationManager.stopUpdatingLocation()
            startRecordingButton.setTitle("Continue", forState: .Normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.mapView.delegate = self
        locationManager.distanceFilter = 15
        locationManager.requestAlwaysAuthorization()
        view.backgroundColor = UIColor.grayColor()
        stopRecordingButton.enabled = false
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
        MapsHelper.focusOnUpdatedLocation(mapView, cllocation: cllocation)
        MapsHelper.createPolyline(mapView, currentTrip: currentTrip!)
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
