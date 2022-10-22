//
//  VideoList.swift
//  ChemistryAR
//
//  Created by NhatMinh on 11/10/2022.
//

import SwiftUI

struct VideoListView: View {
    @Binding var isPushToVideoListView: Bool
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
                VStack(alignment: .leading, spacing: 0) {
                    Image("videobg")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height * 0.36)
                        .clipped()
                        .overlay {
                            Color.black.opacity(0.4)
                        }
                        .overlay(alignment: .topLeading) {
                            makeHeaderView()
                        }
                    makeVideoList()
                }
            }
            .ignoresSafeArea(.all, edges: .top)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

private extension VideoListView {
    func makeVideoList() -> some View {
        ScrollView(showsIndicators: false) {
            ForEach(0..<10) { _ in
                Divider()
                    .padding(.bottom, 12)
                LessonItem()
                    .onTapGesture {
                        isPushToVideoDetailView = true
                    }
                    .padding(.bottom, 12)
            }
            .padding(.horizontal, 12)
        }
    }

    func makeHeaderView() -> some View {
        VStack(alignment: .leading) {
            HStack {
                BackButton {
                    isPushToVideoListView = false
                }
                Spacer()
                Text("Chapter 1")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                Rectangle()
                    .frame(width: 48, height: 48)
                    .opacity(0)
            }
                .padding(.top, 52)
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text("Phản Ứng Oxi Hoá - Khử")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.system(size: 20, weight: .bold))
                Text("Lorem Ipsum chỉ đơn giản là một đoạn văn bản giả, được dùng vào việc trình bày và dàn trang phục vụ cho in ấn. Lorem Ipsum đã được sử dụng như một văn bản chuẩn cho ngành công nghiệp in")
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.leading)
                    .lineLimit(4)
            }
            .padding(.bottom, 36)
        }
        .padding(.horizontal, 20)
    }
}
struct VideoList_Previews: PreviewProvider {
    static var previews: some View {
        VideoListView(isPushToVideoListView: .constant(false))
    }
}
