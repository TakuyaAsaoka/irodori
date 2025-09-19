//
//  CustomFont.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/19.
//

import SwiftUI

// TODO: 使えてない。フォントを文字列で指定したくないので使えるようにしたい。
extension Font {
  static func customFont(_ name: FontNames, size: CGFloat) -> Font {
    Font(UIFont(name: name.rawValue, size: size)!)
  }
}

public enum FontNames: String {
  case notoSansJpRegular = "NotoSansJP-Thin_Regular"
  case notoSansJpBold = "NotoSansJP-Thin_Bold"
}
