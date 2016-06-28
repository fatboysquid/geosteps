import UIKit
import CoreLocation
import MapKit

class MapsHelper {
    static func createPolyline(mapView: MKMapView, currentTrip: Trip) {
        print("createPolyline")
        var locationCoordinates = [CLLocationCoordinate2D]()
        let locations = currentTrip.getLocations()

        for i in locations {
            let locationCoordinate = i.getCLLocation()[0].coordinate
            locationCoordinates.append(locationCoordinate)
            print(locationCoordinate.dynamicType)
        }

        weak var polylinePathOverlay: MKGeodesicPolyline? = MKGeodesicPolyline(coordinates: &locationCoordinates, count: locationCoordinates.count)
        mapView.removeOverlays(mapView.overlays)
        
        if (polylinePathOverlay != nil) {
            print("should have removed")
            mapView.addOverlay(polylinePathOverlay!)
        }

        self.focusOnUpdatedLocation(mapView, cllocation: locations.last!.getCLLocation())
    }

    static func focusOnUpdatedLocation(mapView: MKMapView, cllocation: [CLLocation]) {
        let coordinate = cllocation[0].coordinate;
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
    }

    static func adjustZoomToFitAllLocations(mapView: MKMapView) {
        if let first = mapView.overlays.first {
            let rect = mapView.overlays.reduce(first.boundingMapRect, combine: {MKMapRectUnion($0, $1.boundingMapRect)})
            mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 140.0, left: 140.0, bottom: 140.0, right: 140.0), animated: true)
        }
    }
/*
    static func addAnnotation(mapView: MKMapView) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude)
        annotation.title = "Here you are"
        mapView.addAnnotation(annotation)
    }
*/
}
