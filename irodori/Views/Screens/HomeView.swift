//
//  HomeView.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/19.
//

import SwiftUI

struct HomeView: View {
  @State private var transferType: TransferType? = nil
  @State private var situationType: SituationType? = nil
  @State private var showMapView: Bool = false

  struct SituationButton: Identifiable, Hashable {
    let id = UUID()
    let text: String
    let type: SituationType
  }

  let buttons: [SituationButton] = [
    SituationButton(text: "Delivery", type: .delivery),
    SituationButton(text: "Event", type: .event),
    SituationButton(text: "Shopping", type: .shopping),
    SituationButton(text: "Airport", type: .airport),
    SituationButton(text: "Emergency", type: .emergency)
  ]

  let columns = [
    GridItem(.flexible(), spacing: 12),
    GridItem(.flexible())
  ]

  var body: some View {
    NavigationStack {
      ZStack(alignment: .top) {
        Image("BaseBackground")
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()

        VStack(spacing: 40) {
          NotoBoldText(text: "HACOHub", size: 64)
            .foregroundColor(.white)
            .padding(.top, 120)

          VStack {
            if transferType == .none {
              VStack {
                Image("ColorfulBox")
                  .padding(.bottom, 20)

                NotoRegularText(text: "With this app, you can check locker availability,\ndrop off your belongings, and pick them up—all\nwith a single tap.\nNo need to worry about large or personal items\nanymore.", size: 15)
                  .multilineTextAlignment(.center)
                  .padding(.bottom, 24)

                HStack {
                  WhiteRoundedButtonView(text: "Pick Up", width: 160, action: {
                    withAnimation(.easeOut(duration: 0.3)) {
                      transferType = .receive
                    }
                  })

                  WhiteRoundedButtonView(text: "Drop Off", width: 160, action: {
                    withAnimation(.easeOut(duration: 0.3)) {
                      transferType = .send
                    }
                  })
                }
              }
              .padding(EdgeInsets(top: 28, leading: 8, bottom: 15, trailing: 8))
            } else {
              VStack {
                NotoRegularText(text: "Where would you like to\nstore your belongings?", size: 24)
                  .padding(.bottom, 32)

                LazyVGrid(columns: columns, alignment: .leading, spacing: 24) {
                  ForEach(buttons) { button in
                    WhiteRoundedButtonView(text: button.text, width: 160) {
                      withAnimation(.easeOut(duration: 0.3)) {
                        situationType = button.type
                        showMapView = true
                      }
                    }
                  }
                }
                .navigationDestination(item: $situationType) { situationType in
                  switch situationType {
                  case .event:
                    MapView()
                  default:
                    EmptyView()
                  }
                }
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(EdgeInsets(top: 34, leading: 8, bottom: 28, trailing: 8))
            }
          }
          .background(Color.white.opacity(0.56))
          .cornerRadius(16)
          .shadow(color: Color.black.opacity(0.2), radius: 32, x: 0, y: 0)
        }
        .padding(.horizontal, 20)
      }
    }
  }
}

#Preview {
    HomeView()
}
