//
//  HomeViewController.swift
//  mapPractical
//
//  Created by Pranav Gupte on 05/03/22.
//
import UIKit
import CoreLocation
import MapKit
class HomeViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapErrorView: UIView!
    @IBOutlet weak var btnHamburger: UIButton!
    private var locationManager = CLLocationManager()
    private var coordinates :[CLLocationCoordinate2D] = []
    private var currentCoordinates :CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        initializeLocationManager()
    }
    func setView(){
        let logoutBtn = UIBarButtonItem(title: ButtonTitle.LOGOUT, style: .plain, target: self, action: #selector(btnLogoutClick))
        self.navigationItem.rightBarButtonItem = logoutBtn
        self.navigationController?.navigationBar.topItem?.hidesBackButton = true
        self.btnHamburger.layer.cornerRadius = self.btnHamburger.frame.size.width/2
        self.btnHamburger.layer.masksToBounds = true
    }
    @objc func btnLogoutClick () {
        let username = KeychainService.loadUsername() as NSString? ?? ""
        let pwd = KeychainService.loadPassword() as NSString? ?? ""
        KeychainService.remove(username:username, password:pwd)
        UIApplication.shared.keyWindow?.rootViewController = Storyboard.Main.instantiateViewController(withIdentifier:"Login") as! UINavigationController
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
    @IBAction func btnHamburgerClicked(_ sender: UIButton){
        var selectionActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let heightAction = UIAlertAction(title: ButtonTitle.HEIGHT, style: .default, handler: { [self]
            (alert: UIAlertAction!) -> Void in
            showDilogueFor(tag:1)
        })
        let weightAction = UIAlertAction(title: ButtonTitle.WEIGHT, style: .default, handler: { [self]
            (alert: UIAlertAction!) -> Void in
            showDilogueFor(tag:2)
        })
        let cancelAction = UIAlertAction(title: ButtonTitle.CANCEL, style: .cancel, handler:nil)
        if Device.isIpad {
            selectionActionSheet = UIAlertController(title: nil, message: nil, preferredStyle:.alert)
        }
        selectionActionSheet.addAction(heightAction)
        selectionActionSheet.addAction(weightAction)
        selectionActionSheet.addAction(cancelAction)
        self.present(selectionActionSheet, animated: true, completion: nil)
    }
    func showDilogueFor(tag:Int){
        let title = (tag == 1) ? ButtonTitle.HEIGHT : ButtonTitle.WEIGHT
        let messure = (tag == 1) ? MESSUREMENTS.CM : MESSUREMENTS.KG
        self.showInputDialog(title: PROGRESS_MSG.ADD_INFO,
                             subtitle: "Please enter the \(title.lowercased())",
                        actionTitle: ButtonTitle.ADD,
                        cancelTitle: ButtonTitle.CANCEL,
                        inputPlaceholder: "Enter your \(title) in \(messure)",
                        inputKeyboardType: .numberPad, actionHandler:{ (input:String?) in
            if input ?? "" == "" {
                Util.showAlertWith(title: "Empty \(title)!", message: "Please enter \(title)", self)
            }else{
                let lat = self.currentCoordinates?.latitude ?? 0.0
                let long = self.currentCoordinates?.longitude ?? 0.0
                if tag == 1 {
                    let mesurement = Messurement.init(lat:lat, long: long, height: Double(input ?? "0.0") ?? 0.0 , weight: 0.0)
                    Messurements.save(mesurement)
                }else{
                    let mesurement = Messurement.init(lat:lat, long: long, height: 0.0, weight: Double(input ?? "0.0") ?? 0.0)
                    Messurements.save(mesurement)
                }
                Util.showAlertWith(title: ErrorMessage.SUCCESS, message: ErrorMessage.SUCCESS_MSG,self)
            }
        })
    }
    func initializeLocationManager() {
        mapView.showsUserLocation = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    func showLocationAuthorizationError(){
        mapView.isHidden = true
        mapErrorView.isHidden = false
        btnHamburger.isUserInteractionEnabled = false
        btnHamburger.alpha = 0.5
    }
    @IBAction func btnOpenSettingsClicked(_ sender: UIButton){
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    deinit{
        print("Deinit")
    }
}
// MARK: View controller extenstions
extension HomeViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentCoordinates = locationManager.location?.coordinate
        mapView.isHidden = false
        mapErrorView.isHidden = true
        btnHamburger.isUserInteractionEnabled = true
        btnHamburger.alpha = 1.0
        saveCoordinateAndDraw(location:currentCoordinates!)
        mapView.setCenter(currentCoordinates!, animated: true)
    }
    func saveCoordinateAndDraw(location:CLLocationCoordinate2D){
        coordinates.append(location)
        MapPath.saveMapPoint(MapPoint.init(lat:location.latitude, long: location.longitude, timestamp: Util.getTimeStamp()))
        mapView.addOverlay(MKGeodesicPolyline(coordinates: coordinates, count: coordinates.count))
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
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            return
        case .denied:
            showLocationAuthorizationError()
            break
        case .restricted:
            showLocationAuthorizationError()
            return
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
}
