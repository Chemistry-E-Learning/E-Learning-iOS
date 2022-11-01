//
//  ChaptersListView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 11/10/2022.
//

import SwiftUI

struct ChaptersListView: View {
    @Binding var isPushToChaptersListView: Bool
    @State private var isPushToVideosListView = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.cE1E1E1.opacity(0.3).edgesIgnoringSafeArea(.all)
                NavigationLink(
                    destination: NavigationLazyView(
                        VideosListView(isPushToVideosListView: $isPushToVideosListView)
                    ),
                    isActive: $isPushToVideosListView
                ) {
                    EmptyView()
                }
                VStack(alignment: .leading, spacing: 0) {
                    makeHeaderView(height: geo.size.height)
                    makeVideoList()
                }
            }
            .ignoresSafeArea(.all, edges: .all)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

private extension ChaptersListView {
    func makeVideoList() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(0..<10) { _ in
                    ChapterItemView()
                        .onTapGesture {
                            isPushToVideosListView = true
                        }
                }
            }
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
    }

    func makeHeaderView(height: CGFloat) -> some View {
        Button {
            isPushToChaptersListView = false
        } label: {
            HStack {
                Image(systemName: AppConstant.BackImage)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black.opacity(0.7))
                VStack(alignment: .leading, spacing: 4) {
                    Text(Localization.classProgramAttributeTitle.localizedString + " \(8)")
                        .foregroundColor(.black.opacity(0.7))
                        .font(.system(size: 24, weight: .medium))
                    Text("\(20) \(Localization.chaptersAttributeTitle.localizedString) - \(30) videos")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.black.opacity(0.6))
                }
                .padding(.horizontal, 8)
                Spacer()
            }
            .padding(.horizontal, 28)
            .padding(.top, height * 0.08)
            .padding(.bottom, 28)
        }
    }
}
struct VideoList_Previews: PreviewProvider {
    static var previews: some View {
        ChaptersListView(isPushToChaptersListView: .constant(false))
    }
}
