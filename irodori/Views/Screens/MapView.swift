//
//  MapView.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/16.
//

import SwiftUI
import MapKit

func randomCoordinate(around coordinate: CLLocationCoordinate2D, radiusMeters: Double) -> CLLocationCoordinate2D {
  // 1度あたりの緯度距離（約111km）
  let metersPerDegree = 111_000.0

  // 半径を度に変換
  let radiusDegrees = radiusMeters / metersPerDegree

  // ランダムな距離と角度を生成
  let u = Double.random(in: 0...1)
  let v = Double.random(in: 0...1)
  let w = radiusDegrees * sqrt(u)
  let t = 2 * Double.pi * v

  let deltaLat = w * cos(t)
  let deltaLon = w * sin(t) / cos(coordinate.latitude * .pi / 180)

  return CLLocationCoordinate2D(
    latitude: coordinate.latitude + deltaLat,
    longitude: coordinate.longitude + deltaLon
  )
}

struct MapView: View {
  @StateObject private var locationManager = LocationManager()

  @State private var position: MapCameraPosition = .automatic
  @State private var destination: CLLocationCoordinate2D? = nil

  var body: some View {
    ZStack {
      if let _ = locationManager.currentLocation {
        Map(position: $position) {
          if let dest = destination {
            Annotation("目的地", coordinate: dest) {
              Button {
                startNavigation(to: dest)
              } label: {
                Image(systemName: "mappin.circle.fill")
                  .font(.title)
                  .foregroundColor(.red)
              }
            }
          }
        }
        .onReceive(locationManager.$currentLocation) { coordinate in
          if let coordinate, position == .automatic {
            position = .region(
              MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
              )
            )
            if destination == nil {
              destination = randomCoordinate(around: coordinate, radiusMeters: 3000)
            }
          }
        }
        .mapControls {
            MapUserLocationButton()
        }
      } else {
        ProgressView("現在地取得中...")
      }
    }
  }

  // ナビを開始する関数
  private func startNavigation(to coordinate: CLLocationCoordinate2D) {
    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
    mapItem.name = "目的地"
    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
  }
}

#Preview {
    MapView()
}
