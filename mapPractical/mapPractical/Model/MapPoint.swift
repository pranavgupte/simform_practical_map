//
//  MapPoint.swift
//  mapPractical
//
//  Created by Pranav Gupte on 06/03/22.
//

import Foundation
import UIKit
class MapPoint:NSObject, NSCoding {
    var latitude: Double = 0.0
    var longtitude: Double = 0.0
    var timestamp: Double = 0.0
    init(lat:Double, long:Double, timestamp:Double) {
        self.latitude = lat
        self.longtitude = long
        self.timestamp = timestamp
    }
    func encode(with coder: NSCoder) {
        coder.encode(latitude, forKey: "latitude")
        coder.encode(longtitude, forKey: "logtitude")
        coder.encode(timestamp, forKey: "timestamp")
    }
    required init(coder decoder: NSCoder) {
        self.latitude = decoder.decodeObject(forKey: "latitude") as? Double ?? 0.0
        self.longtitude = decoder.decodeObject(forKey: "logtitude") as? Double ?? 0.0
        self.timestamp = decoder.decodeObject(forKey: "timestamp") as? Double ?? 0.0
    }
}
