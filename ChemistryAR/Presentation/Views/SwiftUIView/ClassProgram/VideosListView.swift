//
//  ChaptersListView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 24/10/2022.
//

import SwiftUI

struct VideosListView: View {
    @Binding var isPushToVideosListView: Bool
    @State private var isPushToVideoDetailView = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                NavigationLink(
                    destination: NavigationLazyView(
                        VideoDetailView(isPushToVideoDetailView: $isPushToVideoDetailView)
                    ),
                    isActive: $isPushToVideoDetailView
                ) {
                    EmptyView()
                }
                Color.cE1E1E1.opacity(0.3).edgesIgnoringSafeArea(.all)
                VStack {
                    Image("chapterBG")
                        .resizable()
                        .scaledToFill()
                        .frame(height: geo.size.height * 0.12)
                        .overlay (
                            VStack(alignment: .leading, spacing: 20) {
                                Button(action: {
                                    isPushToVideosListView = false
                                }, label: {
                                    Image(systemName: "arrow.backward")
                                        .foregroundColor(.white)
                                        .font(.system(size: 28, weight: .bold))
                                })
                                VStack(alignment: .leading, spacing: 20) {
                                    Text("Chapter 1")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.white)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("20 Sections - 40 Videos")
                                        Text("Le lorem ipsum est, en imprimerie, une suite de mots sans signification utilisée à titre provisoire pour")
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(2)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                                }
                                    .padding(12)
                                    .background(
                                        Color.black.opacity(0.3)
                                            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                                            .blur(radius: 1)
                                            .shadow(
                                                color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1
                                            )
                                    )
                            }
                                .padding(.top, 16)
                                .padding(.horizontal, 32)
                            , alignment: .topLeading
                        )
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(0..<20) { _ in
                                Button {
                                    isPushToVideoDetailView = true
                                } label: {
                                    VideoItemView()
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 80)
                    }
                    .offset(y: geo.size.height * 0.14)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ChaptersListView_Previews: PreviewProvider {
    static var previews: some View {
        VideosListView(isPushToVideosListView: .constant(false))
    }
}
