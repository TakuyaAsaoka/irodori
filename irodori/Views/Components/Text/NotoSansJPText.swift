//
//  NotoSansJPText.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/20.
//

import SwiftUI

struct BaseNotoText: View {
  let text: String
  let size: CGFloat
  let font: FontNames

  var body: some View {
    Text(text)
      .font(.custom(font.rawValue, size: size))
  }
}

struct NotoRegularText: View {
  let text: String
  let size: CGFloat

  var body: some View {
    BaseNotoText(text: text, size: size, font: FontNames.notoSansJpRegular)
  }
}

struct NotoBoldText: View {
  let text: String
  let size: CGFloat

  var body: some View {
    BaseNotoText(text: text, size: size, font: FontNames.notoSansJpBold)
  }
}

#Preview {
  NotoRegularText(text: "HacoText", size: 48)
  NotoBoldText(text: "HacoText", size: 48)
}
