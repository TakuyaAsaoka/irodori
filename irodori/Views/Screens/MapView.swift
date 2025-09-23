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
  @State private var destination: CLLocationCoordinate2D? = nil
  @State private var isShowingEventMap = false

  @State var modalPosition = CGSize.zero
  @State var viewSize = UIScreen.main.bounds

  var body: some View {
    NavigationStack {
      ZStack {
        if let _ = locationManager.currentLocation {
          Map(position: $position) {
            if let dest = destination {
              Annotation("目的地", coordinate: dest) {
                Button {
                  isShowingEventMap = true
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
          .toolbar(.hidden, for: .navigationBar)

          HalfModalView(position: $modalPosition, viewSize: viewSize)
            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: -2)
        } else {
          ProgressView("Getting current location…")
        }
      }
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
