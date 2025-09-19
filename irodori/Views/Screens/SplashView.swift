//
//  SplashView.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/18.
//

import SwiftUI

struct SplashView: View {
  let onFinished: () -> Void

  var body: some View {
    VStack(alignment: .trailing) {
      NotoBoldText(text: "HACOHub", size: 64)
        .foregroundColor(Color(red: 220/255, green: 185/255, blue: 127/255, opacity: 1.0))
      NotoBoldText(text: "@TOYOTA AUTO BODY", size: 13)
        .foregroundColor(Color(red: 102/255, green: 102/255, blue: 102/255, opacity: 1.0))
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        withAnimation {
          onFinished()
        }
      }
    }
  }
}

#Preview {
  SplashView {}
}
