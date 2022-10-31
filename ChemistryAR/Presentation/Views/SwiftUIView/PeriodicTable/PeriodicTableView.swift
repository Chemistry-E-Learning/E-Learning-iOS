//
//  PeriodicTableView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 31/10/2022.
//

import SwiftUI

struct PeriodicTableView: View {
    @Binding var elementList: Matrix<Element>
    @State private var isPushToElementDetailView = false
    @State private var viewState = CGSize.zero
    @State private var selectedElement: Element = emptyElement

    var body: some View {
        GeometryReader { geo in
            ZStack {
                NavigationLink(
                    destination: NavigationLazyView(
                        ElementDetailView(isPushToElementDetailView: $isPushToElementDetailView)
                    ),
                    isActive: $isPushToElementDetailView
                ) {
                    EmptyView()
                }
                VStack(alignment: .leading) {
                    makeToolBarCustomView()
                    ScrollView([.horizontal], showsIndicators: false)  {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 0) {
                                ForEach(0..<18) { index in
                                    Text("\(index + 1)")
                                        .font(.system(size: 16, weight: .medium))
                                        .frame(width: 70, height: 40)
                                        .foregroundColor(.white)
                                        .background(Color.black.opacity(0.7))
                                }
                            }
                            ForEach(0...self.elementList.rows - 1, id: \.self) { i in
                                HStack(alignment: .center, spacing: 0) {
                                    ForEach(0...self.elementList.columns - 1, id: \.self) { j in
                                        Button {
                                            self.selectedElement = self.elementList[i, j]
                                            isPushToElementDetailView = true
                                        } label: {
                                            ElementItemView(element: .constant(self.elementList[i, j]))
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
                        .frame(height: geo.size.height)
                    }
                    .background(Color.c1A1F2C)
                }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct PeriodicTableView_Previews: PreviewProvider {
    static var previews: some View {
        PeriodicTableView(elementList: .constant(PeriodicElementList.readJSONFromFile()?.periodicElementMatrix() ?? PeriodicElementList(elements: []).periodicElementMatrix()))
    }
}

private extension PeriodicTableView {
    func makeToolBarCustomView() -> some View {
        HStack {
            BackButton(action: {
                isPushToElementDetailView = false
            }, fontWeight: .medium, color: .black)
            Spacer()
            Text("Periodic Table")
                .font(.system(size: 22, weight: .medium))
            Spacer()
            Button {
                print("open filter popup")
            } label: {
                Image("filter")
                    .resizable()
                    .renderingMode(.template)
                    .squareFrame(28)
                    .padding(.trailing, 16)
            }
            .foregroundColor(.black)
        }
    }
}
