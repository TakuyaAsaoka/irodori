//
//  PrimaryRoundedButton.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/28.
//

import SwiftUI

struct PrimaryRoundedButton: View {
  let text: String
  let width: CGFloat
  let action: () -> Void

  var body: some View {
    Button {
      action()
    } label: {
      NotoBoldText(text: text, size: 20)
        .foregroundColor(Color.white)
        .padding(.vertical, 8)
        .frame(width: width)
    }
    .background(Color(.sRGB, red: 198/255, green: 150/255, blue: 69/255))
    .cornerRadius(72)
    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
  }
}

#Preview {
  PrimaryRoundedButton(text: "test", width: 200, action: {})
}
