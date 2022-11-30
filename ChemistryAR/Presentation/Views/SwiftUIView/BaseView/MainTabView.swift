//
//  MainTabView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 04/10/2022.
//

import SwiftUI

enum TabItem: String {
    case home
    case ar
    case lab
    case table
}

struct MainTabView: View {
    @Binding var selectedTab: TabItem
    @Namespace private var animation
    @State private var xAxis: CGFloat = 0
    private let tabs: [TabItem] = [.home, .ar, .lab, .table]

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            if selectedTab == .home {
                HomeView()
            } else if selectedTab == .ar {
                ElementCardTrackingView()
                    .ignoresSafeArea(.all, edges: .all)
            } else if selectedTab == .lab {
                VirtualLabView(selectedTab: $selectedTab)
                    .ignoresSafeArea(.all, edges: .all)
            } else {
                TablesView(selectedTab: $selectedTab)
            }
            if selectedTab != .lab && selectedTab != .table {
                tabArea
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

private extension MainTabView {
    var tabArea: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { tab in
                GeometryReader { geo in
                    Button {
                        withAnimation(.spring()) {
                            selectedTab = tab
                            xAxis = geo.frame(in: .global).minX
                        }
                    } label: {
                        if selectedTab == tab {
                            makeTabItem(tab: tab)
                                .clipShape(Circle())
                                .offset(
                                    x: geo.frame(in: .global).minX - geo.frame(in: .global).midX,
                                    y: -50
                                )
                        } else {
                            makeTabItem(tab: tab)
                        }
                    }
                    .onAppear {
                        if tab == tabs.first {
                            xAxis = geo.frame(in: .global).minX
                        }
                    }
                }
                .frame(width: 25, height: 30)
                if tab != tabs.last {
                    Spacer(minLength: 0)
                }
            }
        }
        .padding(.horizontal, 28)
        .padding(.vertical)
        .background(
            Color.white
                .clipShape(
                    CustomShape(xAxis: xAxis)
                )
                .cornerRadius(12)
        )
        .shadow(color: Color.cE1E1E1, radius: 8, x: 2, y: 2)
        .padding(.horizontal)
        .padding(.bottom, getSafeArea(edge: .bottom))
    }

    func makeTabItem(tab: TabItem) -> some View {
        Image("\(tab)")
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .squareFrame(25)
            .foregroundColor(selectedTab == tab ? .red : .gray)
            .padding(selectedTab == tab ? 16 : 0)
            .background(
                Color.white.opacity(selectedTab == tab ? 1 : 0)
            )
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(selectedTab: .constant(.home))
    }
}
