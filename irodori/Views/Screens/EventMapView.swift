//
//  EventMapView.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/22.
//

import SwiftUI

struct EventMapView: View {
  var body: some View {
    ZStack(alignment: .bottom) {
      Image("EventMap")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

      Button {
        print("Pin tapped!")
      } label: {
        Image("EventAvailabilityPin")
          .resizable()
          .frame(width: 106, height: 175)
      }
      .position(x: 160, y: 120)

      Button {
        print("Pin tapped!")
      } label: {
        Image("EventAvailabilityPin")
          .resizable()
          .frame(width: 106, height: 175)
      }
      .position(x: 340, y: 140)

      Button {
        print("Pin tapped!")
      } label: {
        Image("EventLimitedAvailabilityPin")
          .resizable()
          .frame(width: 113, height: 135)
      }
      .position(x: 310, y: 230)

      Button {
        print("Pin tapped!")
      } label: {
        Image("EventNoAvailabilityPin")
          .resizable()
          .frame(width: 92, height: 128)
      }
      .position(x: 182, y: 328)

      Button {
        print("Pin tapped!")
      } label: {
        Image("EventNoAvailabilityPin")
          .resizable()
          .frame(width: 92, height: 128)
      }
      .position(x: 176, y: 630)

      Spacer()
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
  }
}

#Preview {
    EventMapView()
}
