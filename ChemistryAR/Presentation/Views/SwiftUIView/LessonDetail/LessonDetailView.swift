//
//  LessonDetailView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 25/10/2022.
//

import SwiftUI

struct LessonDetailView: View {
    @StateObject private var viewModel: LessonDetailViewModel
    @Binding var isPushToLessonDetailView: Bool
    @State private var contentHeight = CGFloat.zero
    @State private var headerOffset = CGFloat.zero

    init(isPushToLessonDetailView: Binding<Bool>, lessonID: String) {
        _isPushToLessonDetailView = isPushToLessonDetailView
        _viewModel = .init(wrappedValue: LessonDetailViewModel(lessonID: lessonID))
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        makeHeaderView(size: geo.size)
                            .background(
                                GeometryReader {
                                    Color.clear.preference(
                                        key: ViewOffsetKey.self,
                                        value: -$0.frame(in: .named("scroll")).origin.y
                                    )
                                }
                            )
                        WebView(
                            contentHeight: $contentHeight,
                            isLoading: .constant(false),
                            type: .normal,
                            url: viewModel.lesson.content
                        )
                        .frame(height: contentHeight)
                        .padding(.top, geo.size.height * 0.03)
                        .padding(.horizontal, 20)
                    }
                }
                .onPreferenceChange(ViewOffsetKey.self) {
                    headerOffset = $0
                }
                .coordinateSpace(name: "scroll")
                makeStickerHeaderView(size: geo.size)
            }
        }
        .ignoresSafeArea(.all)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension LessonDetailView {
    func makeStickerHeaderView(size: CGSize) -> some View {
        HStack {
            BackButton {
                isPushToLessonDetailView = false
            }
            Spacer()
            makeTitleView(title: viewModel.lesson.lessonName, isSticker: true)
            Spacer()
            Rectangle()
                .fill(Color.clear)
                .squareFrame(48)
        }
        .padding(.top, 28)
        .padding(.horizontal, 8)
        .frame(width: size.width, height: size.height * 0.12)
        .background(Color.mainColor)
        .opacity(headerOffset >= size.height * 0.28 ? 1 : 0)
        .animation(.spring(), value: headerOffset)
    }

    func makeHeaderView(size: CGSize) -> some View {
        ImageFromUrlView(image: viewModel.lesson.coverImageURL)
            .overlay {
                ZStack(alignment: .topLeading) {
                    Color.black.opacity(0.4)
                    VStack(alignment: .leading, spacing: 6) {
                        BackCircleButton {
                            isPushToLessonDetailView = false
                        }
                        .padding(.horizontal, 8)
                        VStack(alignment: .leading) {
                            makeTitleView(title: viewModel.lesson.lessonName)
                            if let tags = viewModel.lesson.lessonTag {
                                TagView(tags: tags)
                            }
                        }
                        .padding(.top, 32)
                    }
                    .padding(.top, size.height * 0.06)
                    .padding(.horizontal, 60)
                }
            }
            .frame(width: size.width, height: size.height * 0.3)
            .clipped()
            .offset(y: (headerOffset < 0 ? headerOffset : 0))
    }

    func makeTitleView(title: String, isSticker: Bool = false) -> some View {
        Text(title)
            .multilineTextAlignment(.leading)
            .lineLimit(isSticker ? 1 : 2)
            .font(.system(size: isSticker ? 24 : 32, weight: .bold))
            .foregroundColor(.white)
    }
}
