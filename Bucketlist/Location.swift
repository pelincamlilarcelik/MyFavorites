//
//  Location.swift
//  Bucketlist
//
//  Created by Onur Celik on 24.03.2023.
//

import Foundation
import CoreLocation

struct Location: Identifiable,Codable,Equatable{
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    
    var coordinate: CLLocationCoordinate2D{
       CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    static let example = Location(id: UUID(), name: "", description: "", latitude: 51, longitude: -0.14)
    static func  ==(lhs:Location,rhs:Location)->Bool{
        lhs.id == rhs.id
    }
}
