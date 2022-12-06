//
//  HeaderView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 09/10/2022.
//

import SwiftUI

struct HeaderView: View {
    @Binding var isPushToUserSettingView: Bool
    @State private var image: Image = Image("avatar")

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
                Text(UserDefaultsData.shared.username)
                    .font(.system(size: 15, weight: .medium))
            }
            Spacer()
            Button {
                isPushToUserSettingView = true
            } label: {
                image
                    .resizable()
                    .squareFrame(48)
                    .clipShape(Circle())
            }
            .squareFrame(48)
        }
        .onAppear {
            loadImageUserDefault()
        }
        .padding(.vertical, 12 )
        .padding(.horizontal, 20)
        .background(Color.clear)
    }
}

private extension HeaderView {
    func loadImageUserDefault() {
        guard let data = UserDefaults.standard.data(forKey: "avatar") else { return }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        if let uiImage = UIImage(data: decoded) {
            image = Image(uiImage: uiImage)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(isPushToUserSettingView: .constant(false))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
