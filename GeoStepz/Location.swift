//
//  Location.swift
//  GeoStepz
//
//  Created by Abcarians, Areg on 3/13/16.
//  Copyright © 2016 Sang Lee. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import GoogleMaps

class Location {
    private var id: String?
    private var cllocation: [CLLocation]?
    private var annotation: MKPointAnnotation?
    private var datetime: String?
    private var comments: [String]?
    private var photos: [String]?

    init(cllocation: [CLLocation]) {
        self.id = NSUUID().UUIDString
        self.cllocation = cllocation
        self.annotation = MKPointAnnotation()
        self.annotation!.coordinate = cllocation[0].coordinate
    }

    func getCLLocation() -> [CLLocation] {
        return cllocation!
    }

    func getAnnotation() -> MKPointAnnotation {
        return annotation!
    }

    func getAnnotationTitle() -> String {
        return annotation!.title!
    }

    func setAnnotationTitle() {
        let placesClient: GMSPlacesClient = GMSPlacesClient()

        placesClient.currentPlaceWithCallback({ (placeLikelihoods, error) -> Void in
            if error != nil {
                print("Current Place error: \(error!.localizedDescription)")

                CLGeocoder().reverseGeocodeLocation(self.getCLLocation()[0], completionHandler: {(placemarks, error) -> Void in
                    
                    if error != nil {
                        print("Reverse geocoder failed with error" + error!.localizedDescription)
                        return
                    }
                    
                    if placemarks!.count > 0 {
                        let pm = placemarks![0] as CLPlacemark
                        self.annotation!.title = pm.locality
                    }
                    else {
                        print("Problem with the data received from geocoder")
                    }
                })
            } else {
                for likelihood in placeLikelihoods!.likelihoods {
                    if let likelihood = likelihood as? GMSPlaceLikelihood {
                        let place = likelihood.place
                        self.annotation!.title = place.name

                        break
                    }
                }
            }
        })
    }
}
