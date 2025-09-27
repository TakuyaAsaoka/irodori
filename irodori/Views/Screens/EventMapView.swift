//
//  EventMapView.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/22.
//

import SwiftUI

struct EventPin: Identifiable {
  let id = UUID()
  let imageName: String
  let width: CGFloat
  let height: CGFloat
  let position: CGPoint
}

struct LegendItem: Identifiable {
  let id = UUID()
  let imageName: String
  let width: CGFloat
  let height: CGFloat
  let label: String
  let color: Color
}

enum LockerStatus {
  case available
  case unavailable
}

struct Locker: Identifiable, Hashable {
  let id = UUID()
  let status: LockerStatus
}

struct EventMapView: View {
  @State private var selectedPin: EventPin? = nil
  @State private var isShowingSheet = false

  let pins: [EventPin] = [
    EventPin(imageName: "EventAvailabilityPin", width: 106, height: 175, position: CGPoint(x: 160, y: 120)),
    EventPin(imageName: "EventAvailabilityPin", width: 106, height: 175, position: CGPoint(x: 340, y: 140)),
    EventPin(imageName: "EventLimitedAvailabilityPin", width: 113, height: 135, position: CGPoint(x: 310, y: 230)),
    EventPin(imageName: "EventNoAvailabilityPin", width: 92, height: 128, position: CGPoint(x: 182, y: 328)),
    EventPin(imageName: "EventNoAvailabilityPin", width: 92, height: 128, position: CGPoint(x: 176, y: 630))
  ]

  let legendItems: [LegendItem] = [
    LegendItem(imageName: "EventAvailabilityPin", width: 39, height: 65, label: "Availability", color: Color(red: 122/255, green: 203/255, blue: 176/255)),
    LegendItem(imageName: "EventLimitedAvailabilityPin", width: 41, height: 48, label: "Limited\nAvailability", color: Color(red: 1, green: 209/255, blue: 45/255)),
    LegendItem(imageName: "EventNoAvailabilityPin", width: 39, height: 54, label: "Availability", color: Color(red: 252/255, green: 68/255, blue: 64/255)),
    LegendItem(imageName: "EventMyLockerPin", width: 47, height: 57, label: "My\nLocker", color: Color(red: 27/255, green: 93/255, blue: 215/255))
  ]

  let lockers: [Locker] = [
    Locker(status: .unavailable),
    Locker(status: .available),
    Locker(status: .available),
    Locker(status: .available),
    Locker(status: .available),
    Locker(status: .available),
    Locker(status: .unavailable),
    Locker(status: .available),
    Locker(status: .unavailable),
    Locker(status: .unavailable),
    Locker(status: .available),
    Locker(status: .available),
    Locker(status: .unavailable),
    Locker(status: .available),
    Locker(status: .available),
    Locker(status: .available),
    Locker(status: .available),
    Locker(status: .unavailable)
  ]

  let columns = [
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible())
  ]

  var body: some View {
    ZStack(alignment: .bottom) {
      Image("EventMap")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

      ForEach(pins) { pin in
        Button {
          selectedPin = pin
          isShowingSheet = true
        } label: {
          Image(pin.imageName)
            .resizable()
            .frame(width: pin.width, height: pin.height)
        }
        .position(pin.position)
      }

      VStack(spacing: 8) {
        VStack(spacing: 0) {
          Image("EventAvailabilityPin")
            .resizable()
            .scaledToFit()
            .frame(width: 39, height: 65)
          NotoBoldText(text: "Availability", size: 8)
            .foregroundColor(Color(.sRGB, red: 122/255, green: 203/255, blue: 176/255))
        }
        VStack(spacing: 0) {
          Image("EventLimitedAvailabilityPin")
            .resizable()
            .scaledToFit()
            .frame(width: 41, height: 48)
          NotoBoldText(text: "Limited\nAvailability", size: 8)
            .foregroundColor(Color(.sRGB, red: 1, green: 209/255, blue: 45/255))
            .multilineTextAlignment(.center)
        }
        VStack(spacing: 0) {
          Image("EventNoAvailabilityPin")
            .resizable()
            .scaledToFit()
            .frame(width: 39, height: 54)
          NotoBoldText(text: "Availability", size: 8)
            .foregroundColor(Color(.sRGB, red: 252/255, green: 68/255, blue: 64/255))
        }
        VStack(spacing: 0) {
          Image("EventMyLockerPin")
            .resizable()
            .scaledToFit()
            .frame(width: 47, height: 57)
          NotoBoldText(text: "My\nLocker", size: 8)
            .foregroundColor(Color(.sRGB, red: 27/255, green: 93/255, blue: 215/255))
            .multilineTextAlignment(.center)
        }
      }
      .frame(width: 55, height: 351)
      .background(Color.white)
      .cornerRadius(32)
      .padding(.leading, 320)
      .padding(.bottom, 130)

      FooterButton()
        .padding(.bottom, 30)
    }
    .sheet(isPresented: $isShowingSheet) {
      VStack {
        RoundedRectangle(cornerRadius: 10)
          .frame(width: 50, height: 8)
          .padding(.top)
          .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
        VStack {
          HStack(alignment: .center) {
            NotoBoldText(text: events[0].title, size: 20)
            Spacer()
            Button {
              isShowingSheet = false
            } label: {
              Image("CloseButton")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
            }
          }
          HStack(alignment: .top) {
            VStack(alignment: .leading) {
              NotoBoldText(text: events[0].time, size: 20)
              NotoBoldText(text: "$4~12", size: 20)
                .foregroundColor(Color(.sRGB, red: 31/255, green: 153/255, blue: 0/255))
            }
            Spacer()
            Image("LockerCar")
              .resizable()
              .scaledToFit()
              .frame(width: 182)
          }

          HStack(spacing: 20) {
            PrimaryRoundedButton(text: "Small", width: 104, action: {})
            PrimaryRoundedButton(text: "Medium", width: 104, action: {})
            PrimaryRoundedButton(text: "Large", width: 104, action: {})
          }

          LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
            ForEach(Array(lockers.enumerated()), id: \.element.id) { index, locker in
              Button {
              } label: {
                Rectangle()
                  .fill(getLockerStatusColor(for: locker))
                  .frame(height: 50)
                  .overlay(
                    NotoRegularText(text: String(format: "%02d", index + 1), size: 15)
                    .padding(.leading, 4)
                    .foregroundColor(Color.black),
                    alignment: .topLeading
                  )
                  .cornerRadius(8)
              }
            }
          }
          Spacer()
        }
        .padding(.horizontal, 8)
      }
    }
  }

  private func getLockerStatusColor(for locker: Locker) -> Color {
    switch locker.status {
    case .available:
      return Color(.sRGB, red: 184/255, green: 249/255, blue: 120/255)
    case .unavailable:
      return Color(.sRGB, red: 1, green: 172/255, blue: 172/255)
    }
  }
}

#Preview {
    EventMapView()
}
