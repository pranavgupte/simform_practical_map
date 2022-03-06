//
//  MapPath+CoreDataProperties.swift
//  
//
//  Created by Pranav Gupte on 06/03/22.
//
//
import Foundation
import CoreData
extension MapPath {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MapPath> {
        return NSFetchRequest<MapPath>(entityName: "MapPath")
    }
    @NSManaged public var latitude: Double
    @NSManaged public var longtitude: Double
    @NSManaged public var timestamp: Double
}
