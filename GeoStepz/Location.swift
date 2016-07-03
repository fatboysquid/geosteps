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
        self.annotation!.title = "[auto named]"
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

    /*
    func setAnnotationTitle(title: String) {
        annotation!.title = title
    }
*/
}
