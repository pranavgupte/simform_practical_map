//
//  OptionsMapViewController.swift
//  mapPractical
//
//  Created by Pranav Gupte on 06/03/22.
//
import UIKit
import CoreLocation
import MapKit
class OptionsMapViewController: UIViewController, MKMapViewDelegate {
    static func instance() -> OptionsMapViewController{
        return Storyboard.Main.instantiateViewController(withIdentifier: "OptionsMapViewController") as! OptionsMapViewController
    }
    @IBOutlet weak var mapView: MKMapView!
    var coordinates :[CLLocationCoordinate2D] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.hidesBackButton = false
        self.setMap()
    }
    func setMap(){
        mapView.showsUserLocation = false
        mapView.addOverlay(MKGeodesicPolyline(coordinates: coordinates, count: coordinates.count))
        mapView.setCenter(coordinates.first!, animated: true)
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.blue.withAlphaComponent(0.5)
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
    deinit{
        print("Options Map Deinit")
    }
}
