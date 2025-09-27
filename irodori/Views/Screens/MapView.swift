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

        HalfModalView(position: $modalPosition, viewSize: viewSize) {modalState in
          ModalContentView(modalState: modalState)
        }
          .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: -2)
      } else {
        ProgressView("Getting current location…")
      }
    }
    .navigationBarBackButtonHidden(false)
    .toolbarBackground(.hidden, for: .navigationBar)
    .navigationDestination(isPresented: $isShowingEventMap) {
      EventMapView()
    }
  }

  private func startNavigation(to coordinate: CLLocationCoordinate2D) {
    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
    mapItem.name = "目的地"
    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
  }
}

struct ModalContentView: View {
  let modalState: ModalState

  private func getScrollViewHeight(viewSize: CGRect) -> CGFloat {
    switch modalState {
      // TODO: マジックナンバーなので直したい。HalfModalの高さの割合をコンテナの高さと設定してスクロールが効くようにしている。
      case .high: return viewSize.height * 0.8
      case .middle: return viewSize.height * 0.35
      case .low: return viewSize.height * 0.05
    }
  }

  var body: some View {
    VStack(spacing: 25) {
      HStack(alignment: .bottom) {
        NotoBoldText(text: "Nearby Events", size: 20)
        Spacer()
        HStack {
          NotoBoldText(text: "Sort", size: 16)
          Image("InvertedTriangle")
            .resizable()
            .scaledToFit()
            .frame(width: 10, height: 8)
            .offset(y: 1)
        }
      }
      .padding(.trailing, 22)
      ScrollView {
        LazyVStack(spacing: 18) {
          ForEach(events) { event in
            EventListView(
              title: event.title,
              imageName: event.imageName,
              time: event.time,
              description: event.description
            )
            Divider()
              .background(Color(.sRGB, red: 205/255, green: 205/255, blue: 205/255))
          }
        }
        .padding(.trailing, 22)
      }
      .frame(height: getScrollViewHeight(viewSize: UIScreen.main.bounds))
      .frame(maxWidth: .infinity)
    }
  }
}

struct EventListView: View {
  let title: String
  let imageName: String
  let time: String
  let description: String

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        VStack(alignment: .leading, spacing: 8) {
          NotoBoldText(text: title, size: 16)
          NotoBoldText(text: time, size: 14)
            .foregroundColor(Color(.sRGB, red: 31/255, green: 153/255, blue: 0/255))
        }
        Spacer()
        HStack {
          Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 112, height: 74)
        }
      }
      NotoBoldText(text: description, size: 14)
    }
  }
}

#Preview {
    MapView()
}
