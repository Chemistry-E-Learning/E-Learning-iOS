//
//  BackButton.swift
//  ChemistryAR
//
//  Created by NhatMinh on 11/10/2022.
//

import SwiftUI

struct BackButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(.white.opacity(0.4))
                .overlay {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .medium))
                }
                .frame(width: 48, height: 48)
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton(action: {})
            .background(Color.black.opacity(0.4))
    }
}
