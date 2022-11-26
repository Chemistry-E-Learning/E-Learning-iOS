//
//  ElementDetailView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 29/10/2022.
//

import SwiftUI

struct ElementDetailView: View {
    @StateObject private var viewModel: ElementViewModel
    @Binding var isPushToElementDetailView: Bool
    @State private var headerOffset = CGFloat.zero
    @State private var model = Element3DModel.emptyData
    @State private var index = 0

    init(isPushToElementDetailView: Binding<Bool>, elementID: String) {
        _isPushToElementDetailView = isPushToElementDetailView
        _viewModel = .init(wrappedValue: ElementViewModel(elementID: elementID))
    }
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                NavigationLink(
                    destination: NavigationLazyView(
                        ElementWikipediaView(
                            isPushToWikipediaView: $viewModel.isShowWikipediaView,
                            url: viewModel.element.source
                        )
                    ),
                    isActive: $viewModel.isShowWikipediaView
                ) {
                    EmptyView()
                }
                makeButtonGroupView()
                    .padding(.top, getSafeArea(edge: .top) - 8)
                    .zIndex(99)
                if !viewModel.isShowARCamera {
                    makeHeaderView(size: geo.size)
                        .zIndex(1)
                }
                ScrollView(showsIndicators: false) {
                    VStack {
                        OverviewSectionView(overview: viewModel.overview, parentSize: geo.size)
                            .redacted(if: viewModel.isLoading)
                        NatureSectionView(nature: viewModel.nature, parentSize: geo.size)
                            .redacted(if: viewModel.isLoading)
                        AtomParametersView(parameters: viewModel.atomParameters, parentSize: geo.size)
                            .redacted(if: viewModel.isLoading)
                    }
                    .offset(y: getContentOffset(height: geo.size.height))
                    .padding(.bottom, geo.size.height * 0.36)
                    .background(
                        GeometryReader {
                            Color.clear.preference(
                                key: ViewOffsetKey.self,
                                value: -$0.frame(in: .named("scroll")).origin.y
                            )
                        }
                    )
                }
                .onPreferenceChange(ViewOffsetKey.self) {
                    headerOffset = $0
                    let _ = getHeaderOffset(height: geo.size.height)
                }
                .coordinateSpace(name: "scroll")
                if viewModel.isShowARCamera {
                    make3DViewer(height: geo.size.height)
                }
            }
            .swipeBack(isPresented: $isPushToElementDetailView, maxTranslation: geo.size.width / 3)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension ElementDetailView {
    @ViewBuilder func make3DViewer(height: CGFloat) -> some View {
        if let models = viewModel.models {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottom) {
                    CustomSceneView(model: $model)
                        .frame(height: height * 0.28)
                        .background(Color.black)
                }
                .onAppear {
                    model = models.first ?? Element3DModel.emptyData
                }
                .onChange(of: index) { _ in
                    if index >= 0 && index < models.count {
                        model = models[index]
                    }
                }
                HStack {
                    Rectangle()
                        .squareFrame(44)
                        .padding(.leading, 16)
                    Spacer()
                    ControlButtonGroup(index: $index, dataCount: models.count)
                        .scaleEffect(0.5)
                    Spacer()
                    Button {
                        viewModel.onClickCameraButton()
                    } label: {
                        Image("ic_3d")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                    }
                    .squareFrame(36)
                    .padding(.trailing, 16)
                }
                .padding(.bottom, height * 0.01)
                .frame(height: height * 0.06)
                .background(Color.black)
                Spacer()
            }
        }
    }
    func makeButtonGroupView() -> some View {
        HStack {
            BackButton(
                action: {
                    isPushToElementDetailView = false
                },
                fontWeight: .regular
            )
            .padding(.horizontal, 4)
            Spacer()
            Button {
                viewModel.onClickWikipediaButton()
            } label: {
                Image("wikipedia")
                    .resizable()
                    .renderingMode(.template)
                    .squareFrame(24)
                    .foregroundColor(.white)
            }
            .squareFrame(44)
            .padding(.trailing, 16)
        }
    }

    func makeHeaderView(size: CGSize) -> some View {
        ImageFromUrlView(image: viewModel.element.mainImage.url, isClearBackground: false)
            .frame(width: size.width, height: size.height * 0.34)
            .clipped()
            .overlay {
                ZStack(alignment: .bottomLeading) {
                    Color.c2A323F.opacity(0.3 + (headerOffset / 300))
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            if let tag = viewModel.element.tag {
                                makeNoticeTag(title: tag.getGroupName())
                                    .padding(.bottom, -3)
                                    .opacity(headerOffset > 0 ? 0 : 1)
                            }
                            makeElementTagView(
                                serial: viewModel.element.number,
                                category: viewModel.element.group.getGroupName(),
                                color: .green
                            )
                            .redacted(if: viewModel.isLoading)
                            makeElementTitleView()
                                .offset(y: -size.height * 0.01)
                                .redacted(if: viewModel.isLoading)
                        }
                        .padding(.top, size.height * 0.04)
                    }
                    .padding(.bottom, getSafeArea(edge: .top) / 3)
                }
            }
            .offset(y: getHeaderOffset(height: size.height))
    }

    func makeElementTagView(serial: Int, category: String, color: Color) -> some View {
        HStack(spacing: 12) {
            Text("\(serial)")
                .font(.system(size: 15, weight: .bold))
            Rectangle()
                .fill(Color.white)
                .frame(width: 2)
                .padding(.vertical, 6)
            Text(category.uppercased())
                .font(.system(size: 15, weight: .bold))
        }
        .padding(.leading, 10)
        .padding(.horizontal, 8)
        .foregroundColor(.white)
        .frame(height: 36)
        .background(
            color.cornerRadius(6, corners: [.topRight, .bottomRight])
        )
        .opacity(headerOffset > 0 ? 0 : 1)
    }

    func makeNoticeTag(title: String) -> some View {
        Text(title.uppercased())
            .foregroundColor(.white)
            .font(.system(size: 14, weight: .bold))
            .padding(.vertical, 8)
            .padding(.leading, 10)
            .padding(.horizontal, 10)
            .background(
                Color.c444444.cornerRadius(4, corners: [.topRight, .bottomRight])
            )
    }

    func makeElementTitleView() -> some View {
        HStack(spacing: 24 + (getOffset() > 0 ? 0 : getOffset() / 5.5)) {
            Text(viewModel.element.symbol)
                .font(.system(size: 60, weight: .medium))
                .background(
                    Circle()
                        .fill(Color.green)
                        .squareFrame(88)
                        .opacity(headerOffset > 0 ? 1 : 0)
                )
                .padding(.leading, 32)
                .scaleEffect(1 + (getOffset() > 0 ? 0 : getOffset() / 400))
                .padding(.bottom, getOffset() / 7)
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.element.name)
                    .font(.system(size: 24, weight: .medium))
                Text("\(viewModel.element.atomicMass ?? 0) (g/mol)")
                    .font(.system(size: 16, weight: .medium))
            }
            .scaleEffect(1 + (getOffset() > 0 ? 0 : getOffset() / 1000))
            .padding(.bottom, getOffset() / 7)
            Spacer()
            Button {
                viewModel.onClickCameraButton()
            } label: {
                Image("ic_3d")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
            }
            .unredacted()
            .squareFrame(36)
            .padding(.top, 16)
            .opacity(headerOffset > 0 ? 0 : 1)
        }
        .padding(.leading, getOffset() > 0 ? 0 : -getOffset() / 12)
        .padding(.trailing, 20)
        .foregroundColor(.white)
    }
}

// MARK: - Helper Function
private extension ElementDetailView {
    func getOffset() -> CGFloat {
        let navSize = getScreenBounds().height * 0.28 - getSafeArea(edge: .top)
        return headerOffset > navSize ? -navSize : -headerOffset
    }

    func getHeaderOffset(height: CGFloat) -> CGFloat {
        let navSize = height * 0.28 - getSafeArea(edge: .top)
        let offset = headerOffset > navSize ? -navSize : -headerOffset
        return headerOffset > 0 ? offset : 0
    }

    func getContentOffset(height: CGFloat) -> CGFloat {
        let contentHeight = height * 0.34
        return headerOffset > 0 ? contentHeight : contentHeight + headerOffset
    }
}
