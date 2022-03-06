//
//  Constants.swift
//  mapPractical
//
//  Created by Pranav Gupte on 06/03/22.
//

import Foundation
import UIKit
// All error messages
struct ErrorMessage{
    static let EmptyUsernameMsg = "Please enter username"
    static let EmptyPasswordMsg = "Please enter password"
    static let EmptyUsernameTitle = "Empty Username"
    static let EmptyPasswordTitle = "Empty Password"
    static let NO_INTERNET_CONNECTION = "Please check your internet connection"
    static let SERVER_ERROR = "There is some error with server.Please try again"
    static let UNKNOWN_LOGIN_ERROR_MSG = "Unable to login.Please try again."
    static let UNKNOWN_LOGIN_ERROR_TITLE = "Unable to login"
    static let NO_DATA_FOUND = "No data found"
    static let ERROR = "Error"
    static let SUCCESS = "Success!"
    static let SUCCESS_MSG = "Data stored successfully"
}
struct ButtonTitle{
    static let ADD_INFO = "Add Inofrmation"
    static let ADD = "Add"
    static let CANCEL = "Cancel"
    static let OK = "OK"
    static let HEIGHT = "Height"
    static let WEIGHT = "Weight"
    static let LOGOUT = "Logout"
}
struct PROGRESS_MSG{
    static let LOGINGIN = "Loging In..."
    static let LOADING_DATA = "Loading data..."
    static let UPDATING_UI = "Updating UI..."
    static let DATA_LOAD_SUCCESS = "Data Loaded Successfully..."
    static let ADD_INFO = "Add Inofrmation"
}
struct MESSUREMENTS{
    static let CM = "cm"
    static let KG = "kg"
}
// All navigation segues
struct Segues{
    static let ToDashBoard = "toDashboard"
    static let ToOptionsMap = "toOptionsMap"
}
// All storyboards
struct Storyboard{
    static let Main : UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
}
// All device information
struct Device {
    static let isIpad = UIDevice.current.userInterfaceIdiom == .pad ? true : false
}
// Common function
struct Util {
    static func getTimeStamp()-> Double{
        print(NSNumber(value: Int64(Date().timeIntervalSince1970)).doubleValue)
        return NSNumber(value: Int64(Date().timeIntervalSince1970)).doubleValue
    }
    static func showAlertWith(title: String,message: String, _ viewController:UIViewController?){
        if(viewController != nil){
            DispatchQueue.main.async { [weak viewController] in
                let alert = UIAlertController(title:title, message:message ,preferredStyle:UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title:ButtonTitle.OK, style: UIAlertAction.Style.default, handler: nil))
                viewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
}
