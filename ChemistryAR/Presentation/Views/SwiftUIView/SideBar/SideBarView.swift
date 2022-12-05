//
//  SideBarView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 18/11/2022.
//

import SwiftUI

struct SideBarView: View {
    @Binding var index: Int
    @Binding var isShowSideBar: Bool

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                Text(Localization.chemistryTablesTitle.localizedString)
                    .foregroundColor(.black.opacity(0.9))
                    .font(.system(size: 24, weight: .medium))
                    .padding(.leading, 20)
                Divider()
                VStack(alignment: .leading, spacing: 40) {
                    Button(action: {
                        index = 0
                        isShowSideBar = false
                    }) {
                        TabItemView(image: "table", title: Localization.periodicTableTitle.localizedString, color: self.index == 0 ? Color.red : Color.black)
                            .foregroundColor(self.index == 0 ? Color.red : Color.black)
                    }
                    Button(action: {
                        index = 1
                        isShowSideBar = false
                    }) {
                        TabItemView(image: "solub", title: Localization.solubilityTableTitle.localizedString, color: self.index == 1 ? Color.red : Color.black)
                            .foregroundColor(self.index == 1 ? Color.red : Color.black)
                    }
                    Button(action: {
                        index = 2
                        isShowSideBar = false
                    }) {
                        TabItemView(image: "ion", title: Localization.electrochemicalSeriesTitle.localizedString, color: self.index == 2 ? Color.red : Color.black)
                            .foregroundColor(self.index == 2 ? Color.red : Color.black)
                    }
                    Button(action: {
                        index = 3
                        isShowSideBar = false
                    }) {
                        TabItemView(image: "methane", title: Localization.alkanePropertiesTitle.localizedString, color: self.index == 3 ? Color.red : Color.black)
                            .foregroundColor(self.index == 3 ? Color.red : Color.black)
                    }
                    Button(action: {
                        index = 4
                        isShowSideBar = false
                    }) {
                        TabItemView(image: "organic", title: Localization.hydrocarbonChainTitle.localizedString, color: self.index == 4 ? Color.red : Color.black)
                            .foregroundColor(self.index == 4 ? Color.red : Color.black)
                    }
                    Spacer()
                    Button(action: {
                        index = -1
                        isShowSideBar = false
                    }) {
                        TabItemView(image: "home", title: "Home", color: self.index == -1 ? Color.red : Color.black)
                            .foregroundColor(self.index == -1 ? Color.red : Color.black)
                    }
                    .padding(.bottom, getSafeArea(edge: .bottom) + 60)
                }
                .padding(.top, 20)
                .padding(.leading, 20)
                Spacer()
            }
            .offset(y: getSafeArea(edge: .top))
            .frame(width: geo.size.width * 0.6, height: geo.size.height)
            .background(Color.white)
        }
        .edgesIgnoringSafeArea(.all)

    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView(index: .constant(0), isShowSideBar: .constant(true))
    }
}

struct TabItemView: View {
    let image: String
    let title: String
    let color: Color

    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(color)
                .squareFrame(24)
                .padding(.trailing, 8)
            Text(title)
                .font(.subheadline)
        }
    }
}
