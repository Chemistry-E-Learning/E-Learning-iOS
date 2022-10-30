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

    var body: some View {
        GeometryReader { geo in
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
                }
            }
            .onPreferenceChange(ViewOffsetKey.self) {
                headerOffset = $0
            }
            .coordinateSpace(name: "scroll")
        }
        .ignoresSafeArea()
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
                print("Open wikipedia")
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
                    Color.black.opacity(0.3)
                    VStack(alignment: .leading) {
                        makeButtonGroupView()
                        VStack(alignment: .leading) {
                            makeNoticeTag(title: "Phóng Xạ")
                                .padding(.bottom, -3)
                            makeElementTagView(serial: 35, category: "Halogen", color: .green)
                            makeElementTitleView()
                                .offset(y: -size.height * 0.01)
                        }
                        .padding(.top, size.height * 0.04)
                    }
                    .offset(y: getSafeArea(edge: .top) + size.height * 0.06)
                }
            }
            .frame(width: size.width, height: size.height * 0.34)
            .clipped()
            .offset(y: (headerOffset < 0 ? headerOffset : 0))
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
        HStack(spacing: 24) {
            Text("Br")
                .font(.system(size: 60, weight: .medium))
                .padding(.leading, 32)
            VStack(alignment: .leading, spacing: 4) {
                Text("Brom")
                    .font(.system(size: 24, weight: .medium))
                Text("\(79904) (g/mol)")
                    .font(.system(size: 16, weight: .medium))
            }
            Spacer()
            Button {
                print("Open AR View")
            } label: {
                Image(systemName: "camera.viewfinder")
                    .font(.system(size: 32, weight: .medium))
            }
            .squareFrame(44)
            .padding(.top, 16)
        }
        .padding(.trailing, 20)
        .foregroundColor(.white)
    }
}
