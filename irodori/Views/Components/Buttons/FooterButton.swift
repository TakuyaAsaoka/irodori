//
//  FooterButton.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/27.
//

import SwiftUI

struct FooterButton: View {
  let homeAction: () -> Void = { }
  let lockerAction: () -> Void = { }

  var body: some View {
    HStack {
      Button {
        homeAction()
      } label: {
        VStack(spacing: 0) {
          Image("HomeIcon")
            .resizable()
            .frame(width: 40, height: 40)

          NotoBoldText(text: "Home", size: 16)
            .foregroundColor(Color(red: 69/255, green: 69/255, blue: 69/255))
        }
      }
      .frame(maxWidth: .infinity)
      .padding(.leading, 24)

      Divider()

      Button {
        lockerAction()
      } label: {
        VStack(spacing: 0) {
          Image("LockerIcon")
            .resizable()
            .frame(width: 40, height: 40)

          NotoBoldText(text: "My Locker", size: 16)
            .foregroundColor(Color(red: 69/255, green: 69/255, blue: 69/255))
        }
      }
      .frame(maxWidth: .infinity)
      .padding(.trailing, 24)
    }
    .frame(width: 372, height: 74)
    .padding(.vertical, 9)
    .background(Color(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.95))
    .cornerRadius(85)
    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
  }
}

#Preview {
    FooterButton()
}
