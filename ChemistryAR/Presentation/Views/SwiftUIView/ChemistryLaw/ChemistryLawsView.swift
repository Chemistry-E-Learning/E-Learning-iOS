//
//  ChemistryLawsView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 25/10/2022.
//

import SwiftUI

struct ChemistryLawsView: View {
    @StateObject private var viewModel: LessonsListViewModel
    @Binding var isPushToLawsView: Bool

    init(isPushToLawsView: Binding<Bool>, seriesID: String) {
        _isPushToLawsView = isPushToLawsView
        _viewModel = .init(wrappedValue: LessonsListViewModel(seriesID: seriesID))
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                NavigationLink(
                    destination: NavigationLazyView(
                        LessonDetailView(
                            isPushToLessonDetailView: $viewModel.isPushToLessonDetailView,
                            lessonID: viewModel.lessonID
                        )
                    ),
                    isActive: $viewModel.isPushToLessonDetailView
                ) {
                    EmptyView()
                }
                HeaderListCustomView(
                    isPushToCurrentView: $isPushToLawsView,
                    isLoading: $viewModel.isLoading,
                    series: viewModel.series,
                    lessonCount: viewModel.lessons.count,
                    durationTotal: viewModel.durationTotal,
                    parentHeight: geo.size.height
                )
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(Array(viewModel.lessons.enumerated()), id: \.offset) { index, lesson in
                            BranchLessonItemView(
                                lessonTitle: lesson.lessonName,
                                lessonNumber: index + 1,
                                durationRead: lesson.duration
                            )
                                .redacted(if: viewModel.isLoading)
                                .onTapGesture {
                                    viewModel.onClickLessonItemView(id: lesson.id, index: index + 1)
                                }
                        }
                    }
                    .padding(.bottom, geo.size.height * 0.38)
                }
                .offset(y: geo.size.height * 0.34)
                .padding(.horizontal, 20)
            }
        }
        .ignoresSafeArea(.all)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}
