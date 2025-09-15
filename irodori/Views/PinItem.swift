//
//  PinItem.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/16.
//

import Foundation
import MapKit

struct PinItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
