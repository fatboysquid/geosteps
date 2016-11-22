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
    @IBOutlet weak var tripNameButton: UIButton!
    @IBAction func tripNameButton(sender: AnyObject) {
        let alert = UtilitiesHelper.getAlertInstance(self, title: "Name", message: "", hasTextField: true, textFieldValue: currentTrip!.getTitle(), type: "custom")
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            print("OK clicked.")

            self.currentTrip!.setTitle(textField.text!)
            self.tripNameButton.setTitle(self.currentTrip!.getTitle(), forState: UIControlState.Normal)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action) -> Void in
            print("Cancel clicked.")
        }))
    }
    @IBOutlet weak var tripDateButton: UIButton!
    @IBAction func tripDateButton(sender: AnyObject) {
        let dateString = "\(currentTrip!.getDateStart()) - \(currentTrip!.getDateEnd())"
        let alert = UtilitiesHelper.getAlertInstance(self, title: "Date", message: dateString, hasTextField: false, textFieldValue: "", type: "ok")
    }
    @IBOutlet weak var tripDescriptionButton: UIButton!
    @IBAction func tripDescriptionButton(sender: AnyObject) {
        let alert = UtilitiesHelper.getAlertInstance(self, title: "Description", message: "", hasTextField: true, textFieldValue: currentTrip!.getDescription(), type: "custom")
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            print("OK clicked.")

            self.currentTrip!.setDescription(textField.text!)
            self.tripDescriptionButton.setTitle(self.currentTrip!.getDescription(), forState: UIControlState.Normal)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action) -> Void in
            print("Cancel clicked.")
        }))
    }
    @IBAction func tripDeleteButton(sender: AnyObject) {
        deleteTrip()
    }
    @IBAction func tripPhotosButton(sender: AnyObject) {
    }
    @IBAction func tripShareButton(sender: AnyObject) {
    }
    @IBOutlet weak var tripPublicToggle: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.mapView.delegate = self
        locationManager.distanceFilter = 15
        locationManager.requestAlwaysAuthorization()

        initTripDetails()
    }

    func initTripDetails() {
        tripNameButton.setTitle(currentTrip!.getTitle(), forState: UIControlState.Normal)
        tripDateButton.setTitle("May 31, 2016 - June 7, 2016", forState: UIControlState.Normal)
        tripDescriptionButton.setTitle(currentTrip!.getDescription(), forState: UIControlState.Normal)

        if currentTrip != nil {
            print("here is the current trip")
            MapsHelper.generatePolyline(mapView, currentTrip: currentTrip!)
            MapsHelper.adjustZoomToFitAllLocations(mapView)
        }
    }

    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        return MapsHelper.mkOverlayRenderer(mapView, rendererForOverlay: overlay)
    }

    /*
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
    */

    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        print("annotation tapped")
        let annotation = view.annotation

        let alert = UtilitiesHelper.getAlertInstance(self, title: "Delete location?", message: "", hasTextField: false, textFieldValue: "", type: "custom")
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action) -> Void in
            print("Yes clicked.")

            // make sure there are still at least a couple of locations left; otherwise, delete the whole trip
            if self.currentTrip!.getLocations().count > 2 {
                self.currentTrip!.removeLocation((annotation?.coordinate)!)
                MapsHelper.generatePolyline(mapView, currentTrip: self.currentTrip!)
                print("Location deleted successfully.")
            } else {
                self.deleteTrip()
                print("Trip deleted successfully.")
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action) -> Void in
            print("No clicked.")
        }))
    }

    //TODO: probably move this into the Trip.swift or TripsManager.swift file
    func deleteTrip() {
        let alert = UtilitiesHelper.getAlertInstance(self, title: "Delete", message: "Trip will be deleted. Are you sure?", hasTextField: false, textFieldValue: "", type: "custom")
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action) -> Void in
            print("Yes clicked.")
            TripsManager.removeTrip(self.currentTrip!)
            
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action) -> Void in
            print("No clicked.")
        }))
    }
}
