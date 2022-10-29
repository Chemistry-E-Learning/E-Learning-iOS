//
//  BackCircleButton.swift
//  ChemistryAR
//
//  Created by NhatMinh on 11/10/2022.
//

import SwiftUI

struct BackCircleButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .bold))
                .background(
                    Circle()
                        .fill(Color.black.opacity(0.6))
                        .squareFrame(48)
                )
        }
    }
}

struct BackCircleButton_Previews: PreviewProvider {
    static var previews: some View {
        BackCircleButton(action: {})
    }
}
