//
//  BackButton.swift
//  ChemistryAR
//
//  Created by NhatMinh on 29/10/2022.
//

import SwiftUI

struct BackButton: View {
    let action: () -> Void
    let fontWeight: Font.Weight
    let color: Color

    init(action: @escaping () -> Void, fontWeight: Font.Weight? = .bold, color: Color? = .white) {
        self.action = action
        self.fontWeight = fontWeight ?? .bold
        self.color = color ?? .white
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .foregroundColor(color)
                .font(.system(size: 24, weight: fontWeight))
        }
        .squareFrame(48)
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton(action: {})
    }
}
