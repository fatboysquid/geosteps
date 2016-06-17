//
//  Location.swift
//  GeoStepz
//
//  Created by Abcarians, Areg on 3/13/16.
//  Copyright © 2016 Sang Lee. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    var id: String?
    var title: String?
    var description: String?
    let cllocation: [CLLocation]?
    var datetime: String?
    var comments: [String]?
    var photos: [String]?

    init(cllocation: [CLLocation]) {
        self.id = NSUUID().UUIDString
        self.title = "Test Location title " + self.id!
        self.description = "Test Location description " + self.id!
        self.cllocation = cllocation
    }

    func getCLLocation() -> [CLLocation]{
        return cllocation!
    }
}
