//
//  ControlButtonGroup.swift
//  ChemistryAR
//
//  Created by NhatMinh on 21/11/2022.
//

import SwiftUI

struct ControlButtonGroup: View {
    @Binding var index: Int
    let dataCount: Int

    var body: some View {
        HStack(spacing: 80) {
            Button {
                index = index == 0 ? dataCount - 1 : index - 1
            } label: {
                Image(systemName: "backward.fill")
                    .scaleEffect(2.4)
            }
            Button {
                index = index == dataCount - 1 ? 0 : index + 1
            } label: {
                Image(systemName: "forward.fill")
                    .scaleEffect(2.4)
            }
        }
        .foregroundColor(.white)
    }
}

struct ControlButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        ControlButtonGroup(index: .constant(0), dataCount: 3)
            .padding(40)
            .background(Color.black)
    }
}
