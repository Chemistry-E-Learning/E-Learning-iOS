//
//  HomeView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 09/10/2022.
//

import SwiftUI

struct HomeView: View {
    @State private var isPushToChaptersListView = false
    @State private var isPushToBranchesView = false

    let branchColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                NavigationLink(
                    destination: NavigationLazyView(
                        ChaptersListView(isPushToChaptersListView: $isPushToChaptersListView)
                    ),
                    isActive: $isPushToChaptersListView
                ) {
                    EmptyView()
                }
                NavigationLink(
                    destination: NavigationLazyView(
                        ChemistryBranchesView(isPushToBranchesView: $isPushToBranchesView)
                    ),
                    isActive: $isPushToBranchesView
                ) {
                    EmptyView()
                }
                VStack {
                    HeaderView()
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 12) {
                            makeProgramCarouselView(geo: geo)
                            branchOfChemistryView
                            lawOfChemistryView
                                .padding(.top, 28)
                        }
                    }
                }
            }
        }
         .background(
            Color.cE1E1E1.opacity(0.3)
                .ignoresSafeArea(.all, edges: .all)
        )
    }
}

private extension HomeView {
    func makeTitleView(title: String) -> some View {
        Text(title)
            .padding(.horizontal, 20)
            .font(.system(size: 28, weight: .semibold))
    }

    func makeProgramCarouselView(geo: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: -28) {
            makeTitleView(title: "Class Programs")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(0..<5) { _ in
                        GeometryReader { geo in
                            ProgramItemView()
                                .onTapGesture {
                                    isPushToChaptersListView = true
                                }
                                .rotation3DEffect(
                                    Angle(degrees: Double(geo.frame(in: .global).minX) - 40) / -20,
                                    axis: (x: 0, y: 10.0, z: 0))
                        }
                        .frame(width: 300)
                    }
                }
                .padding(.horizontal, 20)
            }
            .frame(width: getScreenBounds().width, height: geo.size.height * 0.4)
        }
    }

    var branchOfChemistryView: some View {
        VStack(alignment: .leading, spacing: 20) {
            makeTitleView(title: "Branches Of Chemistry")
            LazyVGrid(columns: branchColumns, spacing: 20) {
                ForEach(0..<6, id: \.self) { _ in
                    BranchItemView()
                        .frame(height: 216)
                        .onTapGesture {
                            isPushToBranchesView = true
                        }
                }
            }
            .padding(.horizontal, 20)
        }
    }

    var lawOfChemistryView: some View {
        VStack(alignment: .leading, spacing: 8) {
            makeTitleView(title: "Chemistry Laws")
                .padding(.bottom, 12)
            ForEach(0..<6) { _ in
                LawItem()
            }
            .padding(.horizontal, 20)
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
