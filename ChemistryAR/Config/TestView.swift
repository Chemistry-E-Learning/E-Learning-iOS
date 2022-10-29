//
//  TestView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 19/10/2022.
//

import SwiftUI

struct DemoScrollViewOffsetView: View {
    @State private var offset = CGFloat.zero
    var body: some View {
        ScrollView {
            Rectangle()
                .squareFrame(400)
                .background(
                    GeometryReader {
                        Color.clear.preference(
                            key: ViewOffsetKey.self,
                            value: -$0.frame(in: .named("scroll")).origin.y
                        )
                    }
                )
            VStack {
                ForEach(0..<100) { i in
                    Text("Item \(i)").padding()
                }
            }
            .background(Color.red)
        }
        .onPreferenceChange(ViewOffsetKey.self) {
            print("offset >> \($0)")
        }
        .coordinateSpace(name: "scroll")
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
