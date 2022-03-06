//
//  Messurements+CoreDataProperties.swift
//  
//
//  Created by Pranav Gupte on 06/03/22.
//
//
import Foundation
import CoreData
extension Messurements {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Messurements> {
        return NSFetchRequest<Messurements>(entityName: "Messurements")
    }
    @NSManaged public var height: Double
    @NSManaged public var weight: Double
    @NSManaged public var latitude: Double
    @NSManaged public var longtitude: Double
}
