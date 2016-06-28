//
//  TripsManager.swift
//  GeoStepz
//
//  Created by Abcarians, Areg on 3/13/16.
//  Copyright © 2016 Sang Lee. All rights reserved.
//

import Foundation
import CoreLocation

class TripsManager {
    static let tripsManager = TripsManager()
    static private var trips = [Trip]()
    private init() {}

    /*
    var dbStubData = [
        [
            "id": "2982938",
            "title": "Las Vegas",
            "description": "Spring break 2016!",
            "locations": [
                ["serializedCLLocationData1", "serializedCLLocationData2"]
            ],
            "datetime": "April 20, 2016",
            "comments": [
                [
                    "id": "12345",
                    "datetime": "April 20, 2016",
                    "avatar": "http://geosnapscdn.com/somepath",
                    "body": "Nice trip!"
                ]
            ],
            "photos": [
                "http://geosnapscdn.com/somepath",
                "http://geosnapscdn.com/somepath"
            ]
        ],
        [
            "id": "2922938",
            "title": "New York",
            "description": "Bachelor party!",
            "locations": [
                ["serializedCLLocationData1", "serializedCLLocationData2"]
            ],
            "datetime": "April 25, 2016",
            "comments": [
                [
                    "id": "67890",
                    "datetime": "April 25, 2016",
                    "avatar": "http://geosnapscdn.com/somepath",
                    "body": "Nice trip!"
                ]
            ],
            "photos": [
                "http://geosnapscdn.com/somepath",
                "http://geosnapscdn.com/somepath"
            ]
        ]
    ];
    */
    var dbStubDataJSON = "[{\"id\":\"2982938\",\"title\":\"Las Vegas\",\"description\":\"Spring break 2016!\",\"locations\":[[\"serializedCLLocationData1\",\"serializedCLLocationData2\"]],\"datetime\":\"April 20, 2016\",\"comments\":[{\"id\":\"12345\",\"datetime\":\"April 20, 2016\",\"avatar\":\"http://geosnapscdn.com/somepath\",\"body\":\"Nice trip!\"}],\"photos\":[\"http://geosnapscdn.com/somepath\",\"http://geosnapscdn.com/somepath\"]},{\"id\":\"2922938\",\"title\":\"New York\",\"description\":\"Bachelor party!\",\"locations\":[[\"serializedCLLocationData1\",\"serializedCLLocationData2\"]],\"datetime\":\"April 25, 2016\",\"comments\":[{\"id\":\"67890\",\"datetime\":\"April 25, 2016\",\"avatar\":\"http://geosnapscdn.com/somepath\",\"body\":\"Nice trip!\"}],\"photos\":[\"http://geosnapscdn.com/somepath\",\"http://geosnapscdn.com/somepath\"]}]"
    /*
    func getTripsFromDB() ->  [String] {
        //TODO: get db logic will go here, but for now grabbing from local dbStubData
        return dbStubDataJSON
    }
    
    func getTrips() -> [Trip] {
        return dbStubData;
    }
    */
    
    //TODO: move to singleton utilities class (commonly used method)
    func convertJSONToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }

    static func getTrips() -> [Trip]{
        return trips
    }

    static func addTrip(trip: Trip) {
        trips.append(trip)
    }

    static func deleteTrip(trip: Trip) {
        trips = trips.filter() { $0 !== trip }
    }
}
