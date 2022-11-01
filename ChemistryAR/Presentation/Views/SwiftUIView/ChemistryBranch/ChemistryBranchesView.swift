//
//  ChemistryBranchesView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 25/10/2022.
//

import SwiftUI

struct ChemistryBranchesView: View {
    @Binding var isPushToBranchesView: Bool
    @State private var isPushToLessonDetail = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                NavigationLink(
                    destination: NavigationLazyView(
                        LessonDetailView(isPushToLessonDetailView: $isPushToLessonDetail)
                    ),
                    isActive: $isPushToLessonDetail
                ) {
                    EmptyView()
                }
                HeaderListCustomView(
                    isPushToCurrentView: $isPushToBranchesView,
                    parentHeight: geo.size.height
                )
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(0..<10) { _ in
                            BranchLessonItemView()
                                .onTapGesture {
                                    isPushToLessonDetail = true
                                }
                        }
                    }
                    .padding(.bottom, geo.size.height * 0.38)
                }
                .offset(y: geo.size.height * 0.34)
                .padding(.horizontal, 20)
            }
        }
        .ignoresSafeArea(.all)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct ChemistryBranchesView_Previews: PreviewProvider {
    static var previews: some View {
        ChemistryBranchesView(isPushToBranchesView: .constant(false))
    }
}
