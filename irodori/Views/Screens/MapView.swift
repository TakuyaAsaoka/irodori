//
//  MapView.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/16.
//

import SwiftUI
import MapKit

struct MapView: View {
  @StateObject private var locationManager = LocationManager()

  @State private var position: MapCameraPosition = .automatic
  @State private var destinations: [CLLocationCoordinate2D] = []
  @State private var isShowingEventMap = false

  @State var modalPosition = CGSize.zero
  @State var viewSize = UIScreen.main.bounds

  var body: some View {
    NavigationStack {
      ZStack {
        if let currentLocation = locationManager.currentLocation {
          Map(position: $position) {
            ForEach(Array(destinations.enumerated()), id: \.offset) { index, dest in
              Annotation("", coordinate: dest) {
                Button {
                  isShowingEventMap = true
                } label: {
                  Image("DestinationPin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 75)
                }
                .accessibilityHidden(true)
              }
            }
            Annotation("", coordinate: currentLocation) {
                Image("CurrentLocationPin")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 42, height: 52)
                  .accessibilityHidden(true)
            }
          }
          .onReceive(locationManager.$currentLocation) { coordinate in
            if let coordinate, position == .automatic {
              if destinations.isEmpty {
                destinations = (0..<5).map { _ in
                  randomCoordinate(around: coordinate, radiusMeters: 10000)
                }
              }
              let allPoints = [coordinate] + destinations
              if let region = regionThatFitsAll(points: allPoints) {
                position = .region(region)
              }
            }
          }

          HalfModalView(position: $modalPosition, viewSize: viewSize)
            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: -2)
        } else {
          ProgressView("Getting current location…")
        }
      }
      .toolbar(.hidden, for: .navigationBar)
      .navigationDestination(isPresented: $isShowingEventMap) {
        EventMapView()
      }
    }
  }

  private func startNavigation(to coordinate: CLLocationCoordinate2D) {
    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
    mapItem.name = "目的地"
    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
  }
}

#Preview {
    MapView()
}
