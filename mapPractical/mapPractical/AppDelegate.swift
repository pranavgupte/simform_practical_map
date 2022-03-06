//
//  AppDelegate.swift
//  mapPractical
//
//  Created by Pranav Gupte on 05/03/22.
//
import UIKit
import CoreData
import IQKeyboardManagerSwift
import IHProgressHUD
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // App loader initial set up
        IHProgressHUD.set(defaultStyle:IHProgressHUDStyle.light)
        IHProgressHUD.set(defaultMaskType:IHProgressHUDMaskType.black)
        
        // Auto keyboard management for app
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = .black
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        // Set initial View as per login
        if isAlreadyLoginFromPersistantData() {
            self.window?.rootViewController = Storyboard.Main.instantiateViewController(withIdentifier:"Dashboard") as! UITabBarController
        }else{
            self.window?.rootViewController = Storyboard.Main.instantiateViewController(withIdentifier:"Login") as! UINavigationController
        }
        self.window?.makeKeyAndVisible()
        return true
    }
    func isAlreadyLoginFromPersistantData() -> Bool{
        let username = KeychainService.loadUsername() as NSString? ?? ""
        let pwd = KeychainService.loadPassword() as NSString? ?? ""
        if username != "" && pwd != "" {
            return true
        }else{
            return false
        }
    }
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "mapPractical")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
