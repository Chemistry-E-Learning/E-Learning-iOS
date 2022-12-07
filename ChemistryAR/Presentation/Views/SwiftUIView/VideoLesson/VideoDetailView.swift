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
    @State private var isShowReportSheet = false
    private let lessonNumber: Int

    init(isPushToVideoDetailView: Binding<Bool>, lessonID: String, lessonNumber: Int) {
        _isPushToVideoDetailView = isPushToVideoDetailView
        _viewModel = .init(wrappedValue: LessonDetailViewModel(lessonID: lessonID))
        self.lessonNumber = lessonNumber
        GA4Manager.shared.trackScreenView(.virtualLab)
    }
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 0) {
                if #available(iOS 16.0, *) {
                    HStack {
                        BackButton(action: {
                            isPushToVideoDetailView = false
                        }, fontWeight: .medium, color: .black)
                        Spacer()
                        Text("\(Localization.lessonAttributeTitle.localizedString) \(lessonNumber)")
                            .font(.system(size: 22, weight: .medium))
                        Spacer()
                        Button {
                            isShowReportSheet = true
                        } label: {
                            Image("warning")
                                .resizable()
                                .scaledToFit()
                                .squareFrame(28)
                        }
                        .squareFrame(44)
                    }
                    .padding(.horizontal, 8)
                }
                Spacer()
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
            .fullScreenCover(isPresented: $isShowReportSheet) {
                ReportView(
                    isShowReportView: $isShowReportSheet,
                    contentID: viewModel.lesson.id,
                    contentName: viewModel.lesson.lessonName
                )
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
            ToolbarItem(placement: .automatic) {
                Text("\(Localization.lessonAttributeTitle.localizedString) \(lessonNumber)")
                    .font(.system(size: 22, weight: .medium))
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Spacer()
                    Button {
                        isShowReportSheet = true
                    } label: {
                        Image("warning")
                            .resizable()
                            .scaledToFit()
                            .squareFrame(28)
                    }
                    .squareFrame(44)
                }
                .frame(width: UIScreen.main.bounds.width * 0.356, height: 44)
            }
        }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
    }
}
