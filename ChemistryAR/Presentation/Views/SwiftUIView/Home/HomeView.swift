//
//  HomeView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 09/10/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    private let branchColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                navigationLinkGroup
                VStack(alignment: .leading, spacing: 0) {
                    HeaderView(isPushToUserSettingView: $viewModel.isPushToUserSettingView)
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 12) {
                            makeProgramCarouselView(geo: geo)
                            branchOfChemistryView
                            makeNewsCarouselView(geo: geo)
                            lawOfChemistryView
                                .padding(.top, 28)
                                .padding(.bottom, getSafeArea(edge: .bottom) + 72)
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
    var navigationLinkGroup: some View {
        ZStack {
            NavigationLink(
                destination: NavigationLazyView(
                    ChaptersListView(
                        isPushToChaptersListView: $viewModel.isPushToChaptersListView,
                        program: viewModel.program,
                        videosNumber: viewModel.videoNumber
                    )
                ),
                isActive: $viewModel.isPushToChaptersListView
            ) {
                EmptyView()
            }
            NavigationLink(
                destination: NavigationLazyView(
                    ChemistryBranchesView(
                        isPushToBranchesView: $viewModel.isPushToBranchesView,
                        seriesID: viewModel.seriesID
                    )
                ),
                isActive: $viewModel.isPushToBranchesView
            ) {
                EmptyView()
            }
            NavigationLink(
                destination: NavigationLazyView(
                    ChemistryNewsDetailView(
                        isPushToNewsDetailView: $viewModel.isPushToNewsDetailView,
                        newsID: viewModel.newsID
                    )
                ),
                isActive: $viewModel.isPushToNewsDetailView
            ) {
                EmptyView()
            }
            NavigationLink(
                destination: NavigationLazyView(
                    ChemistryLawsView(
                        isPushToLawsView: $viewModel.isPushToLawsView,
                        seriesID: viewModel.seriesID
                    )
                ),
                isActive: $viewModel.isPushToLawsView
            ) {
                EmptyView()
            }
            NavigationLink(
                destination: NavigationLazyView(
                    UserSettingView(isPushToUserSettingView: $viewModel.isPushToUserSettingView)
                ),
                isActive: $viewModel.isPushToUserSettingView
            ) {
                EmptyView()
            }
        }
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
            makeTitleView(title: Localization.classProgramTitle.localizedString)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(viewModel.programSeries) { item in
                        GeometryReader { geo in
                            ProgramItemView(
                                program: item,
                                videoNumber: 40
                            )
                                .onTapGesture {
                                    viewModel.onClickProgramItemView(program: item, videosNumber: 40)
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

    func makeNewsCarouselView(geo: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: 32) {
            makeTitleView(title: Localization.newsChemistryTitle.localizedString)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.chemistryNews) { item in
                        CarouselItemView(model: item, size: geo.size)
                            .onTapGesture {
                                viewModel.onClickNewsItemView(id: item.id)
                            }
                    }
                }
                .padding(.horizontal, 20)
            }
            .frame(height: 220)
        }
        .padding(.top, 24)
    }

    var branchOfChemistryView: some View {
        VStack(alignment: .leading, spacing: 20) {
            makeTitleView(title: Localization.branchesOfChemistryTitle.localizedString)
            LazyVGrid(columns: branchColumns, spacing: 20) {
                ForEach(viewModel.branchSeries) { item in
                    BranchItemView(branch: item)
                        .frame(height: 216)
                        .onTapGesture {
                            viewModel.onClickBranchItemView(id: item.id)
                        }
                }
            }
            .padding(.horizontal, 20)
        }
    }

    var lawOfChemistryView: some View {
        VStack(alignment: .leading, spacing: 8) {
            makeTitleView(title: Localization.chemistryLawsTitle.localizedString)
                .padding(.bottom, 12)
            ForEach(viewModel.lawSeries) { item in
                LawItem(law: item)
                    .onTapGesture {
                        viewModel.onClickLawItemView(id: item.id)
                    }
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
