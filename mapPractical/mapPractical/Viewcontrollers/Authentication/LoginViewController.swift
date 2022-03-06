//
//  LoginViewController.swift
//  mapPractical
//
//  Created by Pranav Gupte on 05/03/22.
//

import UIKit
import IHProgressHUD
class LoginViewController: UIViewController {
    @IBOutlet weak var txtFieldUsername:UITextField!
    @IBOutlet weak var txtFieldPassword:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnLoginClicked(_ sender: UIButton){
        if txtFieldUsername.text != "" {
            if txtFieldPassword.text != "" {
                self.view.endEditing(true)
                IHProgressHUD.show(withStatus:PROGRESS_MSG.LOGINGIN)
                KeychainService.saveUsername(username:txtFieldUsername.text! as NSString)
                KeychainService.savePassword(password:txtFieldUsername.text! as NSString)
                // Delay to Show loader only
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.performSegue(withIdentifier:Segues.ToDashBoard, sender: self)
                    IHProgressHUD.dismiss()
                }
            }else{
                Util.showAlertWith(title:ErrorMessage.EmptyPasswordTitle, message: ErrorMessage.EmptyPasswordMsg,self)
            }
        }else{
            Util.showAlertWith(title:ErrorMessage.EmptyUsernameTitle, message: ErrorMessage.EmptyUsernameMsg, self)
        }
    }
    deinit{
        print("Deinit")
    }
}
