//
//  ARCameraView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 30/11/2022.
//

import SwiftUI

struct ARCameraView: View {
    @State private var isTrackingCard = true
    @State private var isAnimating = true

    var body: some View {
        ZStack(alignment: .top) {
            if isTrackingCard {
                ElementCardTrackingView()
            } else {
                ChemistryBookTrackingView()
            }
            if isAnimating {
                LottieAnimationView(fileName: "transition")
                    .scaleEffect(0.8)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.isAnimating = false
                        }
                    }
                    .background(Color.white.opacity(0.4))
            }
            HStack {
                Spacer()
                ToggleCustomView(isTrackingCard: $isTrackingCard)
            }
            .padding(.top, 40)
            .padding(.horizontal, 20)
        }
        .onChange(of: isTrackingCard) { _ in
            isAnimating = true
        }
    }
}

struct ARCameraView_Previews: PreviewProvider {
    static var previews: some View {
        ARCameraView()
    }
}
