import UIKit
import CoreLocation
import MapKit

class MapsHelper {
    static func generatePolyline(mapView: MKMapView, currentTrip: Trip) {
        print("generatePolyline")
        var locationCoordinates = [CLLocationCoordinate2D]()
        let locations = currentTrip.getLocations()
        self.removeAnnotations(mapView)

        for i in locations {
            let locationCoordinate = i.getCLLocation()[0].coordinate
            locationCoordinates.append(locationCoordinate)

            let annotation = i.getAnnotation()
            self.addAnnotation(mapView, annotation: annotation)
            //self.showAnnotation(mapView, annotation: annotation)
        }

        weak var polylinePathOverlay: MKGeodesicPolyline? = MKGeodesicPolyline(coordinates: &locationCoordinates, count: locationCoordinates.count)
        mapView.removeOverlays(mapView.overlays)

        if (polylinePathOverlay != nil) {
            print("should have removed")
            mapView.addOverlay(polylinePathOverlay!)
        }

        self.focusOnUpdatedLocation(mapView, cllocation: locations.last!.getCLLocation())
    }

    static func mkOverlayRenderer(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer()
        }

        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.lineWidth = 2.0
        renderer.alpha = 0.5
        renderer.strokeColor = UIColor.blueColor()

        return renderer
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

    static func addAnnotation(mapView: MKMapView, annotation: MKAnnotation) {
        mapView.addAnnotation(annotation)
    }

    static func removeAnnotation(mapView: MKMapView, annotation: MKAnnotation) {
        mapView.removeAnnotation(annotation)
    }

    static func removeAnnotations(mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
    }

    /*
    static func showAnnotation(mapView: MKMapView, annotation: MKAnnotation) {
    mapView.selectAnnotation(annotation, animated: true)
    }

    static func createAnnotation(mapView: MKMapView, coordinate: CLLocationCoordinate2D) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        mapView.addAnnotation(annotation)

        return annotation
    }

    static func setAnnotationTitle(annotation: MKPointAnnotation, title: String) {
        annotation.title = title
    }
*/
}
