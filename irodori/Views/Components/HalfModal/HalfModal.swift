//
//  HalfModalView.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/23.
//

import SwiftUI

struct HalfModalView: View {
  @State private var modalState: ModalState = .middle
  @Binding var position: CGSize
  let viewSize: CGRect
  let lowOffset: CGFloat
  let middleOffset: CGFloat
  let highOffset: CGFloat

  init(position: Binding<CGSize>, viewSize: CGRect) {
    self._position = position
    self.viewSize = viewSize
    self.lowOffset = viewSize.height * 0.812
    self.middleOffset = viewSize.height * 0.512
    self.highOffset = viewSize.height * 0.073
  }

  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.white)
      VStack {
        RoundedRectangle(cornerRadius: 10)
          .frame(width: 50, height: 8)
          .padding(.top)
          .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
        Spacer()
      }
    }
    .frame(height: viewSize.height)
    .cornerRadius(20)
    .offset(y: getOffset() + position.height)
    .gesture(
        DragGesture()
          .onChanged { value in
            var translation = value.translation
            let currentOffset = getOffset() + translation.height

            if currentOffset < highOffset {
              translation.height = highOffset - getOffset() + (translation.height - (highOffset - getOffset())) * 0.1
            }

            if currentOffset > lowOffset {
              translation.height = lowOffset - getOffset() + (translation.height - (lowOffset - getOffset())) * 0.1
            }

            position = translation
        }
      .onEnded { value in
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.3)) {
          let dragAmount = value.translation.height

          switch modalState {
          case .high:
            if dragAmount > 30 {
              modalState = .middle
            }
          case .middle:
            if dragAmount < -30 {
              modalState = .high
            } else if dragAmount > 30 {
              modalState = .low
            }
          case .low:
            if dragAmount < -30 {
              modalState = .middle
            }
          }
          position = .zero
        }
      }
    )
  }

  private func getOffset() -> CGFloat {
    switch modalState {
      case .low:
        return lowOffset
      case .middle:
        return middleOffset
      case .high:
        return highOffset
    }
  }
}

#Preview {
  HalfModalView(
    position: Binding.constant(CGSize.zero),
    viewSize: UIScreen.main.bounds,

  )
}
