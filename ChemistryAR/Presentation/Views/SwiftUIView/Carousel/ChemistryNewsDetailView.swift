//
//  ChemistryNewsDetailView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 05/12/2022.
//

import SwiftUI

struct ChemistryNewsDetailView: View {
    @StateObject private var viewModel: CarouselsViewModel
    @Binding var isPushToNewsDetailView: Bool
    @State private var contentHeight = CGFloat.zero
    @State private var headerOffset = CGFloat.zero
    @State private var isWebViewLoading = true

    init(isPushToNewsDetailView: Binding<Bool>, newsID: String) {
        _isPushToNewsDetailView = isPushToNewsDetailView
        _viewModel = .init(wrappedValue: CarouselsViewModel(id: newsID))
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                if viewModel.isLoading {
                    NewsContentHolder()
                } else if viewModel.news.externalLink.isEmpty {
                    makeNormalContent(geo: geo)
                } else {
                    ZStack {
                        externalWebView
                        NewsContentHolder()
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                                    isWebViewLoading = false
                                }
                            }
                            .opacity(isWebViewLoading ? 1 : 0)
                    }
                }
            }
        }
        .ignoresSafeArea(.all)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension ChemistryNewsDetailView {
    func makeNormalContent(geo: GeometryProxy) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                ZStack(alignment: .topLeading) {
                    ImageFromUrlView(image: viewModel.news.mainImageURL, isClearBackground: false)
                        .frame(width: geo.size.width, height: geo.size.height * 0.3)
                    BackCircleButton {
                        isPushToNewsDetailView = false
                    }
                    .padding(.top, getSafeArea(edge: .top) + 20)
                    .padding(.leading, 28)
                }
            }
            VStack(alignment: .leading) {
                Text(viewModel.news.title)
                    .font(.system(size: 22, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .padding(.top, 12)
                    .padding(.bottom, 4)
                authorView
                    .padding(.bottom, 12)
                Divider()
                    .padding(.horizontal, 4)
                WebView(
                    contentHeight: $contentHeight,
                    isLoading: $isWebViewLoading,
                    type: .normal,
                    url: viewModel.news.content
                )
                .frame(height: contentHeight)
                .padding(.top, -12)
            }
            .padding(.horizontal, 16)
        }
    }

    var authorView: some View {
        Text("By ")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.black.opacity(0.7))
        +
        Text(viewModel.news.author)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(Color(hex: 0xFE5C01))
        +
        Text(" | November 28, 2022")
            .foregroundColor(.black.opacity(0.7))
            .font(.system(size: 14, weight: .medium))
    }

    var externalWebView: some View {
        ZStack(alignment: .topLeading) {
            WebView(
                contentHeight: .constant(0),
                isLoading: $isWebViewLoading,
                type: .external,
                url: viewModel.news.externalLink
            )
            BackCircleButton {
                isPushToNewsDetailView = false
            }
            .padding(.top, getSafeArea(edge: .top) + 20)
            .padding(.leading, 28)
        }
    }
}
