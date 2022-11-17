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

    init(isPushToVideoDetailView: Binding<Bool>, lessonID: String) {
        _isPushToVideoDetailView = isPushToVideoDetailView
        _viewModel = .init(wrappedValue: LessonDetailViewModel(lessonID: lessonID))
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ToolBarCustomView(
                isPushToCurrentView: $isPushToVideoDetailView,
                title: Localization.experimentVideoTitle.localizedString
            )
            Divider()
            if let player = viewModel.avPlayer {
                VideoPlayer(player: player)
                    .frame(height: UIScreen.main.bounds.height * 0.3)
            }
            Spacer()
            ScrollView(showsIndicators: false) {
                Text(viewModel.lesson.lessonName)
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.leading)
                if !viewModel.lesson.content.isEmpty {
                    WebView(
                        contentHeight: $contentHeight,
                        isLoading: .constant(false),
                        type: .normal,
                        url: viewModel.lesson.content
                    )
                    .frame(height: contentHeight)
                }
            }
            .padding(.horizontal, 20)
        }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
    }
}
