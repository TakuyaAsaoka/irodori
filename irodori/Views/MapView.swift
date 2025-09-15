//
//  Untitled.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/16.
//

import SwiftUI
import MapKit

struct MapView: View {
  @StateObject private var locationManager = LocationManager()

  var body: some View {
      Map(coordinateRegion: $locationManager.region,
          showsUserLocation: true,
          annotationItems: annotationItems) { item in
          MapMarker(coordinate: item.coordinate, tint: .red)
      }
      .ignoresSafeArea()
      .navigationTitle("ロッカーモード")
      .navigationBarTitleDisplayMode(.inline)
  }

  private var annotationItems: [PinItem] {
      guard let randomCoord = locationManager.randomCoordinate else { return [] }
      return [PinItem(coordinate: randomCoord)]
  }
}

#Preview {
    ContentView()
}
