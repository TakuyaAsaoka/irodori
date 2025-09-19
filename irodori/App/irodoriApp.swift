//
//  irodoriApp.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/15.
//

import SwiftUI

@main
struct irodoriApp: App {
  @State private var isActive = false

  var body: some Scene {
    WindowGroup {
      ZStack {
        if isActive {
          HomeView()
            .transition(.opacity)
        } else {
          SplashView {
            isActive = true
          }
          .transition(.opacity)
        }
      }
      .animation(.easeInOut(duration: 0.5), value: isActive)
    }
  }
}
