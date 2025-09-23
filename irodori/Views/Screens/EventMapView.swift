//
//  EventMapView.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/22.
//

import SwiftUI

struct EventMapView: View {
    var body: some View {
      ZStack {
        Image("EventMap")
          .resizable()
          .scaledToFill()
          .aspectRatio(contentMode: .fill)
          .ignoresSafeArea()
      }
    }
}

#Preview {
    EventMapView()
}
