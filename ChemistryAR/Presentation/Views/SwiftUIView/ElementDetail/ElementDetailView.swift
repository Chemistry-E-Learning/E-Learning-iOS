//
//  ElementDetailView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 29/10/2022.
//

import SwiftUI

struct ElementDetailView: View {
    @Binding var isPushToElementDetailView: Bool
    @State private var headerOffset = CGFloat.zero
    @State private var stickerSize = CGFloat.zero
    @State private var isShowWikipedia = false

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                NavigationLink(
                    destination: NavigationLazyView(
                        ElementWikipediaView(isPushToWikipediaView: $isShowWikipedia)
                    ),
                    isActive: $isShowWikipedia
                ) {
                    EmptyView()
                }
                makeButtonGroupView()
                    .padding(.top, getSafeArea(edge: .top) - 12)
                    .zIndex(2)
                makeHeaderView(size: geo.size)
                    .zIndex(1)
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(0..<10) { index in
                            ElementSectionView(parentSize: geo.size)
                                .padding(.bottom, index == 3 ? 28 : 0)
                        }
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
            }

        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ElementDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ElementDetailView(isPushToElementDetailView: .constant(false))
    }
}

private extension ElementDetailView {
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
                isShowWikipedia = true
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
        Image("nitrogen")
            .resizable()
            .scaledToFill()
            .overlay {
                ZStack(alignment: .topLeading) {
                    Color.c2A323F.opacity(0.3 + (headerOffset / 300))
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            makeNoticeTag(title: "Phóng Xạ")
                                .padding(.bottom, -3)
                                .opacity(headerOffset > 0 ? 0 : 1)
                            makeElementTagView(serial: 35, category: "Halogen", color: .green)
                            makeElementTitleView()
                                .offset(y: -size.height * 0.01)
                        }
                        .padding(.top, size.height * 0.04)
                    }
                    .offset(y: getSafeArea(edge: .top) + size.height * 0.12)
                }
            }
            .frame(width: size.width, height: size.height * 0.34)
            .clipped()
            .offset(y: getHeaderOffset(height: size.height))
    }

    func makeElementTagView(serial: Int, category: String, color: Color) -> some View {
        HStack(spacing: 12) {
            Text("\(serial)")
                .font(.system(size: 15, weight: .bold))
            Rectangle()
                .fill(Color.white)
                .frame(width: 2, height: .infinity)
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
        HStack(spacing: 24 + (stickerSize > 0 ? 0 : stickerSize / 5.5)) {
            Text("Br")
                .font(.system(size: 60, weight: .medium))
                .background(
                    Circle()
                        .fill(Color.green)
                        .squareFrame(88)
                        .opacity(headerOffset > 0 ? 1 : 0)
                )
                .padding(.leading, 32)
                .scaleEffect(1 + (stickerSize > 0 ? 0 : stickerSize / 400))
                .padding(.bottom, stickerSize / 7)
            VStack(alignment: .leading, spacing: 4) {
                Text("Brom")
                    .font(.system(size: 24, weight: .medium))
                Text("\(79904) (g/mol)")
                    .font(.system(size: 16, weight: .medium))
            }
            .scaleEffect(1 + (stickerSize > 0 ? 0 : stickerSize / 1000))
            .padding(.bottom, stickerSize / 7)
            Spacer()
            Button {
                print("Open AR View")
            } label: {
                Image(systemName: "camera.viewfinder")
                    .font(.system(size: 32, weight: .medium))
            }
            .squareFrame(44)
            .padding(.top, 16)
            .opacity(headerOffset > 0 ? 0 : 1)
        }
        .padding(.leading, stickerSize > 0 ? 0 : -stickerSize / 12)
        .padding(.trailing, 20)
        .foregroundColor(.white)
    }
}

// MARK: - Helper Function
private extension ElementDetailView {
    func getHeaderOffset(height: CGFloat) -> CGFloat {
        let navSize = height * 0.28 - getSafeArea(edge: .top)
        stickerSize = headerOffset > navSize ? -navSize : -headerOffset
        return headerOffset > 0 ? stickerSize : 0
    }

    func getContentOffset(height: CGFloat) -> CGFloat {
        let contentHeight = height * 0.34
        return headerOffset > 0 ? contentHeight : contentHeight + headerOffset
    }
}
