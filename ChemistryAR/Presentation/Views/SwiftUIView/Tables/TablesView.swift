//
//  TablesView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 18/11/2022.
//

import SwiftUI

struct TablesView: View {
    @Binding var selectedTab: TabItem
    @State private var isShowSideBar = false
    @State private var index = 0
    @State private var isShowFilterView = false
    @State private var isShowInformationSheet = false
    @State private var isShowWikipediaView = false

    var body: some View {
        ZStack {
            VStack {
                ToolBarCustomView(
                    title: getNavigationTitle(),
                    rightButtonImage: getRightButtonImage(),
                    leftButtonAction: {
                        isShowSideBar.toggle()
                    },
                    rightButtonAction: {
                        getRightAction()
                    }
                )
                getMainContent()
            }
            if isShowSideBar {
                SideBarView(index: $index, isShowSideBar: $isShowSideBar)
                    .background(
                        Color.black.opacity(0.3)
                            .onTapGesture {
                                isShowSideBar = false
                            }
                    )
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .onChange(of: index) { newValue in
            if newValue == -1 {
                selectedTab = .home
            }
        }
    }
}

private extension TablesView {
    @ViewBuilder func getMainContent() -> some View{
        switch index {
        case 0:
            PeriodicTableView(isShowFilterView: $isShowFilterView)
        case 1:
            SolubilityTableView(isShowInformationSheet: $isShowInformationSheet)
        case 2:
            ElectrochemicalSeriesView()
        case 3:
            AnkanPropertiesView()
        case 4:
            HydrocarbonChainView(isShowWikipediaView: $isShowWikipediaView)
        default:
            EmptyView()
        }
    }
}

// MARK: - Helper Function
private extension TablesView {
    func getNavigationTitle() -> String {
        switch index {
        case 0:
            return Localization.periodicTableTitle.localizedString
        case 1:
            return Localization.solubilityTableTitle.localizedString
        case 2:
            return Localization.electrochemicalSeriesTitle.localizedString
        case 3:
            return Localization.alkanePropertiesTitle.localizedString
        case 4:
            return Localization.hydrocarbonChainTitle.localizedString
        default:
            return "Tables"
        }
    }

    func getRightAction() {
        switch index {
        case 0:
            isShowFilterView = true
        case 4:
            isShowWikipediaView = true
        default:
            return
        }
    }

    func getRightButtonImage() -> String {
        switch index {
        case 0:
            return "filter"
        case 4:
            return "wikipedia"
        default:
            return ""
        }
    }
}
