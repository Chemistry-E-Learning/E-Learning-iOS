//
//  VideoDetailView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 11/10/2022.
//

import SwiftUI
import AVKit

struct VideoDetailView: View {
    @StateObject private var viewModel: LessonDetailViewModel
    @Binding var isPushToVideoDetailView: Bool
    @State private var contentHeight = CGFloat.zero
    private let lessonNumber: Int

    init(isPushToVideoDetailView: Binding<Bool>, lessonID: String, lessonNumber: Int) {
        _isPushToVideoDetailView = isPushToVideoDetailView
        _viewModel = .init(wrappedValue: LessonDetailViewModel(lessonID: lessonID))
        self.lessonNumber = lessonNumber
    }
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 0) {
                if let player = viewModel.avPlayer {
                    VideoPlayer(player: player)
                        .frame(height: UIScreen.main.bounds.height * 0.3)
                } else {
                    Rectangle()
                        .fill(Color.black.opacity(0.1))
                        .frame(width: getScreenBounds().width, height: UIScreen.main.bounds.height * 0.3)
                        .redacted(if: viewModel.isLoading)
                        .offset(y: getSafeArea(edge: .top) * 0.8)
                }
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        if let tags = viewModel.lesson.lessonTag {
                            TagView(tags: tags)
                                .padding(.top, 12)
                        }
                        Text(viewModel.lesson.lessonName)
                            .font(.system(size: 24, weight: .bold))
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 4)
                            .padding(.top, 6)
                            .padding(.bottom, 12)
                            .redacted(if: viewModel.isLoading)
                        Divider()
                            .padding(.horizontal, 4)
                        if !viewModel.lesson.content.isEmpty {
                            WebView(
                                contentHeight: $contentHeight,
                                isLoading: $viewModel.isLoading,
                                type: .normal,
                                url: viewModel.lesson.content
                            )
                            .frame(height: contentHeight)
                        } else {
                            ContentHolder()
                        }
                    }
                }
                .offset(y: viewModel.isLoading ? getSafeArea(edge: .top) * 0.8 : 0)
                .padding(.horizontal, 16)
            }
            .swipeBack(isPresented: $isPushToVideoDetailView, maxTranslation: geo.size.width / 3)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton(action: {
                    isPushToVideoDetailView = false
                }, fontWeight: .medium, color: .black)
                .padding(.leading, -12)
                .scaleEffect(0.8)
            }
            ToolbarItem(placement: .navigation) {
                Text("\(Localization.lessonAttributeTitle.localizedString) \(lessonNumber)")
                    .font(.system(size: 22, weight: .medium))
                    .padding(.leading, getScreenBounds().width * 0.21)
            }
        }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
    }
}
