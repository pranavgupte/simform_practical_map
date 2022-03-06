//
//  Messurements+CoreDataClass.swift
//  
//
//  Created by Pranav Gupte on 06/03/22.
//
//
import Foundation
import CoreData
import UIKit
import CoreLocation
public class Messurements: NSManagedObject {
    class func save(_ messurementData:Messurement) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
         DispatchQueue.main.async {
             let managedContext = appdelegate.persistentContainer.viewContext
             managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
             let messurement = Messurements(context: managedContext)
             messurement.latitude = messurementData.latitude
             messurement.longtitude = messurementData.longtitude
             messurement.height = messurementData.height
             messurement.weight = messurementData.weight
             appdelegate.saveContext()
        }
    }
    class func retriveAllHeightData() -> [CLLocationCoordinate2D] {
        do {
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            let request : NSFetchRequest<Messurements> = Messurements.fetchRequest()
            let results = try appdelegate.persistentContainer.viewContext.fetch(request)
            var coordinates:[CLLocationCoordinate2D] = []
            for messurement in results {
                let coordinate = CLLocationCoordinate2D.init(latitude:messurement.latitude, longitude: messurement.longtitude)
                if messurement.height != 0 { coordinates.append(coordinate) }
            }
            return coordinates
        }catch {
            return []
        }
    }
    class func retriveAllWeightData() -> [CLLocationCoordinate2D] {
        do {
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            let request : NSFetchRequest<Messurements> = Messurements.fetchRequest()
            let results = try appdelegate.persistentContainer.viewContext.fetch(request)
            var coordinates:[CLLocationCoordinate2D] = []
            for messurement in results {
                let coordinate = CLLocationCoordinate2D.init(latitude:messurement.latitude, longitude: messurement.longtitude)
                if messurement.weight != 0 { coordinates.append(coordinate) }
            }
            return coordinates
        }catch {
            return []
        }
    }
}
