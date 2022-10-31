//
//  ElementItemView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 31/10/2022.
//

import SwiftUI

struct ElementItemView: View {
    @Binding var element: Element
    @Binding var groupSelected: ElementGroup

    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 4) {
                if element.isValid() {
                    Text("\(element.number)")
                        .font(.system(size: 8, weight: .medium))
                        .lineLimit(1)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: 8,
                            alignment: .topLeading
                        )
                        .padding(4)
                }
                Text(element.symbol)
                    .font(.system(size: 26))
                    .bold()
                    .lineLimit(1)
                Text(element.name)
                    .font(.system(size: 9, weight: .medium))
                    .lineLimit(1)
            }
            .foregroundColor(.white)
        }
        .squareFrame(70)
        .background(
            groupSelected == .initial
            ? element.getColor()
            : element.getGroup() == groupSelected
            ? groupSelected.getColor()
            : element.isValid()
            ? Color.c444444
            : .clear
        )
    }
}

struct ElementItemView_Previews: PreviewProvider {
    static var previews: some View {
        PeriodicTableView(
            elementList: .constant(PeriodicElementList.readJSONFromFile()?.periodicElementMatrix() ?? PeriodicElementList(elements: []).periodicElementMatrix())
        )
    }
}
