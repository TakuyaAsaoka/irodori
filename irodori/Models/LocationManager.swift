//
//  LocationManager.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/16.
//

import Foundation
import CoreLocation
import MapKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion()
    @Published var randomCoordinate: CLLocationCoordinate2D? = nil
    private let manager = CLLocationManager()
    private let randomRadius: Double = 3000 // 3km

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
        if randomCoordinate == nil {
            randomCoordinate = generateRandomCoordinate(center: location.coordinate, radius: randomRadius)
        }
    }

    private func generateRandomCoordinate(center: CLLocationCoordinate2D, radius: Double) -> CLLocationCoordinate2D {
        let radiusInDegrees = radius / 111_000.0
        let u = Double.random(in: 0...1)
        let v = Double.random(in: 0...1)
        let w = radiusInDegrees * sqrt(u)
        let t = 2 * Double.pi * v
        let latOffset = w * cos(t)
        let lonOffset = w * sin(t) / cos(center.latitude * .pi / 180)
        return CLLocationCoordinate2D(
            latitude: center.latitude + latOffset,
            longitude: center.longitude + lonOffset
        )
    }
}
