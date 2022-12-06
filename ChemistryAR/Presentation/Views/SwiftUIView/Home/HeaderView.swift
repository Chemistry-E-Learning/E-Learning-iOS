//
//  HeaderView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 09/10/2022.
//

import SwiftUI

struct HeaderView: View {
    @Binding var isPushToUserSettingView: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .lastTextBaseline) {
                    Text(Localization.welcomeBackTitle.localizedString)
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(.gray)
                    Image("hand")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
                Text("Minh Nguyen")
                    .font(.system(size: 15, weight: .medium))
            }
            Spacer()
            Button {
                isPushToUserSettingView = true
            } label: {
                Image("avatar")
                    .resizable()
                    .squareFrame(48)
                    .clipShape(Circle())
            }
            .squareFrame(48)
        }
        .padding(.vertical, 12 )
        .padding(.horizontal, 20)
        .background(Color.clear)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(isPushToUserSettingView: .constant(false))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
