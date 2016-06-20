//
//  Trip.swift
//  GeoStepz
//
//  Created by Abcarians, Areg on 3/13/16.
//  Copyright © 2016 Sang Lee. All rights reserved.
//

import Foundation
import CoreLocation

class Trip {
    var id: String?
    var title: String?
    var description: String?
    var locations: [Location]?
    var datetime: String?
    var comments: [String]?
    var photos: [String]?

    init() {
        self.id = NSUUID().UUIDString
        self.title = ""// + self.id!
        self.description = ""// + self.id!
        self.locations = [Location]()
    }

    func getLocations() -> [Location]{
        return locations!
    }

    func getTitle() -> String {
        return title!
    }

    func addLocation(location: Location) {
        locations!.append(location)
    }
}
