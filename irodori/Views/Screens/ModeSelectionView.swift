//
//  ModeSelectionView.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/16.
//

import SwiftUI

struct ModeSelectionView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text("モードを選択")
                    .font(.title)
                    .padding(.top, 60)

                HStack(spacing: 30) {
                    NavigationLink {
                        MapView()
                    } label: {
                        VStack {
                            Image(systemName: "lock.circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.blue)
                            Text("ロッカーモード")
                                .font(.headline)
                        }
                    }
                    // 他のモード追加はここに
                }
                Spacer()
            }
        }
    }
}
