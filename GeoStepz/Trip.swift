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
    private var id: String
    private var title: String
    private var description: String
    private var locations: [Location]
    private var dateStart: NSDate
    private var dateEnd: NSDate
    private var comments: [String]
    private var photos: [String]

    init() {
        self.id = NSUUID().UUIDString
        self.title = "New trip"
        self.description = "Enter description"
        self.locations = []
        self.dateStart = NSDate()
        self.dateEnd = NSDate()
        self.comments = []
        self.photos = []
    }

    func getId() -> String {
        return id
    }

    func getTitle() -> String {
        return title
    }

    func setTitle(title: String) {
        self.title = title
    }

    func getDescription() -> String {
        return description
    }

    func setDescription(description: String) {
        self.description = description
    }

    func getLocations() -> [Location]{
        return locations
    }

    func addLocation(location: Location) {
        locations.append(location)
    }

    func getDateStart() -> NSDate {
        return dateStart
    }

    func setDateStart(dateStart: NSDate) {
        self.dateStart = dateStart
    }

    func getDateEnd() -> NSDate {
        return dateEnd
    }

    func setDateEnd(dateEnd: NSDate) {
        self.dateEnd = dateEnd
    }

    func getComments() -> [String]{
        return comments
    }

    func addComment(comment: String) {
        comments.append(comment)
    }

    func getPhotos() -> [String]{
        return photos
    }

    func addPhoto(photo: String) {
        photos.append(photo)
    }
}
