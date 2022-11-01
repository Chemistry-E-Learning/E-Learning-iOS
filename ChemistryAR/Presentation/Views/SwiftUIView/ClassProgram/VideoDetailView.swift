//
//  VideoDetailView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 11/10/2022.
//

import SwiftUI
import AVKit

struct VideoDetailView: View {
    @Binding var isPushToVideoDetailView: Bool
    @State var player = AVPlayer(url: URL(string: "https://swiftanytime-content.s3.ap-south-1.amazonaws.com/SwiftUI-Beginner/Video-Player/iMacAdvertisement.mp4")!)

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ToolBarCustomView(
                isPushToCurrentView: $isPushToVideoDetailView,
                title: Localization.experimentVideoTitle.localizedString
            )
            Divider()
            VideoPlayer(player: player)
                .frame(height: UIScreen.main.bounds.height * 0.3)
            Spacer()
            ScrollView(showsIndicators: false) {
                Text("Phan Ung Oxi Hoa Khu")
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.leading)
                // Content Here
            }
            .padding(.horizontal, 20)
        }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct VideoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetailView(isPushToVideoDetailView: .constant(false))
    }
}
