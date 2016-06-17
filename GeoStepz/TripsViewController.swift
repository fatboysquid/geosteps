//
//  TripsViewController.swift
//  GeoStepz
//
//  Created by Lee, Sang on 1/5/16.
//  Copyright © 2016 Sang Lee. All rights reserved.
//

import UIKit

class TripsViewController : UITableViewController {
    //var trips = [Trip]()
    //var trips = TripsManager.getTrips()
    //var tripNames = ["Glendale" , "Anaheim", "San Diego"]
    //var tripDescriptions = ["Armoland is here", "Disneyland 4 lyfe", "SeaWorld rocks!"]

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        var trip: Trip
        for index in 0...2 {
            trip = Trip()
            trip.title = tripNames[index]
            trip.description = tripDescriptions[index]
            trips.append(trip)
        }
        */
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        //print(trips.count)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let trips = TripsManager.getTrips()
        //return self.trips.count
        return trips.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let trips = TripsManager.getTrips()
        let cell = tableView.dequeueReusableCellWithIdentifier("tripcell") as UITableViewCell?
        cell!.textLabel!.text = trips[indexPath.row].getTitle()
        return cell!
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let trips = TripsManager.getTrips()
        print(trips[indexPath.row].title, trips[indexPath.row].description)
        //self.hidesBottomBarWhenPushed = true
        self.tabBarController?.tabBar.hidden = true
        self.performSegueWithIdentifier("tripDetail", sender: indexPath.row)
    }

    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject) {
        //var destVc = segue.destinationViewController as UIViewController
        //destVc.navigationItem.title = self.items[sender as Int]
    }
    */
}
