//
//  Messurement.swift
//  mapPractical
//
//  Created by Pranav Gupte on 06/03/22.
//

import Foundation
import UIKit
class Messurement:NSObject, NSCoding {
    var latitude: Double = 0.0
    var longtitude: Double = 0.0
    var height: Double = 0.0
    var weight: Double = 0.0
    init(lat:Double, long:Double, height:Double, weight:Double) {
        self.latitude = lat
        self.longtitude = long
        self.height = height
        self.weight = weight
    }
    func encode(with coder: NSCoder) {
        coder.encode(latitude, forKey: "latitude")
        coder.encode(longtitude, forKey: "longtitude")
        coder.encode(height, forKey: "height")
        coder.encode(weight, forKey: "weight")
    }
    required init(coder decoder: NSCoder) {
        self.latitude = decoder.decodeObject(forKey: "latitude") as? Double ?? 0.0
        self.longtitude = decoder.decodeObject(forKey: "longtitude") as? Double ?? 0.0
        self.height = decoder.decodeObject(forKey: "height") as? Double ?? 0.0
        self.weight = decoder.decodeObject(forKey: "weight") as? Double ?? 0.0
    }
}
