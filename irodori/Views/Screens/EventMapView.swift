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

      FooterButton()
        .padding(.bottom, 30)
    }
  }
}

#Preview {
    EventMapView()
}
