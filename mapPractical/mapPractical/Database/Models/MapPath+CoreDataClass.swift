//
//  MapPath+CoreDataClass.swift
//  
//
//  Created by Pranav Gupte on 06/03/22.
//
//
import Foundation
import CoreData
import UIKit
import CoreLocation
public class MapPath: NSManagedObject {
    class func saveMapPoint(_ mapPoint:MapPoint) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
         DispatchQueue.main.async {
            let managedContext = appdelegate.persistentContainer.viewContext
            managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            let map = MapPath(context: managedContext)
            map.latitude = mapPoint.latitude
            map.longtitude = mapPoint.longtitude
            map.timestamp = mapPoint.timestamp
            appdelegate.saveContext()
        }
    }
    class func retriveAllMapPoints() -> [CLLocationCoordinate2D] {
        do {
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            let request : NSFetchRequest<MapPath> = MapPath.fetchRequest()
            let sort = NSSortDescriptor(key: "timestamp", ascending: true)
            request.sortDescriptors = [sort]
            let results = try appdelegate.persistentContainer.viewContext.fetch(request)
            var coordinates:[CLLocationCoordinate2D] = []
            var lastTsp:Double = 0.0
            for i in 0...results.count-1{
                let mapPoint = results[i]
                let coordinate = CLLocationCoordinate2D.init(latitude:mapPoint.latitude, longitude: mapPoint.longtitude)
                if i == 0 || i == (results.count-1) {
                    lastTsp = mapPoint.timestamp
                    coordinates.append(coordinate)
                // 600 = 10 mins as per timestamp
                }else if mapPoint.timestamp > (lastTsp + 600){
                    lastTsp = mapPoint.timestamp
                    coordinates.append(coordinate)
                }
            }
            return coordinates
        }catch {
            return []
        }
    }
}
