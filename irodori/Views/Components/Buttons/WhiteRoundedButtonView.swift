//
//  WhiteRoundedButtonView.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/20.
//

import SwiftUI

struct WhiteRoundedButtonView: View {
  let text: String
  let width: CGFloat
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      NotoBoldText(text: text, size: 20)
        .foregroundColor(Color(red: 198/255, green: 150/255, blue: 69/255))
        .padding(.vertical, 16)
        .frame(width: width)
    }
    .background(Color.white)
    .cornerRadius(72)
    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
  }
}


#Preview {
  WhiteRoundedButtonView(text: "test", width: 200, action: {})
}
