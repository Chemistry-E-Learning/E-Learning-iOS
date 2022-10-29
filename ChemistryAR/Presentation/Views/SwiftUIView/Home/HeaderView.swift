//
//  HeaderView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 09/10/2022.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .lastTextBaseline) {
                    Text("Welcome Back")
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
            Image("avatar")
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
        .background(Color.clear)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
