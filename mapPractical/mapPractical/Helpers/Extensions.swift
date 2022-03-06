//
//  Extensions.swift
//  mapPractical
//
//  Created by Pranav Gupte on 06/03/22.
//

import Foundation
import UIKit
import MapKit
extension MKMapView {
    var zoomLevel: Double {
        get {
            return log2(360 * (Double(self.frame.size.width / 256) / self.region.span.longitudeDelta)) + 1
        }
        set (newZoomLevel){
            setCenterCoordinate(coordinate:self.centerCoordinate, zoomLevel: newZoomLevel, animated: false)
        }
    }
    private func setCenterCoordinate(coordinate: CLLocationCoordinate2D, zoomLevel: Double, animated: Bool) {
        let span = MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 360 / pow(2, zoomLevel) * Double(self.frame.size.width) / 256)
        setRegion(MKCoordinateRegion(center: coordinate, span: span), animated: animated)
    }
}
// MARK: View controller extenstions
extension LoginViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return true
    }
}
extension UIViewController {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        self.present(alert, animated: true, completion: nil)
    }
}
