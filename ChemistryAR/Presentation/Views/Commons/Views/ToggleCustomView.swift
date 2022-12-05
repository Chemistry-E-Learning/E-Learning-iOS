//
//  ToggleCustomView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 30/11/2022.
//

import SwiftUI

struct ToggleCustomView: View {
    @Binding var isTrackingCard: Bool
    var body: some View {
        HStack {
            if !isTrackingCard {
                Spacer()
            }
            Circle()
                .fill(Color.white)
                .squareFrame(40)
                .overlay(
                    Image(isTrackingCard ? "card" : "book")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                )
            if isTrackingCard {
                Spacer()
            }
        }
        .padding(.horizontal, 4)
        .frame(width: 90, height: 48)
        .background(
            Color.white.opacity(0.5).onTapGesture {
                isTrackingCard.toggle()
            }
        )
        .cornerRadius(24)
    }
}

struct ToggleCustomView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            Spacer()
            ToggleCustomView(isTrackingCard: .constant(true))
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.black)
    }
}
