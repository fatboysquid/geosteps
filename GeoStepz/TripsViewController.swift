//
//  TripsViewController.swift
//  GeoStepz
//
//  Created by Lee, Sang on 1/5/16.
//  Copyright © 2016 Sang Lee. All rights reserved.
//

import UIKit

class TripsViewController : UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        self.tableView.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let trips = TripsManager.getTrips()
        return trips.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let trips = TripsManager.getTrips()
        let cell = tableView.dequeueReusableCellWithIdentifier("tripcell") as UITableViewCell?
        cell!.textLabel!.text = trips[indexPath.row].getTitle()
        return cell!
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tabBarController?.tabBar.hidden = true
        self.performSegueWithIdentifier("tripDetailSegue", sender: indexPath.row)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "tripDetailSegue" {
            if let destinationVC = segue.destinationViewController as? TripDetailViewController {
                let trips = TripsManager.getTrips()
                if let tripIndex = sender as! NSInteger? {
                    let currentTrip = trips[tripIndex]
                    destinationVC.currentTrip = currentTrip
                }
            }
        }
    }
}
