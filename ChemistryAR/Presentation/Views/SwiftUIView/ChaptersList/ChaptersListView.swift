//
//  ChaptersListView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 11/10/2022.
//

import SwiftUI

struct ChaptersListView: View {
    @StateObject private var viewModel: ChaptersListViewModel
    @Binding var isPushToChaptersListView: Bool

    let program: Series
    let videosNumber: Int

    init(isPushToChaptersListView: Binding<Bool>, program: Series, videosNumber: Int) {
        _isPushToChaptersListView = isPushToChaptersListView
        self.program = program
        self.videosNumber = videosNumber
        _viewModel = .init(wrappedValue: ChaptersListViewModel(seriesID: program.id))
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.white
                NavigationLink(
                    destination: NavigationLazyView(
                        VideosListView(
                            isPushToVideosListView: $viewModel.isPushToVideosListView,
                            seriesID: viewModel.seriesID,
                            chapterNumber: viewModel.chapterNumber
                        )
                    ),
                    isActive: $viewModel.isPushToVideosListView
                ) {
                    EmptyView()
                }
                VStack(alignment: .leading, spacing: 0) {
                    makeHeaderView(height: geo.size.height)
                    Divider()
                    makeVideoList()
                        .background {
                            Color.cE1E1E1.opacity(0.3).edgesIgnoringSafeArea(.bottom)
                        }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

private extension ChaptersListView {
    func makeVideoList() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(Array(viewModel.programDetailSeries.enumerated()), id: \.offset) { index, item in
                    Button {
                        viewModel.onClickChapterItemView(id: item.id, index: index + 1)
                    } label: {
                        ChapterItemView(programDetail: item, chapter: index + 1)
                            .padding(.top, index == 0 ? 24 : 0)
                    }
                }
            }
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
                    Text(Localization.classProgramAttributeTitle.localizedString + " \(program.seriesName.getClassProgram())")
                        .foregroundColor(.black.opacity(0.7))
                        .font(.system(size: 24, weight: .medium))
                    Text("\(program.childSeriesNumber ?? 0) \(Localization.chaptersAttributeTitle.localizedString) - \(videosNumber) videos")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.black.opacity(0.6))
                }
                .padding(.horizontal, 8)
                Spacer()
            }
            .padding(.horizontal, 28)
            .padding(.bottom, 20)
        }
    }
}
