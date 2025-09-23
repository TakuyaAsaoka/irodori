//
//  MapView.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/16.
//

import SwiftUI
import MapKit
import ResizableSheet

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
  @State private var isShowingEventMap = false

  @State var show = false
  @State var showFull = false
  @State var modalPosition = CGSize.zero
  @State var viewSize = UIScreen.main.bounds
  @State var higthRate = 0.35

  let spots: [String] = [
    "公園A",
    "カフェB",
    "レストランC"
  ]

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
          .mapControls {
            MapUserLocationButton()
          }
          .toolbar(.hidden, for: .navigationBar)

          Button("場所リストを開く") {
            show.toggle()
          }
          HalfModalView()
            .cornerRadius(20)
            .offset(y:show ? viewSize.height * 0.4 : viewSize.height)
            .offset(y: modalPosition.height)
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.9), value: show)

            .gesture(
              DragGesture().onChanged { value in
                modalPosition = value.translation
                if showFull {
                  modalPosition.height += -(viewSize.height * higthRate)
                }
                if modalPosition.height < -(viewSize.height * higthRate) {
                  modalPosition.height = -(viewSize.height * higthRate)
                }
              }
                .onEnded { value in
                  if modalPosition.height > 50 {
                    show = false
                  }
                  if (modalPosition.height < -100 && !showFull) || (modalPosition.height < -250 && showFull) {
                    modalPosition.height = -(viewSize.height * higthRate)
                    showFull = true
                  } else {
                    modalPosition = .zero
                    showFull = false
                  }
                }
            )
        } else {
          ProgressView("現在地取得中...")
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

struct HalfModalView: View {
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.gray)
      VStack {
        RoundedRectangle(cornerRadius: 10)
          .frame(width: 60, height: 5)
          .padding(.top)
        Spacer()
      }
    }
  }
}

#Preview {
    MapView()
}
