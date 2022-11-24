//
//  TestView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 23/11/2022.
//

import SwiftUI
import SceneKit

struct TestView: View {
    @Binding var models: [Element3DModel]
    @State private var model: Element3DModel = Element3DModel.dummyData[0]
    @State private var index = 0
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottom) {
                    CustomSceneView(model: $model)
                        .frame(height: geo.size.height * 0.28)
                        .background(Color.black)
                }
                .onChange(of: index) { _ in
                    if index >= 0 && index < models.count {
                        model = models[index]
                    }
                }
                HStack {
                    Spacer()
                    ControlButtonGroup(index: $index, dataCount: models.count)
                        .scaleEffect(0.7)
                    Spacer()
                }
                .frame(height: geo.size.height * 0.08)
                .background(Color.black)
                Spacer()
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(models: .constant(Element3DModel.dummyData))
    }
}
