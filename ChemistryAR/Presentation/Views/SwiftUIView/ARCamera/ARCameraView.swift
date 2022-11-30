//
//  ARCameraView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 30/11/2022.
//

import SwiftUI

struct ARCameraView: View {
    @State private var isTrackingCard = true
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                ToggleCustomView(isTrackingCard: $isTrackingCard)
                if isTrackingCard {
                    ElementCardTrackingView()
                } else {
                    ChemistryBookTrackingView()
                }
            }
            .padding(.top, 40)
            .padding(.horizontal, 20)
        }
    }
}

struct ARCameraView_Previews: PreviewProvider {
    static var previews: some View {
        ARCameraView()
    }
}
