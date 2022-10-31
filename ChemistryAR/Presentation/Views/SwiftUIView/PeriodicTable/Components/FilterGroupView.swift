//
//  FilterGroupView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 31/10/2022.
//

import SwiftUI

struct FilterGroupView: View {
    @Binding var isShowFilterView: Bool
    @Binding var groupSelected: ElementGroup

    private let elementGroups: [ElementGroup] = [
        .initial,
        .diatomicNonMetal,
        .polyatomicNonMetal,
        .alkali,
        .alkaliEarth,
        .transitionMetal,
        .postTransitionMetal,
        .metalloid,
        .halogen,
        .noble,
        .lanthanoid,
        .actinide
    ]
    private let columns = [
            GridItem(.flexible(), spacing: 0),
            GridItem(.flexible(), spacing: 0)
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text("Nhóm Nguyên Tố")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .medium))
                    .frame(height: 64)
                Spacer()
            }
            Rectangle()
                .fill(Color.gray)
                .frame(width: .infinity, height: 0.5)
                .offset(y: -3)
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(Array(elementGroups.enumerated()), id: \.offset) { index, group in
                    VStack {
                        makeElementGroupItemView(group: group, index: index)
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: .infinity, height: 0.5)
                    }
                }
            }
        }
        .frame(height: getScreenBounds().height * 0.46)
        .background(
            Color.c1A1F2C
        )
        .cornerRadius(12)
        .padding(.horizontal, getScreenBounds().width * 0.1)
    }
}

struct FilterGroupView_Previews: PreviewProvider {
    static var previews: some View {
        FilterGroupView(isShowFilterView: .constant(false), groupSelected: .constant(.diatomicNonMetal))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(
                ZStack {
                    Color.c1A1F2C
                    Color.black.opacity(0.4)
                }
            )
    }
}

private extension FilterGroupView {
    func makeElementGroupItemView(group: ElementGroup, index: Int) -> some View {
        Button {
            groupSelected = group
            isShowFilterView = false
        } label: {
            HStack {
                Circle()
                    .fill(group.getColor())
                    .squareFrame(10)
                Text(group.getGroupName())
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Spacer()
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 0.5, height: 64)
                    .opacity(index.isMultiple(of: 2) ? 1 : 0)
            }
            .padding(.leading, 20)
            .frame(height: 52)
        }
    }
}
