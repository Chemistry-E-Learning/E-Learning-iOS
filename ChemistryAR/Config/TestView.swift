//
//  TestView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 19/10/2022.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack(alignment: .leading) {
            makeSectionHeaderView(image: "flask", title: "Tính Chất")
                .padding(.bottom, 8)
            ForEach(0..<4) { _ in
                makeSectionRowView(title: "Số Nguyên Tử", desc: "20")
            }
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

private extension TestView {
    func makeSectionHeaderView(image: String, title: String) -> some View {
        HStack {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .squareFrame(36)
            Text(title)
                .font(.system(size: 18, weight: .medium))
            Spacer()
        }
        .padding(.horizontal, 12)
        .frame(height: 68)
        .foregroundColor(.white)
        .background(Color.c2A323F.opacity(0.9))
    }
    
    func makeSectionRowView(title: String, desc: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(title):")
                .font(.system(size: 14))
                .foregroundColor(.black.opacity(0.7))
            Text(desc)
                .font(.system(size: 16))
            Rectangle()
                .fill(.black.opacity(0.4))
                .frame(width: .infinity, height: 1)
                .padding(.top, 6)
        }
        .padding(.horizontal, 32)
        .padding(.top, 4)
    }
}
