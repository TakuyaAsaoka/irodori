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
  @Published var currentLocation: CLLocationCoordinate2D? = nil
  private var manager = CLLocationManager()

  override init() {
    super.init()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.requestWhenInUseAuthorization()
    manager.startUpdatingLocation()
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    currentLocation = location.coordinate
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Location error: \(error)")
  }
}
