//
//  User.swift
//  GeoStepz
//
//  Created by Abcarians, Areg on 7/17/16.
//  Copyright © 2016 Areg Abcarians. All rights reserved.
//

import Foundation

class User {
    private var id: String
    private var username: String
    private var email: String
    private var password: String
    private var avatar: String
    private var description: String
    private var dateRegistered: NSDate
    private var dateLastSignedIn: NSDate
    private var score: Int
    private var trips: [Trip]
    private var friends: [User]

    init(
        id: String,
        username: String,
        email: String,
        password: String
    ) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password

        self.avatar = ""
        self.description = ""
        self.dateRegistered = NSDate()
        self.dateLastSignedIn = NSDate()
        self.score = 0
        self.trips = []
        self.friends = []
    }

    func getId() -> String {
        return id
    }

    func getUsername() -> String {
        return username
    }

    func setUsername(username: String) {
        self.username = username
    }

    func getEmail() -> String {
        return email
    }

    func setEmail(email: String) {
        self.email = email
    }

    func getPassword() -> String {
        return password
    }

    func setPassword(password: String) {
        self.password = password
    }

    func getAvatar() -> String {
        return avatar
    }

    func setAvatar(avatar: String) {
        self.avatar = avatar
    }

    func getDescription() -> String {
        return description
    }

    func setDescription(description: String) {
        self.description = description
    }

    func getDateRegistered() -> NSDate {
        return dateRegistered
    }

    func setDateRegistered(dateRegistered: NSDate) {
        self.dateRegistered = dateRegistered
    }

    func getDateLastSignedIn() -> NSDate {
        return dateLastSignedIn
    }

    func setDateLastSignedIn(dateLastSignedIn: NSDate) {
        self.dateLastSignedIn = dateLastSignedIn
    }

    func getScore() -> Int {
        return score
    }

    func updateScore() {
        self.score += 1
    }

    func getTrips() -> [Trip]{
        return trips
    }

    func addTrip(trip: Trip) {
        trips.append(trip)
    }

    func removeTrip(trip: Trip) {
        /*
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
    
        for i in locations {
            let currentLocation = i.getCLLocation()[0]
            if currentLocation.coordinate.latitude == latitude &&
                currentLocation.coordinate.longitude == longitude {
                locations = locations.filter() { $0.getCLLocation()[0] !== currentLocation }
                break
            }
        }
 */
    }

    func getFriends() -> [User]{
        return friends
    }

    func addFriend(user: User) {
        friends.append(user)
    }

    func removeFriend(user: User) {
        /*
         let latitude = coordinate.latitude
         let longitude = coordinate.longitude
         
         for i in locations {
         let currentLocation = i.getCLLocation()[0]
         if currentLocation.coordinate.latitude == latitude &&
         currentLocation.coordinate.longitude == longitude {
         locations = locations.filter() { $0.getCLLocation()[0] !== currentLocation }
         break
         }
         }
         */
    }
}
