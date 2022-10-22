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
        GeometryReader { geo in
            VStack {
                VideoPlayer(player: player)
                    .aspectRatio(4 / 2.6, contentMode: .fit)
                    .frame(width: geo.size.width)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Button(action: {
                        isPushToVideoDetailView = false
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                    })
                    .buttonStyle(ScaleButtonStyle())
                    .padding(.vertical, 4)
                }
            }
        }
    }
}

struct VideoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetailView(isPushToVideoDetailView: .constant(false))
    }
}
