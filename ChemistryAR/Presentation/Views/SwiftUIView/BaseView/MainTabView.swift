//
//  MainTabView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 04/10/2022.
//

import SwiftUI

struct MainTabView: View {
    @Binding var selectedTab: TabItem
    @Namespace private var animation
    @State private var xAxis: CGFloat = 0
    private let tabs: [TabItem] = [.home, .ar, .lab, .table]

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                Color.red
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(TabItem.home)
                Color.blue
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(TabItem.ar)
                Color.purple
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(TabItem.lab)
                Color.pink
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(TabItem.table)
            }
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { tab in
                    GeometryReader { geo in
                        Button {
                            withAnimation(.spring()) {
                                selectedTab = tab
                                xAxis = geo.frame(in: .global).minX
                            }
                        } label: {
                            Image("\(tab)")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(selectedTab == tab ? .red : .gray)
                                .padding(selectedTab == tab ? 16 : 0)
                                .background(Color.white.opacity(selectedTab == tab ? 1 : 0))
                                .matchedGeometryEffect(id: tab, in: animation)
                                .clipShape(Circle())
                                .offset(
                                    x: selectedTab == tab ? geo.frame(in: .global).minX - geo.frame(in: .global).midX : 0,
                                    y: selectedTab == tab ? -50 : 0
                                )

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
            .background(Color.white.clipShape(
                CustomShape(xAxis: xAxis)).cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .padding(.bottom, 20)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(selectedTab: .constant(.home))
    }
}

enum TabItem: String {
    case home
    case ar
    case lab
    case table
}

struct CustomShape: Shape {
    var xAxis: CGFloat
    var animatableData: CGFloat {
        get {
            return xAxis
        }
        set {
            xAxis = newValue
        }
    }

    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))

            let center = xAxis
            path.move(to: CGPoint(x: center - 50, y: 0))

            let startPoint = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)

            let endPoint = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)

            path.addCurve(to: startPoint, control1: control1, control2: control2)
            path.addCurve(to: endPoint, control1: control3, control2: control4)
        }
    }
}
