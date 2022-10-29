//
//  BackButton.swift
//  ChemistryAR
//
//  Created by NhatMinh on 29/10/2022.
//

import SwiftUI

struct BackButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .bold))
        }
        .squareFrame(48)
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton(action: {})
    }
}
