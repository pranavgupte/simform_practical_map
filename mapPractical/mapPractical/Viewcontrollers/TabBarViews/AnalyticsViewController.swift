//
//  AnalyticsViewController.swift
//  mapPractical
//
//  Created by Pranav Gupte on 05/03/22.
//
import UIKit
import CoreLocation
class AnalyticsViewController: UIViewController {
    @IBOutlet weak var btnWeight: UIButton!
    @IBOutlet weak var btnHeight: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.hidesBackButton = true
    }
    func setView(){
        addBorderTo(btn:btnLocation)
        addBorderTo(btn:btnHeight)
        addBorderTo(btn:btnWeight)
    }
    func addBorderTo(btn:UIButton){
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.black.cgColor
    }
    @IBAction func btnMapOptionsClicked(_ sender: UIButton){
        let vc = OptionsMapViewController.instance()
        var coordinates:[CLLocationCoordinate2D] = []
        switch sender.tag {
            case 1001:
                coordinates = MapPath.retriveAllMapPoints()
            case 1002:
                coordinates = Messurements.retriveAllWeightData()
            case 1003:
                coordinates = Messurements.retriveAllHeightData()
            default:
                print("Wrong option selected")
        }
        if coordinates.isEmpty {
            Util.showAlertWith(title:ErrorMessage.ERROR, message:ErrorMessage.NO_DATA_FOUND, self)
        }else{
            vc.coordinates =  coordinates
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    deinit{
        print("Deinit")
    }
}
