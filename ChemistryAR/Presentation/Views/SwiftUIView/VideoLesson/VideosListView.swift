//
//  ChaptersListView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 24/10/2022.
//

import SwiftUI

struct VideosListView: View {
    @StateObject private var viewModel: LessonsListViewModel
    @Binding var isPushToVideosListView: Bool

    init(isPushToVideosListView: Binding<Bool>, seriesID: String) {
        _isPushToVideosListView = isPushToVideosListView
        _viewModel = .init(wrappedValue: LessonsListViewModel(seriesID: seriesID))
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                NavigationLink(
                    destination: NavigationLazyView(
                        VideoDetailView(
                            isPushToVideoDetailView: $viewModel.isPushToLessonDetailView,
                            lessonID: viewModel.lessonID
                        )
                    ),
                    isActive: $viewModel.isPushToLessonDetailView
                ) {
                    EmptyView()
                }
                Color.cE1E1E1.opacity(0.3).edgesIgnoringSafeArea(.all)
                VStack {
                    ImageFromUrlView(image: viewModel.series.coverImage?.url ?? "")
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
                                makeHeaderContentView()
                            }
                                .padding(.top, 16)
                                .padding(.horizontal, 32)
                            , alignment: .topLeading
                        )
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(Array(viewModel.lessons.enumerated()), id: \.offset) { index, lesson in
                                VideoItemView(title: lesson.lessonName, index: index + 1)
                                    .onTapGesture {
                                        viewModel.onClickLessonItemView(id: lesson.id)
                                    }
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

private extension VideosListView {
    func makeHeaderContentView() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("\(Localization.chapterAttributeTitle.localizedString) \(1)")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            VStack(alignment: .leading, spacing: 4) {
                Text("\(viewModel.lessons.count) \(Localization.lessonsAttributeTitle.localizedString) - \(viewModel.videoNumber) Videos")
                Text(viewModel.series.description ?? AppConstant.NoContent)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .foregroundColor(.white)
            .font(.system(size: 14, weight: .regular))
        }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(Color.black.opacity(0.3))
                    .blur(radius: 1)
                    .shadow(
                        color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1
                    )
            )
    }
}

