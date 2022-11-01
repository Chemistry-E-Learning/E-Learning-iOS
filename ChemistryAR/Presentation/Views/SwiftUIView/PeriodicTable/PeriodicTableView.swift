//
//  PeriodicTableView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 31/10/2022.
//

import SwiftUI

struct PeriodicTableView: View {
    @Binding var isPushToPeriodicTableView: Bool
    @Binding var elementList: Matrix<Element>
    @State private var isPushToElementDetailView = false
    @State private var isShowFilterView = false
    @State private var viewState = CGSize.zero
    @State private var selectedElement = Element.emptyElement
    @State private var groupSelected = ElementGroup.initial

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
                    ToolBarCustomView(
                        isPushToCurrentView: $isPushToPeriodicTableView,
                        title: Localization.periodicTableTitle.localizedString,
                        rightButtonImage: "filter",
                        rightButtonAction: {
                            isShowFilterView = true
                        }
                    )
                    makePeriodicTableView(height: geo.size.height)
                }
                makeFilterViewOverlay(height: geo.size.height)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
}

struct PeriodicTableView_Previews: PreviewProvider {
    static var previews: some View {
        PeriodicTableView(
            isPushToPeriodicTableView: .constant(false),
            elementList: .constant(PeriodicElementList.readJSONFromFile()?.periodicElementMatrix() ?? PeriodicElementList(elements: []).periodicElementMatrix())
        )
    }
}

// MARK: - Functions View
private extension PeriodicTableView {
    @ViewBuilder func makeFilterViewOverlay(height: CGFloat) -> some View {
        if isShowFilterView {
            Color.white.opacity(0.2)
                .onTapGesture {
                    isShowFilterView = false
                }
            FilterGroupView(
                isShowFilterView: $isShowFilterView,
                groupSelected: $groupSelected
            )
            .offset(y: -height * 0.08)
        }
    }

    func makePeriodicTableView(height: CGFloat) -> some View {
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
                ForEach(0...elementList.rows - 1, id: \.self) { i in
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(0...elementList.columns - 1, id: \.self) { j in
                            Button {
                                selectedElement = elementList[i, j]
                                isPushToElementDetailView = true
                            } label: {
                                ElementItemView(
                                    element: .constant(elementList[i, j]),
                                    groupSelected: $groupSelected
                                )
                            }
                        }
                    }
                }
                Spacer()
            }
            .frame(height: height)
        }
        .background(
            Color.c1A1F2C
        )
    }
}
